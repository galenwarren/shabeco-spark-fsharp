Simple demo of using Spark with Python and F#.

First, clone the repo and change into the root folder. The commands below should be run in Powershell on Windows, any shell on Linux, from the root folder of the repo. [Docker](https://docs.docker.com/engine/installation/) must be installed.

Run the following to build the docker image with Spark, Python, Mono/F#, and Mobius. This will take a few minutes but only has to be done once. This uses Spark v2.0.2 as this is apparently the highest version supported by the current version of Mobius.

```docker build --force-rm -t spark-fsharp-python-demo:latest .```

If running on Linux, run the following to ensure permissions are set properly (not necessary if on Windows):

```chmod 755 fsharp/sample.sh.exe```

Run the following to open the interactive PySpark shell (ctrl-d exits). Note that there is apparently an interactive F# shell as well, but it would only work on a true Windows installation, and in this case the base image is Ubuntu.

```docker run -it --rm spark-fsharp-python-demo:latest```

Run the following to run a Python Spark job, which just does a simple aggregation over a sample dataset of zip codes. The script is [here](./python/sample.py).

```docker run -it -v ${PWD}:/opt/project spark-fsharp-python-demo spark/bin/spark-submit --master local /opt/project/python/sample.py project/zips.json```

Run the following to do the same thing but using F# instead. The code is [here](./fsharp/sample/Program.fs).

```docker run -it -v ${PWD}:/opt/project spark-fsharp-python-demo mobius/runtime/scripts/sparkclr-submit.sh --master local --exe sample.sh.exe project/fsharp project/zips.json```
