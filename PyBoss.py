import os
import csv
import re
from datetime import date,datetime


#Variable declaration
empid = []
name =[]
dob =[]
ssn=[]
state=[]
firstname =[]
lastname=[]

#declaring state abrr
us_state_abbrev = {
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
}

#Input File Path 
inpath=input('Enter the Input file path: ')

#output File path
outpath=input('Enter the Output file path: ')
#path = '/Users/rangedh/UCBSAN201802DATA3-Class-Repository-DATA/Homework/03-Python/Instructions/PyBoss/raw_data'
for filename in os.listdir(inpath):
    print(filename)
    empid = []
    name =[]
    dob =[]
    ssn=[]
    state=[]
    firstname =[]
    lastname=[]
    in_file = os.path.join(inpath, filename)
    with open(in_file) as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            empid.append(row[0])
            name.append(row[1])
            dob.append(row[2])  
            ssn.append(row[3])
            state.append(row[4])
        
        #Split the name 
        for i in name:
            firstname.append(i.split(' ')[0])
            lastname.append(i.split(' ')[1])

        #Converting the string to date time and changing the format
        dob=[datetime.strptime(x, '%Y-%m-%d') for x in dob]
        dob=[dob[i].strftime('%m/%d/%y') for i in range(len(dob))]
        
        #Masking the SSN
        #ssn=[ssn[i][-4:].rjust(len(ssn[i]), "*") for i in range(len(ssn))]
        ssn = [re.sub("\d", "x", ssn[i][0:6])+ssn[i][-5:] for i in range(len(ssn))]

        #Mapping the state to two-letter Abbrieviation
        state =[us_state_abbrev[state[i]] for i in range(len(state))]
    out_file=os.path.splitext(os.path.basename(in_file))
    output_path1 = os.path.join(outpath, out_file[0]+'_new.csv')
    with open(output_path1, 'w', newline='') as csvfile:

        # Initialize csv.writer
        csvwriter = csv.writer(csvfile, delimiter=',')

        # Write the first row (column headers)
        csvwriter.writerow(['Emp ID','First Name','Last Name','DOB','SSN','State'])
    
        # Write the  rows
        for i in range(len(empid)):
            csvwriter.writerow([empid[i],firstname[i],lastname[i],dob[i],ssn[i],state[i]])
