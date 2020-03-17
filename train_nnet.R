library(nnet)
cat("\n----------Begin Data Import---------")
#nd <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD_header+.csv", header=TRUE, row.names=NULL)
#test <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDDtest+.csv", header=TRUE, row.names=NULL)
nd <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDDTrimmed.csv", header=TRUE, row.names=NULL)
test <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/TestTrimmed.csv", header=TRUE, row.names=NULL)
cat("\n----------Data Import Complete----------")

cat("\n----------Begin pre-processing network data----------")
nd$duration = as.numeric(as.character(nd$duration))
nd$protocol_type = factor(nd$protocol_type)
nd$service = factor(nd$service)
nd$flag = factor(nd$flag)
nd$src_bytes = as.numeric(as.character(nd$src_bytes))
nd$dst_bytes = as.numeric(as.character(nd$dst_bytes))
nd$land = factor(nd$land)
nd$wrong_fragment = as.numeric(as.character(nd$wrong_fragment))
nd$hot = as.numeric(as.character(nd$hot))
nd$num_failed_logins = as.numeric(as.character(nd$num_failed_logins))
nd$logged_in = factor(nd$logged_in)
nd$num_compromised = as.numeric(as.character(nd$num_compromised))
nd$root_shell = factor(nd$root_shell)
nd$su_attempted = factor(nd$su_attempted)
nd$num_root = as.numeric(as.character(nd$num_root))
nd$num_file_creations = as.numeric(as.character(nd$num_file_creations))
nd$num_shells = as.numeric(as.character(nd$num_shells))
nd$num_access_files = as.numeric(as.character(nd$num_access_files))
nd$is_guest_login = factor(nd$is_guest_login)
nd$count = as.numeric(as.character(nd$count))
nd$srv_count = as.numeric(as.character(nd$srv_count))
nd$serror_rate = as.numeric(as.character(nd$serror_rate))
nd$srv_serror_rate = as.numeric(as.character(nd$srv_serror_rate))
nd$rerror_rate = as.numeric(as.character(nd$rerror_rate))
nd$srv_rerror_rate = as.numeric(as.character(nd$srv_rerror_rate))
nd$same_srv_rate = as.numeric(as.character(nd$same_srv_rate))
nd$diff_srv_rate = as.numeric(as.character(nd$diff_srv_rate))
nd$srv_diff_host_rate = as.numeric(as.character(nd$srv_diff_host_rate))
nd$dst_host_count = as.numeric(as.character(nd$dst_host_count))
nd$dst_host_srv_count = as.numeric(as.character(nd$dst_host_srv_count))
nd$dst_host_same_srv_rate = as.numeric(as.character(nd$dst_host_same_srv_rate))
nd$dst_host_diff_srv_rate = as.numeric(as.character(nd$dst_host_diff_srv_rate))
nd$dst_host_same_src_port_rate = as.numeric(as.character(nd$dst_host_same_src_port_rate))
nd$dst_host_srv_diff_host_rate = as.numeric(as.character(nd$dst_host_srv_diff_host_rate))
nd$dst_host_serror_rate = as.numeric(as.character(nd$dst_host_serror_rate))
nd$dst_host_srv_serror_rate = as.numeric(as.character(nd$dst_host_srv_serror_rate))
nd$dst_host_rerror_rate = as.numeric(as.character(nd$dst_host_rerror_rate))
nd$dst_host_srv_rerror_rate = as.numeric(as.character(nd$dst_host_srv_rerror_rate))
nd$type = as.character(nd$type)

#filtering into categories of attack
nd$type = as.character(nd$type)
nd$type[nd$type == "normal"] = "normal"
nd$type[nd$type == "neptune"] = "DOS Attack"
nd$type[nd$type == "teardrop"] = "DOS Attack"
nd$type[nd$type == "back"] = "DOS Attack"
nd$type[nd$type == "land"] = "DOS Attack"
nd$type[nd$type == "smurf"] = "DOS Attack"
nd$type[nd$type == "pod"] = "DOS Attack"
nd$type[nd$type == "loadmodule"] = "User to Root Attack"
nd$type[nd$type == "buffer_overflow"] = "User to Root Attack"
nd$type[nd$type == "rootkit"] = "User to Root Attack"
nd$type[nd$type == "perl"] = "User to Root Attack"
nd$type[nd$type == "ftp_write"] = "Remote to Local Attack"
nd$type[nd$type == "guess_passwd"] = "Remote to Local Attack"
nd$type[nd$type == "imap"] = "Remote to Local Attack"
nd$type[nd$type == "multihop"] = "Remote to Local Attack"
nd$type[nd$type == "phf"] = "Remote to Local Attack"
nd$type[nd$type == "spy"] = "Remote to Local Attack"
nd$type[nd$type == "warezclient"] = "Remote to Local Attack"
nd$type[nd$type == "warezmaster"] = "Remote to Local Attack"
nd$type[nd$type == "ipsweep"] = "PROBE Attack"
nd$type[nd$type == "portsweep"] = "PROBE Attack"
nd$type[nd$type == "nmap"] = "PROBE Attack"
nd$type[nd$type == "satan"] = "PROBE Attack"
nd$type = as.factor(nd$type)

