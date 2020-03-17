library(ggplot2)
library(rgl)

# setting up the Column Headers and the categories for the network networkData
networknetworkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD.csv", header=FALSE)

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
  
#filtering into categories of attack
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

#Looking for correlations manually. Will attempt to automate this later.
#qplot(duration, protocol_type, data=networknetworkData, colour=type)
#qplot(flag, service, data=networkData, colour=type)
#qplot(service, num_failed_logins, data=networkData, colour=type)
#qplot(duration, src_bytes, data=networkData, colour=type)
#qplot(duration, land, data=networkData, colour=type)
plot3d(networkData$duration, networkData$src_bytes, networkData$service, "Duration", "Source Bytes", "Service", col='blue', size=3)