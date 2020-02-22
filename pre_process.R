library(ggplot2)

# setting up the Column Headers and the categories for the network data
networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD.csv", header=FALSE)

kdd_preprocess <- function(data) {
  colnames(data) = c("duration", "protocol_type", "service", "flag", "src_bytes", "dst_bytes", "land", 
                            "wrong_fragment", "urgent", "hot", "num_failed_logins", "logged_in", 
                            "num_compromised", "root_shell", "su_attempted", "num_root", "num_file_creations", 
                            "num_shells", "num_access_files", "num_outbound_cmds", "is_hot_login","is_guest_login", 
                            "count", "srv_count", "serror_rate", "srv_serror_rate", "rerror_rate","srv_rerror_rate", 
                            "same_srv_rate", "diff_srv_rate", "srv_diff_host_rate", "dst_host_count","dst_host_srv_count",
                            "dst_host_same_srv_rate", "dst_host_diff_srv_rate", "dst_host_same_src_port_rate", 
                            "dst_host_srv_diff_host_rate", "dst_host_serror_rate","dst_host_srv_serror_rate", 
                            "dst_host_rerror_rate", "dst_host_srv_rerror_rate", "type")
  
  data$duration = as.numeric(as.character(data$duration))
  data$protocol_type = factor(data$protocol_type)
  data$service = factor(data$service)
  data$flag = factor(data$flag)
  data$src_bytes = as.numeric(as.character(data$src_bytes))
  data$dst_bytes = as.numeric(as.character(data$dst_bytes))
  data$land = factor(data$land)
  data$wrong_fragment = as.numeric(as.character(data$wrong_fragment))
  data$urgent = as.numeric(as.character(data$urgent))
  data$hot = as.numeric(as.character(data$hot))
  data$num_failed_logins = as.numeric(as.character(data$num_failed_logins))
  data$logged_in = factor(data$logged_in)
  data$num_compromised = as.numeric(as.character(data$num_compromised))
  data$root_shell = factor(data$root_shell)
  data$su_attempted = factor(data$su_attempted)
  data$num_root = as.numeric(as.character(data$num_root))
  data$num_file_creations = as.numeric(as.character(data$num_file_creations))
  data$num_shells = as.numeric(as.character(data$num_shells))
  data$num_access_files = as.numeric(as.character(data$num_access_files))
  data$num_outbound_cmds = as.numeric(as.character(data$num_outbound_cmds))
  data$is_hot_login = factor(data$is_hot_login)
  data$is_guest_login = factor(data$is_guest_login)
  data$count = as.numeric(as.character(data$count))
  data$srv_count = as.numeric(as.character(data$srv_count))
  data$serror_rate = as.numeric(as.character(data$serror_rate))
  data$srv_serror_rate = as.numeric(as.character(data$srv_serror_rate))
  data$rerror_rate = as.numeric(as.character(data$rerror_rate))
  data$srv_rerror_rate = as.numeric(as.character(data$srv_rerror_rate))
  data$same_srv_rate = as.numeric(as.character(data$same_srv_rate))
  data$diff_srv_rate = as.numeric(as.character(data$diff_srv_rate))
  data$srv_diff_host_rate = as.numeric(as.character(data$srv_diff_host_rate))
  data$dst_host_count = as.numeric(as.character(data$dst_host_count))
  data$dst_host_srv_count = as.numeric(as.character(data$dst_host_srv_count))
  data$dst_host_same_srv_rate = as.numeric(as.character(data$dst_host_same_srv_rate))
  data$dst_host_diff_srv_rate = as.numeric(as.character(data$dst_host_diff_srv_rate))
  data$dst_host_same_src_port_rate = as.numeric(as.character(data$dst_host_same_src_port_rate))
  data$dst_host_srv_diff_host_rate = as.numeric(as.character(data$dst_host_srv_diff_host_rate))
  data$dst_host_serror_rate = as.numeric(as.character(data$dst_host_serror_rate))
  data$dst_host_srv_serror_rate = as.numeric(as.character(data$dst_host_srv_serror_rate))
  data$dst_host_rerror_rate = as.numeric(as.character(data$dst_host_rerror_rate))
  data$dst_host_srv_rerror_rate = as.numeric(as.character(data$dst_host_srv_rerror_rate))
  data$type = as.character(data$type)
  
  #filtering into categories of attack
  data$type = as.character(data$type)
  data$type[data$type == "normal"] = "normal"
  data$type[data$type == "neptune"] = "DOS Attack"
  data$type[data$type == "teardrop"] = "DOS Attack"
  data$type[data$type == "back"] = "DOS Attack"
  data$type[data$type == "land"] = "DOS Attack"
  data$type[data$type == "smurf"] = "DOS Attack"
  data$type[data$type == "pod"] = "DOS Attack"
  data$type[data$type == "loadmodule"] = "User to Root Attack"
  data$type[data$type == "buffer_overflow"] = "User to Root Attack"
  data$type[data$type == "rootkit"] = "User to Root Attack"
  data$type[data$type == "perl"] = "User to Root Attack"
  data$type[data$type == "ftp_write"] = "Remote to Local Attack"
  data$type[data$type == "guess_passwd"] = "Remote to Local Attack"
  data$type[data$type == "imap"] = "Remote to Local Attack"
  data$type[data$type == "multihop"] = "Remote to Local Attack"
  data$type[data$type == "phf"] = "Remote to Local Attack"
  data$type[data$type == "spy"] = "Remote to Local Attack"
  data$type[data$type == "warezclient"] = "Remote to Local Attack"
  data$type[data$type == "warezmaster"] = "Remote to Local Attack"
  data$type[data$type == "ipsweep"] = "PROBE Attack"
  data$type[data$type == "portsweep"] = "PROBE Attack"
  data$type[data$type == "nmap"] = "PROBE Attack"
  data$type[data$type == "satan"] = "PROBE Attack"
  data$type = as.factor(data$type)
  
  return(data)
}

networkData <- kdd_preprocess(networkData)

#Looking for correlations manually. Will attempt to automate this later.
qplot(duration, protocol_type, data=networkData, colour=type)
qplot(flag, service, data=networkData, colour=type)
qplot(service, num_failed_logins, data=networkData, colour=type)
qplot(duration, src_bytes, data=networkData, colour=type)
qplot(duration, land, data=networkData, colour=type)