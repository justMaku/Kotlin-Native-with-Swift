# Kotlin-Native-with-Swift
Sample project showcasing the Kotlin/Native code running as a library inside of an existing iOS app.

Blog Post detailing the procedure can be found at [justmaku.org](https://justmaku.org/2017-06-07-kotlin-on-ios)

# Preparation
Run [`setup.sh`](setup.sh) script to download and build Kotlin/Native compiler and it's dependencies.

# Compiling Kotlin Code
Modify [`Library/Kotlin.kt`](Library/Kotlin.kt) file and run [`build.sh`](Library/build.sh) script inside of the `Library` directory to produce `kotlin.a` binary.

# Compiling Swift Project
After setting up the toolchain and compiling kotlin library, open `Sample Project\Kotlin Native.xcodeproj` in Xcode 9 (newest beta should work) and run on an 64-bit device (simulators not supported)
