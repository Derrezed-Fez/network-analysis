#library(nnet)
#library(keras)
#library(tfdatasets)
library(e1071)
library(randomForest)
#library(rpart)
library(caret)

# install.packages("devtools")
devtools::install_github("hrbrmstr/AnomalyDetection")

# library(AnomalyDetection)
# library(hrbrthemes)
# library(tidyverse)

#networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD+.csv")$V1

#compiled <- ad_ts(networkData, max_anoms=0.02, direction='both')

#glimpse(compiled)

testing_data <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDDtest+.csv", header=TRUE, row.names=NULL)
networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD_header+.csv", header=TRUE, row.names=NULL)

# removing is_hot_login, num_outbound_cmds, and urgent columns from data. These were marked as unimportant by Boruta
important_data <- networkData[, c("duration", "protocol_type", "service", "flag", "src_bytes", "dst_bytes", "land", "wrong_fragment", "hot", 
                                  "num_failed_logins", "logged_in", "num_compromised", "root_shell", "su_attempted", "num_root", 
                                  "num_file_creations", "num_shells", "num_access_files","is_guest_login", 
                                  "count", "srv_count", "serror_rate", "srv_serror_rate", "rerror_rate","srv_rerror_rate", 
                                  "same_srv_rate", "diff_srv_rate", "srv_diff_host_rate", "dst_host_count","dst_host_srv_count",
                                  "dst_host_same_srv_rate", "dst_host_diff_srv_rate", "dst_host_same_src_port_rate", 
                                  "dst_host_srv_diff_host_rate", "dst_host_serror_rate","dst_host_srv_serror_rate", 
                                  "dst_host_rerror_rate", "dst_host_srv_rerror_rate", "type")]

test_important <- testing_data[, c("duration", "protocol_type", "service", "flag", "src_bytes", "dst_bytes", "land", "wrong_fragment", "hot", 
                                                    "num_failed_logins", "logged_in", "num_compromised", "root_shell", "su_attempted", "num_root", 
                                                    "num_file_creations", "num_shells", "num_access_files","is_guest_login", 
                                                    "count", "srv_count", "serror_rate", "srv_serror_rate", "rerror_rate","srv_rerror_rate", 
                                                    "same_srv_rate", "diff_srv_rate", "srv_diff_host_rate", "dst_host_count","dst_host_srv_count",
                                                    "dst_host_same_srv_rate", "dst_host_diff_srv_rate", "dst_host_same_src_port_rate", 
                                                    "dst_host_srv_diff_host_rate", "dst_host_serror_rate","dst_host_srv_serror_rate", 
                                                    "dst_host_rerror_rate", "dst_host_srv_rerror_rate", "type")]

# setting up data partition for training
partitioned_data <- createDataPartition(y=important_data$type,p=0.1, list=FALSE)
prep <- important_data[partitioned_data,]
fit.forest <- train(type ~ ., data=important_data)
print(fit.forest)
prediction <- predict(fit.forest, test_important)