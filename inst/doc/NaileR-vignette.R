## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# library(NaileR)
# data(iris)
# 
# intro_iris <- "A study measured various parts of iris flowers
# from 3 different species: setosa, versicolor and virginica.
# I will give you the results from this study.
# You will have to identify what sets these flowers apart."
# intro_iris <- gsub('\n', ' ', intro_iris) |>
#   stringr::str_squish()
# 
# req_iris <- "Please explain what makes each species distinct.
# Also, tell me which species has the biggest flowers,
# and which species has the smallest. Is there any biological reason for this?"
# req_iris <- gsub('\n', ' ', req_iris) |>
#   stringr::str_squish()
# req_iris <- gsub('\n', ' ', req_iris) |>
#   stringr::str_squish()
# 
# res_iris <- nail_catdes(iris,
#                         num.var = 5,
#                         model = "llama3.1",
#                         introduction = intro_iris,
#                         request = req_iris,
#                         generate = TRUE)

## ----setup--------------------------------------------------------------------
res_iris <- readRDS(system.file("extdata", "res_iris.rds", package = "NaileR"))
formatted_text <- strwrap(res_iris$response, width = 80)
print(formatted_text)

## -----------------------------------------------------------------------------
library(NaileR)
library(FactoMineR)
data(waste)
waste <- waste[-14]    # no variability on this question

set.seed(1)
res_mca_waste <- MCA(waste, quali.sup = c(1,2,50:76),
                     ncp = 35, level.ventil = 0.05, graph = FALSE)
plot.MCA(res_mca_waste, choix = "ind",
         invisible = c("var", "quali.sup"), label = "none")
res_hcpc_waste <- HCPC(res_mca_waste, nb.clust = 3, graph = FALSE)

## -----------------------------------------------------------------------------
don_clust_waste <- res_hcpc_waste$data.clust
res_mca_waste <- MCA(don_clust_waste, quali.sup = c(1,2,50:77),
                     ncp = 35, level.ventil = 0.05, graph = FALSE)
plot.MCA(res_mca_waste, choix = "ind",
         invisible = c("var", "quali.sup"), label = "none", habillage = 77)

## ----eval=FALSE---------------------------------------------------------------
# intro_waste <- 'These data were collected
# after a survey on food waste,
# with participants describing their habits.'
# intro_waste <- gsub('\n', ' ', intro_waste) |>
#   stringr::str_squish()
# 
# req_waste <- 'Please summarize the characteristics of each group.
# Then, give each group a new name, based on your conclusions.
# Finally, give each group a grade between 0 and 10,
# based on how wasteful they are with food:
# 0 being "not at all", 10 being "absolutely".'
# req_waste <- gsub('\n', ' ', req_waste) |>
#   stringr::str_squish()
# 
# res_waste <- nail_catdes(don_clust_waste,
#                          num.var = ncol(don_clust_waste),
#                          introduction = intro_waste,
#                          request = req_waste,
#                          model = "llama3.1",
#                          drop.negative = TRUE,
#                          generate = TRUE)

## -----------------------------------------------------------------------------
res_waste <- readRDS(system.file("extdata", "res_waste.rds", package = "NaileR"))
formatted_text <- strwrap(res_waste$response, width = 80)
print(formatted_text)

