# install.packages("devtools")
devtools::install_github("hrbrmstr/AnomalyDetection")

library(AnomalyDetection)
library(hrbrthemes)
library(tidyverse)

networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/DoS.csv")$V1

compiled <- ad_ts(networkData, max_anoms=0.02, direction='both')

glimpse(compiled)

