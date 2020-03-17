'''
A File to facilitate the transform of a data set into categories to be pre-processed
Author: Zachariah Pelletier
'''
import csv


class DataTranform():
    # Constants for data set selection
    def __init__(self, dataset, file_name):
        self.struct = self.initialize_dataset_parameters(dataset)
        self.file_name = file_name

    '''
    Function to initialize the data set parameters based on the title of the data set
    '''

    def initialize_dataset_parameters(self, dataset):
        struct = {}
        if dataset == 'NSL-KDD':
            struct['attack_types'] = {
                'DoS': ['back', 'land', 'neptune', 'pod', 'smurf', 'teardrop', 'apache2', 'udpstorm', 'processtable',
                        'worm'],
                'Probe': ['satan', 'ipsweep', 'nmap', 'portsweep', 'mscan', 'saint'],
                'R2L': ['guess_password', 'ftp_write', 'imap', 'phf', 'multihop', 'warezmaster', 'warezclient', 'spy',
                        'xlock', 'xsnoop', 'snmpguess', 'snmpgetattack', 'httptunnel', 'sendmail', 'named'],
                'U2R': ['buffer_overflow', 'loadmodule', 'rootkit', 'perl', 'sqlattack', 'xterm', 'ps']
            }
            struct['norm_identifier'] = 'normal'
            struct['csv_headers'] = ['duration', 'protocol_type', 'service', 'flag', 'src_bytes', 'dst_bytes', 'land'
                                     'wrong_fragment', 'urgent', 'hot', 'num_failed_logins', 'logged_in',
                                     'num_compromised', 'root_shell', 'su_attempted',
                                     'num_root', 'num_file_creations', 'num_shells', 'num_access_files',
                                     'num_outbound_cmds', 'is_hot_login', 'is_guest_login', 'count', 'srv_count',
                                     'serror_rate', 'srv_serror_rate', 'rerror_rate', 'srv_rerror_rate',
                                     'same_srv_rate', 'diff_srv_rate', 'srv_diff_host_rate', 'dst_host_count',
                                     'dst_host_srv_count', 'dst_host_same_srv_rate', 'dst_host_diff_srv_rate',
                                     'dst_host_same_src_port_rate', 'dst_host_srv_diff_host_rate',
                                     'dst_host_serror_rate', 'dst_host_srv_serror_rate', 'dst_host_rerror_rate',
                                     'dst_host_srv_rerror_rate', 'type']
        return struct

    '''
    Function to extract certain packets from a data-set & send them to another file
    '''

    def extract_packets(self, attack_type, include_norm):
        raw_data = csv.reader(open(self.file_name, "r"), delimiter=',')
        data = []
        for row in raw_data:
            if attack_type == 'normal':
                if row[41].lower() == self.struct['norm_identifier'].lower():
                    data.append(row)
            elif include_norm:
                if row[41].lower() in self.struct['attack_types'][attack_type] or row[41].lower() == self.struct[
                    'norm_identifier']:
                    data.append(row)
            else:
                if row[41].lower() in self.struct['attack_types'][attack_type]:
                    data.append(row)

        if include_norm:
            with open(attack_type + '+norm.csv', mode='w') as f:
                writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                for row in data:
                    writer.writerow(row)
        else:
            with open(attack_type + '.csv', mode='w') as f:
                writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                writer.writerow(self.struct['csv_headers'])
                for row in data:
                    writer.writerow(row)

    '''
    Function to extract all packets to a CSV file and returns ratio of normal packets
    '''
    def extract_all(self, train=True):
        regular = 0
        total = 0
        raw_data = csv.reader(open(self.file_name, "r"), delimiter=',')
        if train:
            with open('KDD.csv', mode='w') as f:
                writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                # writer.writerow(self.struct['csv_headers'])
                for row in raw_data:
                    total += 1
                    if row[1] == "udp" or row[1] == "icmp":
                        regular += 1
                    writer.writerow(row)
        else:
            with open('KDDtest.csv', mode='w') as f:
                writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                # writer.writerow(self.struct['csv_headers'])
                for row in raw_data:
                    total += 1
                    if row[1] == "udp" or row[1] == "icmp":
                        regular += 1
                    writer.writerow(row)

        return regular/total

    '''
    Function to remove last column of data (score) which isn't needed for training
    '''
    def remove_last(self, filename):
        with open(filename + ".csv", "r") as fin:
            outname = filename + "+.csv"
            with open(outname, "w") as fout:
                writer = csv.writer(fout)
                for row in csv.reader(fin):
                    writer.writerow(row[:-1])

transform = DataTranform('NSL-KDD', 'NSL-KDD/KDDTrain+.txt')
transformTest = DataTranform('NSL-KDD', 'NSL-KDD/KDDTest+.txt')
# print(transform.extract_all())
# print(transformTest.extract_all(False))
# transform.remove_last('KDD')
# transform.remove_last('KDD_header')
# transformTest.remove_last('KDDtest')

csvreader = csv.reader(open('Processed_Data/KDDtest+.csv', "r"), delimiter=',')
counter = 0
with open('KDDT1000.csv', mode='w') as f:
    writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for row in csvreader:
        if counter == 1000:
            break
        else:
            writer.writerow(row)
            counter += 1
# no 20, 19, 8
# with open('TestTrimmed.csv', mode='w') as f:
#     writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
#     for row in csvreader:
#         writer.writerow((row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[9], row[10], row[11],
#                         row[12], row[13], row[14], row[15], row[16], row[17], row[18], row[21], row[22], row[23],
#                         row[24], row[25], row[26], row[27], row[28], row[29], row[30], row[31], row[32], row[33],
#                         row[34], row[35], row[36], row[37], row[38], row[39], row[40], row[41]))