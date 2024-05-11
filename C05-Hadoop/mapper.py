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

