import csv
with open('data/complete.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',', quotechar='|')
    summary = {}
    for row in reader:
        if row[77] not in summary.keys():
            summary[row[77]] = 1
        else:
            summary[row[77]] = summary[row[77]] + 1

print(summary)