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
            struct['csv_headers'] = ['Duration', 'Protocol_type', 'Service', 'Flag', 'src_bytes', 'dst_bytes', 'Land'
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
    def extract_all(self):
        regular = 0
        total = 0
        raw_data = csv.reader(open(self.file_name, "r"), delimiter=',')
        with open('KDD.csv', mode='w') as f:
            writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            for row in raw_data:
                total += 1
                if row[1] == "udp" or row[1] == "icmp":
                    regular += 1
                writer.writerow(row)

        return regular/total


transform = DataTranform('NSL-KDD', 'NSL-KDD/KDDTrain+.txt')
print(transform.extract_all())