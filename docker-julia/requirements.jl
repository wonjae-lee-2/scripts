using Pkg
Pkg.add([
    (name = "Bootstrap", version = "2.3.3"), # https://juliahub.com/ui/Packages/Bootstrap/0NS1M/
    (name = "Conda", version = "1.7.0"), # https://juliahub.com/ui/Packages/Conda/WZE3U/
    (name = "CSV", version = "0.10.4"), # https://juliahub.com/ui/Packages/CSV/HHBkp/
    (name = "DataFrames", version = "1.3.4"), # https://juliahub.com/ui/Packages/DataFrames/AR9oZ/
    (name = "Distributions", version = "0.25.62"), # https://juliahub.com/ui/Packages/Distributions/xILW0/
    (name = "GLM", version = "1.8.0"), # https://juliahub.com/ui/Packages/GLM/6OREG/
    (name = "IJulia", version = "1.23.3"), # https://juliahub.com/ui/Packages/IJulia/nfu7T/
    (name = "K8sClusterManagers", version = "0.1.3"), # https://juliahub.com/ui/Packages/K8sClusterManagers/Vv6vo/
    (name = "LibPQ", version = "1.13.0"), # https://juliahub.com/ui/Packages/LibPQ/LeQQU/
    (name = "LinRegOutliers", version = "0.8.11"), # https://juliahub.com/ui/Packages/LinRegOutliers/LANxR/
    (name = "Loess", version = "0.5.4"), # https://juliahub.com/ui/Packages/Loess/TysgR/
    (name = "MLJ", version = "0.18.2"), # https://juliahub.com/ui/Packages/MLJ/rAU56/
    (name = "MLJLinearModels", version = "0.6.3"), # https://juliahub.com/ui/Packages/MLJLinearModels/FBSRA/
    (name = "Plots", version = "1.29.0"), # https://juliahub.com/ui/Packages/Plots/ld3vC/
    (name = "Pluto", version = "0.19.5"), # https://juliahub.com/ui/Packages/Pluto/OJqMt/
    (name = "StatsPlots", version = "0.14.34"), # https://juliahub.com/ui/Packages/StatsPlots/SiylL/
    (name = "XLSX", version = "0.7.10") # https://juliahub.com/ui/Packages/XLSX/gPxqz/
])
import Conda
Conda.add("jupyterlab")
