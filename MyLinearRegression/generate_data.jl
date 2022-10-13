#= Let create a dummy dataset where the data are generated such that: 

Y1 = b0 +b1X1 + ϵ
Y2 = b0 +b2X2 + ϵ
=#

using CSV, DataFrames, Distributions

b0 = 3;
b1 = 2;
b2 = -1.75;
ϵ = rand(Normal(0, 1), 20);

X1 = abs.(rand(Normal(23, 4), 20));
X2 = abs.(rand(Normal(45, 5), 20));

Y1 = b0 .+ b1.*X1
Y2 = b0 .+ b2.*X2

df = DataFrame(X1 = X1, X2= X2, Y1 = Y1, Y2=Y2);

if [joinpath.(@__DIR__, "data")] ⊈ filter(isdir, joinpath.(@__DIR__, readdir(@__DIR__)))
   mkdir(joinpath(@__DIR__, "data")) 
end

CSV.write(joinpath(@__DIR__, "data/toy_dataset.csv"), df);
