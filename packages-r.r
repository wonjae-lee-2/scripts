project_folder <- c(Sys.getenv("PROJECT_FOLDER"))
package_list <- c(
    "tidyverse", # https://tidyverse.tidyverse.org/index.html https://cloud.r-project.org/web/packages/tidyverse/index.html
    "tidymodels", # https://tidymodels.tidymodels.org/ https://cloud.r-project.org/web/packages/tidymodels/index.html
    "markdown", # https://cloud.r-project.org/web/packages/markdown/index.html
    "corrr", # https://cloud.r-project.org/web/packages/corrr/index.html
    "DBI", # https://cloud.r-project.org/web/packages/DBI/index.html
    "discrim", # https://cloud.r-project.org/web/packages/discrim/index.html
    "GGally", # https://cloud.r-project.org/web/packages/GGally/index.html
    "kknn", # https://cloud.r-project.org/web/packages/kknn/index.html
    "klaR", # https://cloud.r-project.org/web/packages/klaR/index.html
    "leaps", # https://cloud.r-project.org/web/packages/leaps/index.html
    "patchwork", # https://cloud.r-project.org/web/packages/patchwork/index.html
    "poissonreg", # https://cloud.r-project.org/web/packages/poissonreg/index.html
    "RPostgres", # https://cloud.r-project.org/web/packages/RPostgres/index.html
    "sparklyr" # https://cloud.r-project.org/web/packages/sparklyr/index.html
)

options(repos = c(RSPM = "https://packagemanager.rstudio.com/all/__linux__/jammy/latest")) # https://packagemanager.rstudio.com/client/#/repos/1/overview
dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
install.packages("renv") # https://cloud.r-project.org/web/packages/renv/index.html
renv::init(project = project_folder, bare = TRUE)
renv::install(packages = package_list)
renv::snapshot(type = "all")
