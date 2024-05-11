/usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -file mapper.py, reducer.py
    -input /mapreduce/test.txt \
    -output /mapreduce/output01
    -mapper mapper.py \
    -reducer reducer.py