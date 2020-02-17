library("caret")
library("ggplot2")
library("randomForest")
library("rpart")
library(Boruta)
library("nnet")

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

qplot(duration, protocol_type, data=networkData, colour=type)
qplot(flag, service, data=networkData, colour=type)
qplot(service, num_failed_logins, data=networkData, colour=type)
qplot(duration, src_bytes, data=networkData, colour=type)
qplot(duration, land, data=networkData, colour=type)

set.seed(999)
boruta.kdd_train <- Boruta(type~.-service, data = networkData, doTrace = 3, maxRuns=20)
print(boruta.kdd_train)

getSelectedAttributes(boruta.kdd_train, withTentative = F)
bank <- attStats(boruta.kdd_train)
print(bank)

#Boruta performed 19 iterations in 59.26384 mins.
#35 attributes confirmed important: `NA`, count, diff_srv_rate, dst_bytes, dst_host_count and 30 more;
#3 attributes confirmed unimportant: is_hot_login, num_outbound_cmds, urgent;
#3 tentative attributes left: num_access_files, num_shells, su_attempted;
#meanImp medianImp    minImp    maxImp  normHits  decision
#duration                    14.6741697 14.686401 13.986858 15.689460 1.0000000 Confirmed
#protocol_type               34.3727580 34.747795 31.016990 36.692063 1.0000000 Confirmed
#flag                        22.9132657 23.014455 21.971431 23.564498 1.0000000 Confirmed
#src_bytes                   29.3815116 29.445335 27.777677 30.281971 1.0000000 Confirmed
#dst_bytes                   20.6957916 20.807264 19.519950 21.434135 1.0000000 Confirmed
#land                         6.4376840  6.412313  5.313522  7.418466 1.0000000 Confirmed
#wrong_fragment              32.1709179 32.075084 30.744142 34.399592 1.0000000 Confirmed
#urgent                      -0.8243112 -1.363003 -2.260102  1.405938 0.0000000  Rejected
#hot                         25.2692624 25.380015 23.372095 26.510844 1.0000000 Confirmed
#num_failed_logins           13.7814829 13.967403 12.163380 15.070770 1.0000000 Confirmed
#logged_in                   16.5490531 16.661729 15.064148 17.152534 1.0000000 Confirmed
#num_compromised             17.3553352 17.311700 15.544295 18.317504 1.0000000 Confirmed
#root_shell                  10.2573940 10.436128  8.108805 12.885584 1.0000000 Confirmed
#su_attempted                 3.5843072  3.628341  2.527903  4.215009 0.7894737 Tentative
#num_root                     8.1750417  8.032359  7.085776 10.694958 1.0000000 Confirmed
#num_file_creations           5.6683044  5.638198  4.580504  6.682613 1.0000000 Confirmed
#num_shells                   3.8459869  3.839062  2.277133  5.403354 0.8421053 Tentative
#num_access_files             3.7866746  3.843769  3.085081  4.306981 0.8421053 Tentative
#num_outbound_cmds            0.0000000  0.000000  0.000000  0.000000 0.0000000  Rejected
#is_hot_login                 0.0000000  0.000000  0.000000  0.000000 0.0000000  Rejected
#is_guest_login              17.3966410 17.380380 16.343557 18.653916 1.0000000 Confirmed
#count                       27.2748532 27.131946 25.489621 29.204206 1.0000000 Confirmed
#srv_count                   30.4208385 30.484312 28.358331 32.409904 1.0000000 Confirmed
#serror_rate                 13.9028368 13.985398 12.940124 15.549564 1.0000000 Confirmed
#srv_serror_rate             12.5566132 12.585086 11.869177 13.454450 1.0000000 Confirmed
#rerror_rate                 18.4777344 18.723633 16.988843 19.322096 1.0000000 Confirmed
#srv_rerror_rate             12.2527160 12.225573 11.390003 13.259513 1.0000000 Confirmed
#same_srv_rate               17.1306989 17.160067 15.677766 19.009051 1.0000000 Confirmed
#diff_srv_rate               15.0856938 14.904549 13.860779 16.744322 1.0000000 Confirmed
#srv_diff_host_rate          14.1787706 14.271241 12.463319 15.192218 1.0000000 Confirmed
#dst_host_count              25.7910672 25.965213 23.860303 27.522725 1.0000000 Confirmed
#dst_host_srv_count          17.6925640 17.708957 16.990418 18.444530 1.0000000 Confirmed
#dst_host_same_srv_rate      19.3810589 19.543471 18.010947 20.393680 1.0000000 Confirmed
#dst_host_diff_srv_rate      21.1516302 21.015277 19.446834 22.510420 1.0000000 Confirmed
#dst_host_same_src_port_rate 28.2450768 28.223095 27.016408 29.503335 1.0000000 Confirmed
#dst_host_srv_diff_host_rate 21.3152375 21.215850 19.857031 23.295264 1.0000000 Confirmed
#dst_host_serror_rate        19.7630910 19.614078 19.104671 20.808313 1.0000000 Confirmed
#dst_host_srv_serror_rate    15.6845435 15.655277 14.468012 16.699336 1.0000000 Confirmed
#dst_host_rerror_rate        26.6269306 26.510229 24.679910 28.484664 1.0000000 Confirmed
#dst_host_srv_rerror_rate    16.0758867 16.149062 15.286329 17.302922 1.0000000 Confirmed
#`NA`                        40.2086495 40.279151 37.468804 43.548336 1.0000000 Confirmed
