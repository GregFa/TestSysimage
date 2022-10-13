module MyLinearRegression

    using  CSV, DataFrames, GLM, Statistics

    export my_linear_regression

    function my_linear_regression(myfile::String, invar::String, outvar::String )

        df = CSV.read(myfile, DataFrame)

        frml = eval(Meta.parse("@formula($(outvar) ~ $(invar))"))

        linear_regressor = lm(frml, df)

        return linear_regressor
    end

end