# Creating a CNAB bundle

Use the `make_bundle.sh` script to create a new bundle. This script expects `chart_name` and `chart_url` as parameters.
Example:
To create a `mysql` chart from the stable repository use the following command:
```
./make_bundle.sh mysql https://kubernetes-charts.storage.googleapis.com
```
