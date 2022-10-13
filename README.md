## PackageCompiler.jl
Julia uses a just-in-time (JIT) compiler, meaning that computer code execution involves compilation during the program's execution, in other words, at the run time. Since the program is not compiled before the execution, when we call a function for the first time, Julia compiles it, and it may take quite some time to execute it. All following calls within that same session use this fast compiled function. But if we restart Julia, we lose all the compiled work. One way to reduce this latency is to use `PackageCompiler.jl`. It offers three different workflows. In this notebook, we explore the `sysimage` workflow. 

[PackageCompiler.jl documentation](https://julialang.github.io/PackageCompiler.jl/stable/index.html)


## What is a `sysimage`?

A `sysimage` is a file where we can save our loaded packages and compiled functions that we pass to Julia at the startup. In general, we cannot relocate a `sysimage` to another machine. The sysimage will only work on the machine where we created it. If relocation is a priority, then we can use a different workflow that generate a relocatable "app" or we could also create a C library.    
We consider a `sysimage` file as a Julia session serialized to a file. When we start Julia with a `sysimage`, the stored Julia session is deserialized and loaded. By using the `sysimage` file, we expect that this "deserialization" will be faster than having to reload packages and recompile code from scratch.

## Example: MyLineraRegression.jl
Let use an example to demonstrate how to create a `sysimage`.

The module `MyLineraRegression.jl` contains only one function `my_linear_regression` that takes 3 arguments: location of a dataset in CSV format, the name of a predictor, and the name of the response. It reads the dataset as a dataframe and apply a linear regression from the `GLM` package.

To generate the sysimage just start Julia in this directory and run the following command:

```
julia> include("run_compilation.jl")
```

Once the `sysimage` is created, we can assess our gain latency-wise by using simply the following command line:

- Baseline command:
```
TestSysimage/MyLinearRegression$> julia --project myscript.jl X2 Y2
```

- Using sysimage command:
```
TestSysimage/MyLinearRegression$> julia --project --sysimage=MyExampleSysimage.so myscript.jl X2 Y2
```

**NOTES:** Since our example uses a local module (i.e. MyLinearRegression), it is necessary to run those command lines from the MyLinearRegression directory. Otherwise, Julia will not recognize MyLinearRegression package/module. In the case we use a package that belongs to the registry or is included in the Project.toml,   we just have to specify the path of the sysimage and/or the script; the `--project` flag should be removed. 

