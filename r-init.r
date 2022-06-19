RSPM <- c(RSPM = "https://packagemanager.rstudio.com/all/latest")
project_folder <- c("~/github")

dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
install.packages("renv", repos = RSPM) # https://cloud.r-project.org/web/packages/renv/index.html
renv::init(project = project_folder, bare = TRUE, repos = RSPM)