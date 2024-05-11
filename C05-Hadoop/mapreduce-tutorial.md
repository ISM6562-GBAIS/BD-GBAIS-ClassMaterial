# MapReduce Tutorial

## Create and test the mapper and reducer programs

*  log in to the CyberHub VM
  
* create a project folder in your home folder, let's call it `mapreduce`

```bash
cd ~ 
mkdir mapreduce
``

* create python2.7 environmnet

```bash
conda create -n py27 python=2.7
```  

* switch to python2.7 environment

```bash
conda activate py27
```

---

## Create Mapper and Reducer to count words

* start vscode in the mapreduce folder

```bash
cd ~/mapreduce
code .
```

* create mapper.py by copying and pasting the following code:

```python
  #!/usr/bin/env python

# for every word received print the word, and count 1
# Hadoop will sort these words, and stream result susing
# stdin to the reducer.
import sys

for line in sys.stdin: # look through data that is piped into this program
    line = line.strip()
    line = line.lower()
    words = line.split()

    for word in words:
        if len(word) == 0:
            print '%s\t%s' % ("UNKOWN", 1)
        else:
            print '%s\t%s' % (word, 1)
```

* start a terminal in the local folder. This can be done within vscode by pressing `ctrl+``, or starting the terminal program and navigating to the folder.

* Change permissions of mapper.py to executable. 
  
`chmod +x mapper.py`

* Test mapper.py by running `cat test.txt | ./mapper.py`. This should produce a list of words and the number 1 for each word.

* Using the shell's built in sort command, add a sort (to similar shuffle and sort that mapreduce will do) by running `cat test.txt | ./mapper.py | sort`

* in vscode, create reducer.py by copying and pasting the following code:

```python

#!/usr/bin/env python

from operator import itemgetter
import sys

current_word = None
current_count = 0
word = None
for line in sys.stdin: # read all stdin line by line (like it was a file)

    # strip and split the word count pair    
    line = line.strip()
    word, count = line.split('\t')
    count = int(count)
    
    # if we have a new word
    if current_word != word and current_word != None:
        print '%s\t%s' % (current_word, current_count)
        current_count = 0
    
    current_word = word
    current_count += count

# since at the end of our loop, we haven't seen a 'transition' from one word to another
# we need to print this here.
print '%s\t%s' % (current_word, current_count)
```

* Change reducer.py to executable `chmod +x reducer.py`

* Test reducer.py by running `cat test.txt | ./mapper.py | sort | ./reducer.py`

---

## Setup Mapreduce job in Cloudera Hadoop

* Copy your test.txt, mapper.py and reducer files into the shared-directory `/home/admin/Workspace/bd24-STUDENT/Docker/Cloudera/shared-storage`

* Now that these files are in the Cloudera shared-folder, you can access them inside the Cloudera container. Attach a terminal to the cloudera container by running `docker exec -it cloudera bash`
  
* Change directory to /home/cloudera/DEV01 (which is mapped to the local shared folder)

```bash
cd /home/cloudera/DEV01
```

* Run `ls` you should see the files you copied into the shared folder.

* Create a directory on the hdfs file system called mapreduce

```bash
hdfs dfs -mkdir /mapreduce
```

* Change the permissions on the directory

```bash
hdfs dfs -chmod 777 /mapreduce
```

* Copy test.txt into the hdfs file system

```bash
hdfs dfs –copyFromLocal test.txt /mapreduce/test.txt
```

* Run the Hadoop-streamer (this will run the mapreduce job)

```bash
/usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -file /mapreduce/mapper.py    -mapper /mapreduce/mapper.py \
    -file /mapreduce/reducer.py   -reducer /mapreduce/reducer.py \
    -input /user/cloudera/test.txt \
    -output /user/cloudera/output
```

* Investigate results

These will be found on your hdfs file location /user/cloudera/output

```bash
hdfs dfs -cat /user/cloudera/output/part-00000
```

