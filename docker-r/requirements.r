install.packages("https://cran.r-project.org/src/contrib/remotes_2.4.2.tar.gz", repo = NULL) # https://cran.r-project.org/web/packages/remotes/index.html
library(remotes)
core_tidyverse <- list( # https://tidyverse.tidyverse.org/index.html
    c("tidyverse", "1.3.1"), # https://cran.r-project.org/web/packages/tidyverse/index.html
    c("ggplot2", "3.3.6"), # https://cran.r-project.org/web/packages/ggplot2/index.html
    c("dplyr", "1.0.9"), # https://cran.r-project.org/web/packages/dplyr/index.html
    c("tidyr", "1.2.0"), # https://cran.r-project.org/web/packages/tidyr/index.html
    c("readr", "2.1.2"), # https://cran.r-project.org/web/packages/readr/index.html
    c("purrr", "0.3.4"), # https://cran.r-project.org/web/packages/purrr/index.html
    c("tibble", "3.1.7"), # https://cran.r-project.org/web/packages/tibble/index.html
    c("stringr", "1.4.0"), # https://cran.r-project.org/web/packages/stringr/index.html
    c("forcats", "0.5.1") # https://cran.r-project.org/web/packages/forcats/index.html
)
for (x in core_tidyverse) {
    install_version(x[1], x[2], upgrade = "never", repo = "https://cloud.r-project.org")
}
core_tidymodels <- list( # https://tidymodels.tidymodels.org/
    c("tidymodels", "0.2.0"), # https://cran.r-project.org/web/packages/tidymodels/index.html
    c("broom", "0.8.0"), # https://cran.r-project.org/web/packages/broom/index.html
    c("dials", "0.1.1"), # https://cran.r-project.org/web/packages/dials/index.html
    c("infer", "1.0.0"), # https://cran.r-project.org/web/packages/infer/index.html
    c("modeldata", "0.1.1"), # https://cran.r-project.org/web/packages/modeldata/index.html
    c("parsnip", "0.2.1"), # https://cran.r-project.org/web/packages/parsnip/index.html
    c("recipes", "0.2.0"), # https://cran.r-project.org/web/packages/recipes/index.html
    c("rsample", "0.1.1"), # https://cran.r-project.org/web/packages/rsample/index.html
    c("tune", "0.2.0"), # https://cran.r-project.org/web/packages/tune/index.html
    c("workflows", "0.2.6"), # https://cran.r-project.org/web/packages/workflows/index.html
    c("workflowsets", "0.2.1"), # https://cran.r-project.org/web/packages/workflowsets/index.html
    c("yardstick", "0.0.9") # https://cran.r-project.org/web/packages/yardstick/index.html
)
for (x in core_tidymodels) {
    install_version(x[1], x[2], upgrade = "never", repo = "https://cloud.r-project.org")
}
other_packages <- list(
    c("markdown", "1.1"), # https://cran.r-project.org/web/packages/markdown/index.html
    c("corrr", "0.4.3"), # https://cran.r-project.org/web/packages/corrr/index.html
    c("DBI", "1.1.2"), # https://cran.r-project.org/web/packages/DBI/index.html
    c("discrim", "0.2.0"), # https://cran.r-project.org/web/packages/discrim/index.html
    c("GGally", "2.1.2"), # https://cran.r-project.org/web/packages/GGally/index.html
    c("kknn", "1.3.1"), # https://cran.r-project.org/web/packages/kknn/index.html
    c("klaR", "1.7-0"), # https://cran.r-project.org/web/packages/klaR/index.html
    c("patchwork", "1.1.1"), # https://cran.r-project.org/web/packages/patchwork/index.html
    c("poissonreg", "0.2.0"), # https://cran.r-project.org/web/packages/poissonreg/index.html
    c("RMariaDB", "1.2.1"), # https://cloud.r-project.org/web/packages/RMariaDB/index.html
    c("RPostgres", "1.4.4"), # https://cran.r-project.org/web/packages/RPostgres/index.html
    c("readxl", "1.4.0") # https://cran.r-project.org/web/packages/readxl/index.html
)
for (x in other_packages) {
    install_version(x[1], x[2], upgrade = "never", repo = "https://cloud.r-project.org")
}