test$duration = as.numeric(as.character(test$duration))
test$protocol_type = factor(test$protocol_type)
test$service = factor(test$service)
test$flag = factor(test$flag)
test$src_bytes = as.numeric(as.character(test$src_bytes))
test$dst_bytes = as.numeric(as.character(test$dst_bytes))
test$land = factor(test$land)
test$wrong_fragment = as.numeric(as.character(test$wrong_fragment))
test$hot = as.numeric(as.character(test$hot))
test$num_failed_logins = as.numeric(as.character(test$num_failed_logins))
test$logged_in = factor(test$logged_in)
test$num_compromised = as.numeric(as.character(test$num_compromised))
test$root_shell = factor(test$root_shell)
test$su_attempted = factor(test$su_attempted)
test$num_root = as.numeric(as.character(test$num_root))
test$num_file_creations = as.numeric(as.character(test$num_file_creations))
test$num_shells = as.numeric(as.character(test$num_shells))
test$num_access_files = as.numeric(as.character(test$num_access_files))
test$is_guest_login = factor(test$is_guest_login)
test$count = as.numeric(as.character(test$count))
test$srv_count = as.numeric(as.character(test$srv_count))
test$serror_rate = as.numeric(as.character(test$serror_rate))
test$srv_serror_rate = as.numeric(as.character(test$srv_serror_rate))
test$rerror_rate = as.numeric(as.character(test$rerror_rate))
test$srv_rerror_rate = as.numeric(as.character(test$srv_rerror_rate))
test$same_srv_rate = as.numeric(as.character(test$same_srv_rate))
test$diff_srv_rate = as.numeric(as.character(test$diff_srv_rate))
test$srv_diff_host_rate = as.numeric(as.character(test$srv_diff_host_rate))
test$dst_host_count = as.numeric(as.character(test$dst_host_count))
test$dst_host_srv_count = as.numeric(as.character(test$dst_host_srv_count))
test$dst_host_same_srv_rate = as.numeric(as.character(test$dst_host_same_srv_rate))
test$dst_host_diff_srv_rate = as.numeric(as.character(test$dst_host_diff_srv_rate))
test$dst_host_same_src_port_rate = as.numeric(as.character(test$dst_host_same_src_port_rate))
test$dst_host_srv_diff_host_rate = as.numeric(as.character(test$dst_host_srv_diff_host_rate))
test$dst_host_serror_rate = as.numeric(as.character(test$dst_host_serror_rate))
test$dst_host_srv_serror_rate = as.numeric(as.character(test$dst_host_srv_serror_rate))
test$dst_host_rerror_rate = as.numeric(as.character(test$dst_host_rerror_rate))
test$dst_host_srv_rerror_rate = as.numeric(as.character(test$dst_host_srv_rerror_rate))
test$type = as.character(test$type)

#filtering into categories of attack
test$type = as.character(test$type)
test$type[test$type == "normal"] = "normal"
test$type[test$type == "neptune"] = "DOS Attack"
test$type[test$type == "teardrop"] = "DOS Attack"
test$type[test$type == "back"] = "DOS Attack"
test$type[test$type == "land"] = "DOS Attack"
test$type[test$type == "smurf"] = "DOS Attack"
test$type[test$type == "pod"] = "DOS Attack"
test$type[test$type == "loadmodule"] = "User to Root Attack"
test$type[test$type == "buffer_overflow"] = "User to Root Attack"
test$type[test$type == "rootkit"] = "User to Root Attack"
test$type[test$type == "perl"] = "User to Root Attack"
test$type[test$type == "ftp_write"] = "Remote to Local Attack"
test$type[test$type == "guess_passwd"] = "Remote to Local Attack"
test$type[test$type == "imap"] = "Remote to Local Attack"
test$type[test$type == "multihop"] = "Remote to Local Attack"
test$type[test$type == "phf"] = "Remote to Local Attack"
test$type[test$type == "spy"] = "Remote to Local Attack"
test$type[test$type == "warezclient"] = "Remote to Local Attack"
test$type[test$type == "warezmaster"] = "Remote to Local Attack"
test$type[test$type == "ipsweep"] = "PROBE Attack"
test$type[test$type == "portsweep"] = "PROBE Attack"
test$type[test$type == "nmap"] = "PROBE Attack"
test$type[test$type == "satan"] = "PROBE Attack"
test$type = as.factor(test$type)
cat("\n----------Pre-processing Complete----------")

start <- proc.time()
cat("\n----------Begin training Neural Network----------")
set.seed(1)
sample_pos <- c(sample(1:10000,5000), sample(10001:20000,5000), sample(20001:30000,5000))
nn <- nnet(type ~ ., data=nd, subset=sample_pos, size=5, decay=1.0e-5, maxit=500)
cat("\n----------Training Complete----------")
cat("\n Time: ")
print(proc.time() - start)
cat("\n----------Predicting Our Test Data----------")
actual <- test$type
preds <- predict(nn, test, type="class")
cm <- table(actual, preds)
print(cm)
round(prop.table(cm,1)*100,2)
cat("\n----------Prediction Complete----------")