import csv

# with open('data/complete_final.csv', newline='') as csvfile:
#     reader = csv.reader(csvfile, delimiter=',', quotechar='|')
#     with open('data/final.csv', 'w') as result:
#         writer = csv.writer(result)
#         for row in reader:
#             modified = False
#             for column in row:
#                 if column == "Infinity":
#                     row[row.index('Infinity')] = "0"
#                     print(row)
#                     writer.writerow(row)
#                     modified = True
#             if  not modified:
#                 writer.writerow(row)

# with open('data/CIC17_slim.csv', newline='') as csvfile:
#     reader = csv.reader(csvfile, delimiter=',', quotechar='|')
#     for row in reader:
#         for column in row:
#             if column == "Infinity":
#                 print(row)

with open('data/CIC17_slim.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',', quotechar='|')
    with open('data/done.csv', 'w') as result:
        writer = csv.writer(result)
        for row in reader:
            del row[31]
            del row[33]
            del row[45]
            del row[49]
            del row[50]
            del row[55]
            del row[56]
            del row[57]
            del row[58]
            del row[59]
            del row[60]
            del row[61]
            writer.writerow(row)