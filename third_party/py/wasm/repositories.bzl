"""NumPy headers from the target Python environment."""

def _numpy_headers_impl(ctx):
    directory = ctx.os.environ.get("JAX_WASM_NUMPY_INCLUDE")
    if not directory:
        fail("Set JAX_WASM_NUMPY_INCLUDE to the target NumPy include directory")
    ctx.symlink(directory, "include")
    ctx.file("BUILD.bazel", """
cc_library(
    name = "headers",
    hdrs = glob(["include/numpy/**/*.h"]),
    includes = ["include"],
    visibility = ["//visibility:public"],
)
""")

wasm_numpy_headers = repository_rule(
    implementation = _numpy_headers_impl,
    environ = ["JAX_WASM_NUMPY_INCLUDE"],
)
