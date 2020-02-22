library(Boruta)

networkData <- read.csv(file = "/Users/zachariahpelletier/PycharmProjects/r-format-factory/Processed_Data/KDD_header+.csv", header=TRUE, row.names=NULL)

# Here is the automation of importantance calculation for the data
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

#-------- 13 iterations on good machine -------
#Boruta performed 13 iterations in 11.029 mins.
#38 attributes confirmed important: `NA`, count, diff_srv_rate, dst_bytes, dst_host_count and
#33 more;
#3 attributes confirmed unimportant: is_hot_login, num_outbound_cmds, urgent;
#meanImp medianImp    minImp     maxImp normHits  decision
#duration                    14.522361 14.415496 14.025314 15.5136800        1 Confirmed
#protocol_type               34.330594 34.313613 32.520757 36.0546544        1 Confirmed
#flag                        22.667976 22.501187 20.835914 24.5662378        1 Confirmed
#src_bytes                   29.944937 29.789714 28.694210 31.8848235        1 Confirmed
#dst_bytes                   20.536364 20.491387 19.691781 21.6242548        1 Confirmed
#land                         6.537436  6.635616  5.203133  7.7953913        1 Confirmed
#wrong_fragment              32.695304 32.970754 30.513209 33.8031660        1 Confirmed
#urgent                      -1.074893 -1.139254 -2.583437  0.8980363        0  Rejected
#hot                         25.756075 25.757564 24.497638 26.8775417        1 Confirmed
#num_failed_logins           13.746167 13.690671 12.355431 14.7721941        1 Confirmed
#logged_in                   16.463830 16.635946 15.700735 17.0164760        1 Confirmed
#num_compromised             17.298393 17.177313 16.567475 18.5609909        1 Confirmed
#root_shell                  10.192125  9.983301  8.781122 11.5633136        1 Confirmed
#su_attempted                 3.536098  3.359078  3.122674  4.1692454        1 Confirmed
#num_root                     8.222905  8.321732  7.175423 10.5476473        1 Confirmed
#num_file_creations           5.738275  5.893336  4.958177  6.4411817        1 Confirmed
#num_shells                   4.146127  4.156533  3.817955  4.8762625        1 Confirmed
#num_access_files             3.699249  3.678039  2.982393  4.9113856        1 Confirmed
#num_outbound_cmds            0.000000  0.000000  0.000000  0.0000000        0  Rejected
#is_hot_login                 0.000000  0.000000  0.000000  0.0000000        0  Rejected
#is_guest_login              17.024416 17.009295 15.269068 18.9815654        1 Confirmed
#count                       27.155466 26.877344 24.840873 29.3846581        1 Confirmed
#srv_count                   29.574201 30.403213 26.431805 31.3077636        1 Confirmed
#serror_rate                 13.699887 13.823438 12.708443 14.1750789        1 Confirmed
#srv_serror_rate             12.347644 12.353641 12.019172 12.6445459        1 Confirmed
#rerror_rate                 18.668030 18.596372 17.907455 19.5005676        1 Confirmed
#srv_rerror_rate             12.095689 12.193733 10.954932 13.0869223        1 Confirmed
#same_srv_rate               17.144576 17.133615 15.430181 18.4437701        1 Confirmed
#diff_srv_rate               14.606717 15.019680 13.350730 15.2095990        1 Confirmed
#srv_diff_host_rate          13.845200 13.746043 12.438979 14.9241274        1 Confirmed
#dst_host_count              25.896676 25.989331 24.239870 27.4447622        1 Confirmed
#dst_host_srv_count          17.680605 17.588409 16.667601 18.9883524        1 Confirmed
#dst_host_same_srv_rate      19.140714 19.216393 18.222622 19.7421974        1 Confirmed
#dst_host_diff_srv_rate      21.345532 21.251514 19.288451 23.1415938        1 Confirmed
#dst_host_same_src_port_rate 28.167884 28.226252 27.003862 29.3803172        1 Confirmed
#dst_host_srv_diff_host_rate 21.606114 21.303703 19.971832 23.6304081        1 Confirmed
#dst_host_serror_rate        19.954624 19.968948 19.242560 20.4546771        1 Confirmed
#dst_host_srv_serror_rate    15.633564 15.518835 14.882202 16.4850218        1 Confirmed
#dst_host_rerror_rate        26.427904 26.510295 25.005650 27.6573204        1 Confirmed
#dst_host_srv_rerror_rate    15.982393 15.908626 15.171554 16.8252380        1 Confirmed