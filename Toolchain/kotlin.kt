import konan.internal.ExportForCppRuntime

@ExportForCppRuntime
fun kotlin_main() : String {
    return "Hello from the other side!"
}