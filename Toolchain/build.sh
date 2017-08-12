#!/usr/bin/env bash
set -e
set -o pipefail

KOTLIN_HOME=../KotlinNative
DIR=.
PATH=$KOTLIN_HOME/dist/bin:$PATH
PATH=$KOTLIN_HOME/bin:$PATH
PATH=$KOTLIN_HOME/dist/dependencies/clang-llvm-3.9.0-darwin-macos/bin/:$PATH
TARGET=iphone

# Compile Kotlin code to LLVM bytecode
echo "Compiling Kotlin Code"
konanc \
    -target $TARGET \
    -nomain \
    -produce bitcode \
    $DIR/kotlin.kt -o kotlin.bc

# Compile C++ Launcher to LLVM bytecode
echo "Compiling C++ Code"
clang++ \
    -std=c++11 \
    -stdlib=libc++ \
    -miphoneos-version-min=8.0.0 \
    -arch arm64 \
    -I $KOTLIN_HOME/common/src/hash/headers \
    -I $KOTLIN_HOME/runtime/src/main/cpp/ \
    -isysroot $KOTLIN_HOME/dist/dependencies/target-sysroot-2-darwin-ios \
    -c \
    -emit-llvm \
    launcher.cpp

# Link everything together
echo "Linking"
llvm-lto \
    -o kotlin.o \
    -exported-symbol=_kotlin_wrapper \
    -exported-symbol=_kotlin_main \
    -O1 \
    $KOTLIN_HOME/dist/klib/stdlib/targets/iphone/kotlin/program.kt.bc \
    $KOTLIN_HOME/dist/klib/stdlib/targets/iphone/native/runtime.bc \
    kotlin.bc launcher.bc 

# Convert the object file to a static library
echo "Bundling as a library"
libtool -static kotlin.o -o kotlin.a

# Remove Build Artifcats
rm -rf *.bc
rm -rf *.o

# Dump build product information
otool -hv kotlin.a
echo "Library built sucessfully"