using PackageCompiler, Pkg

cd("MyLinearRegression");

Pkg.activate(".")

PackageCompiler.create_sysimage(:MyLinearRegression;
                                  sysimage_path="MyExampleSysimage.so",
                                  precompile_execution_file="precompiling_script.jl")