using Pkg
Pkg.add([
    "Bootstrap", # https://juliahub.com/ui/Packages/Bootstrap/0NS1M/
    "Conda", # https://juliahub.com/ui/Packages/Conda/WZE3U/
    "CSV", # https://juliahub.com/ui/Packages/CSV/HHBkp/
    "DataFrames", # https://juliahub.com/ui/Packages/DataFrames/AR9oZ/
    "Distributions", # https://juliahub.com/ui/Packages/Distributions/xILW0/
    "GLM", # https://juliahub.com/ui/Packages/GLM/6OREG/
    "IJulia", # https://juliahub.com/ui/Packages/IJulia/nfu7T/
    "K8sClusterManagers", # https://juliahub.com/ui/Packages/K8sClusterManagers/Vv6vo/
    "LibPQ", # https://juliahub.com/ui/Packages/LibPQ/LeQQU/
    "LinRegOutliers", # https://juliahub.com/ui/Packages/LinRegOutliers/LANxR/
    "Loess", # https://juliahub.com/ui/Packages/Loess/TysgR/
    "MLJ", # https://juliahub.com/ui/Packages/MLJ/rAU56/
    "MLJLinearModels", # https://juliahub.com/ui/Packages/MLJLinearModels/FBSRA/
    "Plots", # https://juliahub.com/ui/Packages/Plots/ld3vC/
    "Pluto", # https://juliahub.com/ui/Packages/Pluto/OJqMt/
    "StatsPlots", # https://juliahub.com/ui/Packages/StatsPlots/SiylL/
    "XLSX" # https://juliahub.com/ui/Packages/XLSX/gPxqz/
])
import Conda
Conda.update()
Conda.add("jupyterlab")
Conda.export_list(expanduser("~/github/spec-file.txt"))
