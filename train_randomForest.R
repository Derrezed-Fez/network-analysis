# library(e1071)
# library(randomForest)
library(caret)

# install.packages("devtools")
# devtools::install_github("hrbrmstr/AnomalyDetection")

# library(AnomalyDetection)
# library(hrbrthemes)
# library(tidyverse)

#networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD+.csv")$V1

#compiled <- ad_ts(networkData, max_anoms=0.02, direction='both')

#glimpse(compiled)

testing_data <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDDT100.csv", header=TRUE, row.names=NULL)
networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDD100.csv", header=TRUE, row.names=NULL)

networkData$duration = as.numeric(as.character(networkData$duration))
networkData$protocol_type = factor(networkData$protocol_type)
networkData$service = factor(networkData$service)
networkData$flag = factor(networkData$flag)
networkData$src_bytes = as.numeric(as.character(networkData$src_bytes))
networkData$dst_bytes = as.numeric(as.character(networkData$dst_bytes))
networkData$land = factor(networkData$land)
networkData$wrong_fragment = as.numeric(as.character(networkData$wrong_fragment))
networkData$hot = as.numeric(as.character(networkData$hot))
networkData$num_failed_logins = as.numeric(as.character(networkData$num_failed_logins))
networkData$logged_in = factor(networkData$logged_in)
networkData$num_compromised = as.numeric(as.character(networkData$num_compromised))
networkData$root_shell = factor(networkData$root_shell)
networkData$su_attempted = factor(networkData$su_attempted)
networkData$num_root = as.numeric(as.character(networkData$num_root))
networkData$num_file_creations = as.numeric(as.character(networkData$num_file_creations))
networkData$num_shells = as.numeric(as.character(networkData$num_shells))
networkData$num_access_files = as.numeric(as.character(networkData$num_access_files))
networkData$is_guest_login = factor(networkData$is_guest_login)
networkData$count = as.numeric(as.character(networkData$count))
networkData$srv_count = as.numeric(as.character(networkData$srv_count))
networkData$serror_rate = as.numeric(as.character(networkData$serror_rate))
networkData$srv_serror_rate = as.numeric(as.character(networkData$srv_serror_rate))
networkData$rerror_rate = as.numeric(as.character(networkData$rerror_rate))
networkData$srv_rerror_rate = as.numeric(as.character(networkData$srv_rerror_rate))
networkData$same_srv_rate = as.numeric(as.character(networkData$same_srv_rate))
networkData$diff_srv_rate = as.numeric(as.character(networkData$diff_srv_rate))
networkData$srv_diff_host_rate = as.numeric(as.character(networkData$srv_diff_host_rate))
networkData$dst_host_count = as.numeric(as.character(networkData$dst_host_count))
networkData$dst_host_srv_count = as.numeric(as.character(networkData$dst_host_srv_count))
networkData$dst_host_same_srv_rate = as.numeric(as.character(networkData$dst_host_same_srv_rate))
networkData$dst_host_diff_srv_rate = as.numeric(as.character(networkData$dst_host_diff_srv_rate))
networkData$dst_host_same_src_port_rate = as.numeric(as.character(networkData$dst_host_same_src_port_rate))
networkData$dst_host_srv_diff_host_rate = as.numeric(as.character(networkData$dst_host_srv_diff_host_rate))
networkData$dst_host_serror_rate = as.numeric(as.character(networkData$dst_host_serror_rate))
networkData$dst_host_srv_serror_rate = as.numeric(as.character(networkData$dst_host_srv_serror_rate))
networkData$dst_host_rerror_rate = as.numeric(as.character(networkData$dst_host_rerror_rate))
networkData$dst_host_srv_rerror_rate = as.numeric(as.character(networkData$dst_host_srv_rerror_rate))
networkData$type = as.character(networkData$type)

