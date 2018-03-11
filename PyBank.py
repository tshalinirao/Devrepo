import os
import csv
path = '/Users/rangedh/UCBSAN201802DATA3-Class-Repository-DATA/Homework/03-Python/Instructions/PyBank/raw_data'
f = []
for filename in os.listdir(path):
    #print(filename)
    monthly_rev=[]
    months=[]
    monthly_change=[]
    change=0
    i=1
    total_rev=0
    greatest_increase=0
    smallest_increase=0
    greatest_month = ''
    smallest_month = ''
    with open(path+'/'+filename,'r',) as f:
        next(f)
        data=[tuple(line) for line in csv.reader(f)]
        #reader=csv.reader(f, delimiter=',')
        #     print(data[i][2])
        for name,rev in data:
         months.append(name)     
         monthly_rev.append(rev)

        for i in range(0,len(data)):
            #print(i,months[i])
            total_rev = total_rev+int(monthly_rev[i])
            #print(months[i])
            #change = (int(monthly_rev[i])-int(monthly_rev[i-1]))
           # print(change)
            
            #print(change)
            if i==0:
                change = int(monthly_rev[i])
                monthly_change.append(change)
                greatest_increase = change
                smallest_increase = change
                greatest_month = months[i]
                smallest_month = months[i]
            #this is not the first change in population size
            #update the trackers if relevent
            else:
                change = (int(monthly_rev[i])-int(monthly_rev[i-1]))
                monthly_change.append(change)
                if change>greatest_increase:
                    greatest_increase = change
                    greatest_month = months[i]
                elif change<smallest_increase:
                    smallest_increase = change
                    smallest_month = months[i]
            
        print("\n")
        print(filename,"   Financial Analysis")
        print('-------------------------')
        print('Total Months:',len(data))
        print('Total Revenue:',total_rev)
        average_change = sum(monthly_change)/int(len(data))
        print('Average Revenue Change:',"%.2f" %round(average_change))
        print('Greatest Increase in Revenue: ',greatest_month,' ',greatest_increase)
        print('Greatest Decrease in Revenue: ',smallest_month,' ',smallest_increase)
        print("\n")