#!/usr/bin/env bash
set -e
set -o pipefail

# Download Kotlin/Native sources
git submodule update --init --recursive

# Download and build all of the dependencies required by Kotlin/Native
cd KotlinNative
./gradlew dependencies:update

# Build Kotlin/Native toolchain
./gradlew cross_dist

# Go back to the root directory
cd ..