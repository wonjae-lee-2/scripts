using Pkg
Pkg.add([
    "Conda", # https://juliahub.com/ui/Packages/Conda/WZE3U/
    "CSV", # https://juliahub.com/ui/Packages/CSV/HHBkp/
    "DataFrames", # https://juliahub.com/ui/Packages/DataFrames/AR9oZ/
    "Flux", # https://juliahub.com/ui/Packages/Flux/QdkVy/
    "IJulia", # https://juliahub.com/ui/Packages/IJulia/nfu7T/
    "JuMP", # https://juliahub.com/ui/Packages/JuMP/DmXqY/
    "LibPQ", # https://juliahub.com/ui/Packages/LibPQ/LeQQU/
    "ODBC", # https://juliahub.com/ui/Packages/ODBC/ZHXi3/
    "Pluto", # https://juliahub.com/ui/Packages/Pluto/OJqMt/
    "POMDPs", # https://juliahub.com/ui/Packages/POMDPs/GAotg/
    "StatsPlots", # https://juliahub.com/ui/Packages/StatsPlots/SiylL/
    "XLSX" # https://juliahub.com/ui/Packages/XLSX/gPxqz/
])
import Conda
Conda.update()
Conda.add("jupyterlab")
Conda.export_list(joinpath(expanduser(ENV["PROJECT_FOLDER"]), "spec-file.txt"))
