import csv, random

with open('data/complete_final.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',', quotechar='|')
    final_rows = list()
    total = 0
    benign = 0
    REMOVED = 0
    for row in reader:
        total = total + 1
        if REMOVED <= 100000:
            if row[77] == "BENIGN":
                REMOVED = REMOVED + 1
            final_rows.append(row)
        else:
            if row[77] != "BENIGN":
                final_rows.append(row)

    random.shuffle(final_rows)
    with open('data/CIC17_slim.csv', 'w') as result:
        writer = csv.writer(result)
        for row in final_rows:
            writer.writerow(row)
