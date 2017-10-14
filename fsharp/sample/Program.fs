open Microsoft.Spark.CSharp.Sql
open Microsoft.Spark.CSharp.Core
open System.Diagnostics
open System

// a custom filter function
let includeZipcode (zipcode: string) : bool = zipcode.EndsWith "3"

[<EntryPoint>]
let main argv = 
    // connect to spark
    let sparkContext = SparkContext(SparkConf().SetAppName("sample"))
    let sqlContext = SqlContext.GetOrCreate(sparkContext)

    // read in the file, name it 'zipcodes'
    sqlContext.Read().Json(argv.[0]).RegisterTempTable("zipcodes")

    // execute and print the results
    for stateResult in sqlContext.Sql("select state, count(*) from zipcodes group by state").Collect() do
        printfn "%A" stateResult

    0