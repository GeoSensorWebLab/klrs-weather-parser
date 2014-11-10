# KLRS Weather Parser

This set of tools will parse `.dat` files from the KLRS Weather stations into a set of JSON files. Each sensor will become a separate datastream named `datastream-<COLUMN NAME>.json`, with the records for that column in `datastream-<COLUMN NAME>-records.json`.

These files can then be imported using `node-dataservice` or another tool.

## Usage

Install Ruby, preferably Ruby 2.1.4 or newer. Then use the `verify` tool to check the `.dat` file:

    $ bin/verify data/source/.../TOA5_5264.FiveMin.dat
    File: data/2012/September/TOA5_5264.FiveMin.dat
    Columns: 9
            Column 1: TIMESTAMP
                    units: TS
                    stats: 
                    readings: 0
            Column 2: RECORD
                    units: RN
                    stats: 
                    readings: 8286
                    Example: 2012-08-04 17:10 0
    ...

This will review the layout of the data in the file; check it to make sure it matches up with what you thought was in that file. Afterwards, you can convert the data to JSON files:

    $ bin/convert data/source/.../TOA5_5264.FiveMin.dat

This will create a set of JSON files in the current directory. One JSON file for each column (except TIMESTAMP column), and one JSON file for the records in each column.

The datastream JSON files can be fed into `node-dataservice`:

    $ cd node-dataservice
    $ bin/data-service create datastream <userUID> <sensorUID> < ~/.../datastream-COLUMN.json

Loading the records JSON is not yet supported in the current version of `node-dataservice`, but it would look like this if it did work:

    $ cd node-dataservice
    $ bin/data-service create records <datastreamUID>  < ~/.../datastream-COLUMN-records.json

I will update this README when that support is added.

## License

All rights reserved, GeoSensorWeb Lab.
