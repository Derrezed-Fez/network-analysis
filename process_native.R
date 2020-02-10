library("caret")
library("ggplot2")
source()

# setting up the Column Headers and the categories for the network data
networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/KDD.csv", header=FALSE)

colnames(networkData) = c("duration", "protocol_type", "service", "flag", "src_bytes", "dst_bytes", "land", 
                                           "wrong_fragment", "urgent", "hot", "num_failed_logins", "logged_in", 
                                           "num_compromised", "root_shell", "su_attempted", "num_root", "num_file_creations", 
                                           "num_shells", "num_access_files", "num_outbound_cmds", "is_hot_login","is_guest_login", 
                                           "count", "srv_count", "serror_rate", "srv_serror_rate", "rerror_rate","srv_rerror_rate", 
                                           "same_srv_rate", "diff_srv_rate", "srv_diff_host_rate", "dst_host_count","dst_host_srv_count",
                                           "dst_host_same_srv_rate", "dst_host_diff_srv_rate", "dst_host_same_src_port_rate", 
                                           "dst_host_srv_diff_host_rate", "dst_host_serror_rate","dst_host_srv_serror_rate", 
                                           "dst_host_rerror_rate", "dst_host_srv_rerror_rate", "type")

networkData$duration = as.numeric(as.character(networkData$duration))
networkData$protocol_type = factor(networkData$protocol_type)
networkData$service = factor(networkData$service)
networkData$flag = factor(networkData$flag)
networkData$src_bytes = as.numeric(as.character(networkData$src_bytes))
networkData$dst_bytes = as.numeric(as.character(networkData$dst_bytes))
networkData$land = factor(networkData$land)
networkData$wrong_fragment = as.numeric(as.character(networkData$wrong_fragment))
networkData$urgent = as.numeric(as.character(networkData$urgent))
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
networkData$num_outbound_cmds = as.numeric(as.character(networkData$num_outbound_cmds))
networkData$is_hot_login = factor(networkData$is_hot_login)
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

#pre-processing by label type
networkData$type = as.character(networkData$type)
networkData$type[networkData$type == "normal"] = "normal"
networkData$type[networkData$type == "back"] = "dos"
networkData$type[networkData$type == "land"] = "dos"
networkData$type[networkData$type == "neptune"] = "dos"
networkData$type[networkData$type == "pod"] = "dos"
networkData$type[networkData$type == "smurf"] = "dos"
networkData$type[networkData$type == "teardrop"] = "dos"
networkData$type[networkData$type == "buffer_overflow"] = "u2r"
networkData$type[networkData$type == "loadmodule"] = "u2r"
networkData$type[networkData$type == "perl"] = "u2r"
networkData$type[networkData$type == "rootkit"] = "u2r"
networkData$type[networkData$type == "ftp_write"] = "r2l"
networkData$type[networkData$type == "guess_passwd"] = "r2l"
networkData$type[networkData$type == "imap"] = "r2l"
networkData$type[networkData$type == "multihop"] = "r2l"
networkData$type[networkData$type == "phf"] = "r2l"
networkData$type[networkData$type == "spy"] = "r2l"
networkData$type[networkData$type == "warezclient"] = "r2l"
networkData$type[networkData$type == "warezmaster"] = "r2l"
networkData$type[networkData$type == "ipsweep"] = "probe"
networkData$type[networkData$type == "portsweep"] = "probe"
networkData$type[networkData$type == "nmap"] = "probe"
networkData$type[networkData$type == "satan"] = "probe"
networkData$type = as.factor(networkData$type)

qplot(duration, protocol_type, data=networkData, colour=type)
qplot(flag, service, data=networkData, colour=type)
