# Data Analysis Program


## Comparison between two excel files 
[1] data_selecting.m

* Matlab 2016

* Save - selected data
```
>> xlswrite('C:\data_out.xlsx',originxlsx);
```

* Find - selected cell
```
>> patient=originxlsx(2,17);
>> [m,n]=find(originxlsx==patient);
>> m
```
