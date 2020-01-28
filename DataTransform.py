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
            struct['csv_headers'] = ['Duration', 'Protocol_Type', 'Service', 'Flag', 'Src_bytes', 'Dst_bytes', 'Land',
                                     'Wrong_fragment', 'Urgent', 'Hot', 'Num_failed_logins', 'Logged_in',
                                     'Num_comprised', 'Root_shell', 'Su_attempted', 'Num_root', 'Num_file_creations',
                                     'Num_shells', 'Num_access_files', 'Num_outbound_cmds', 'Is_hot_login',
                                     'Is_guest_login', 'Count', 'Srv_count', 'Serror_rate']
        return struct

    '''
    Function to extract only normal packets from a data-set & send them to another file
    '''

    def extract_packets(self, attack_type, include_norm):
        raw_data = csv.reader(open(self.file_name, "r"), delimiter=',')
        data = []
        for row in raw_data:
            if attack_type == 'normal':
                if row[41].lower() == self.struct['norm_identifier'].lower():
                    data.append(row)
            elif include_norm:
                if row[41].lower() in self.struct['attack_types'][attack_type] or row[41].lower() == self.struct['norm_identifier']:
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


transform = DataTranform('NSL-KDD', 'NSL-KDD/KDDTrain+.txt')
transform.extract_packets('DoS', False)
