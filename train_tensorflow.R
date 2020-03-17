library(keras)
library(tfdatasets)

# To fix issue: devtools::install_github("rstudio/reticulate")
test_file <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDDtest+.csv", header=TRUE, row.names=NULL)
train_file <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD_header+.csv", header=TRUE, row.names=NULL)

train_dataset <- make_csv_dataset(
  "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDDT100.csv", 
  field_delim = ",",
  batch_size = 5, 
  num_epochs = 1
)

test_dataset <- make_csv_dataset(
  "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDD100.csv", 
  field_delim = ",",
  batch_size = 5,
  num_epochs = 1
)

spec <- feature_spec(train_dataset, type ~ .)
spec <- fit(spec)
layer <- layer_dense_features(feature_columns = dense_features(spec))
