NOTE: Benchmarking a number of data greater than 100,000 might take a while

* bundle install
* rails console

##### Benchmark for Inserting Data
```
ActiveRecordImporter::PatientLabInsertService.start_insert_benchmark(1000)
```

##### Result:

```
                                                        user     system      total        real
Simple Insert:                                       3.134191   1.015878   4.150069 (  4.915382)
Simple Insert with Transaction:                      1.336409   0.780967   2.117376 (  2.259713)
Bulk Insert with Transaction:                        0.538226   0.214294   0.752520 (  0.767453)
Final Optimised Bulk Insert:                         0.551018   0.219907   0.770925 (  0.784783)
```


##### Benchmark for Updating Data
```
ActiveRecordImporter::PatientLabUpdateService.start_update_benchmark(1000)
```

##### Result

```
                                                        user     system      total        real
Simple Update:                                       1.522495   1.175135   2.697630 (  3.406361)
Simple Update with Transaction:                      1.111119   1.018791   2.129910 (  2.329951)
Bulk Update with Transaction:                        0.227654   0.415430   0.643084 (  0.664804)
```



##### Importing 100,000 data
<img width="681" alt="Screenshot 2021-06-03 at 8 36 04 PM" src="https://user-images.githubusercontent.com/18898399/120767704-03fd8780-c54e-11eb-9248-345c885acc7d.png">

##### Updating 100,000 data
<img width="680" alt="Screenshot 2021-06-03 at 9 00 19 PM" src="https://user-images.githubusercontent.com/18898399/120767968-4aeb7d00-c54e-11eb-8b2b-db52319f8feb.png">
