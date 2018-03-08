import os
import csv
with open('/Users/rangedh/UCBSAN201802DATA3-Class-Repository-DATA/Homework/03-Python/Instructions/PyBank/raw_data/budget_data_1.csv') as f:
    data=[tuple(line) for line in csv.reader(f)]
print (data)