networkData$type = as.character(networkData$type)
networkData$type[networkData$type == "normal"] = "normal"
networkData$type[networkData$type == "neptune"] = "DOS Attack"
networkData$type[networkData$type == "teardrop"] = "DOS Attack"
networkData$type[networkData$type == "back"] = "DOS Attack"
networkData$type[networkData$type == "land"] = "DOS Attack"
networkData$type[networkData$type == "smurf"] = "DOS Attack"
networkData$type[networkData$type == "pod"] = "DOS Attack"
networkData$type[networkData$type == "loadmodule"] = "User to Root Attack"
networkData$type[networkData$type == "buffer_overflow"] = "User to Root Attack"
networkData$type[networkData$type == "rootkit"] = "User to Root Attack"
networkData$type[networkData$type == "perl"] = "User to Root Attack"
networkData$type[networkData$type == "ftp_write"] = "Remote to Local Attack"
networkData$type[networkData$type == "guess_passwd"] = "Remote to Local Attack"
networkData$type[networkData$type == "imap"] = "Remote to Local Attack"
networkData$type[networkData$type == "multihop"] = "Remote to Local Attack"
networkData$type[networkData$type == "phf"] = "Remote to Local Attack"
networkData$type[networkData$type == "spy"] = "Remote to Local Attack"
networkData$type[networkData$type == "warezclient"] = "Remote to Local Attack"
networkData$type[networkData$type == "warezmaster"] = "Remote to Local Attack"
networkData$type[networkData$type == "ipsweep"] = "PROBE Attack"
networkData$type[networkData$type == "portsweep"] = "PROBE Attack"
networkData$type[networkData$type == "nmap"] = "PROBE Attack"
networkData$type[networkData$type == "satan"] = "PROBE Attack"
networkData$type = as.factor(networkData$type)

testing_data$type = as.character(testing_data$type)
testing_data$type[testing_data$type == "normal"] = "normal"
testing_data$type[testing_data$type == "neptune"] = "DOS Attack"
testing_data$type[testing_data$type == "teardrop"] = "DOS Attack"
testing_data$type[testing_data$type == "back"] = "DOS Attack"
testing_data$type[testing_data$type == "land"] = "DOS Attack"
testing_data$type[testing_data$type == "smurf"] = "DOS Attack"
testing_data$type[testing_data$type == "pod"] = "DOS Attack"
testing_data$type[testing_data$type == "loadmodule"] = "User to Root Attack"
testing_data$type[testing_data$type == "buffer_overflow"] = "User to Root Attack"
testing_data$type[testing_data$type == "rootkit"] = "User to Root Attack"
testing_data$type[testing_data$type == "perl"] = "User to Root Attack"
testing_data$type[testing_data$type == "ftp_write"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "guess_passwd"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "imap"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "multihop"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "phf"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "spy"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "warezclient"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "warezmaster"] = "Remote to Local Attack"
testing_data$type[testing_data$type == "ipsweep"] = "PROBE Attack"
testing_data$type[testing_data$type == "portsweep"] = "PROBE Attack"
testing_data$type[testing_data$type == "nmap"] = "PROBE Attack"
testing_data$type[testing_data$type == "satan"] = "PROBE Attack"
testing_data$type = as.factor(testing_data$type)

# setting up data partition for training
partition <- createDataPartition(y=networkData$type,p=0.1, list=FALSE)
control <- trainControl(method="cv", number=10)

# trying five different algorithms to see how well they fare
set.seed(100)
# Linear Discriminant Analysis
fit.forest <- train(type ~ ., data=networkData, method="lda", metric="Accuracy", trControl=control)
print("lda")
# Classification and Regression Trees
fit.forest <- train(type ~ ., data=networkData, method="rpart", metric="Accuracy", trControl=control)
print("rpart")
# k-Nearest Neighbors
fit.forest <- train(type ~ ., data=networkData, method="knn", metric="Accuracy", trControl=control)
print("knn")
# Support Vector Machines with a linear kernel
fit.forest <- train(type ~ ., data=networkData, method="svmRadial", metric="Accuracy", trControl=control)
print("svmradial")
# Random Forest
fit.forest <- train(type ~ ., data=networkData, method="rf", metric="Accuracy", trControl=control)
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)