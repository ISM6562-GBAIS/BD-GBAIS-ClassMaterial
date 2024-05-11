#!/usr/bin/env python


from operator import itemgetter
import sys
"""This program received a stdin in pipe from mappers. Each mapper will send a word
and count (each count will be one), and so multiple words will represents as multiple
entries in the list. Hadoop sorts the by words. Therefore, reducing this requires us
to count similar words and print output word + count when a transition from one word
to the next occurs. We have a special end case, because the last word will not see 
a transition to a new word, we need to add one last print outside the loop."""
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

