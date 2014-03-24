#!/usr/bin/python

#readin and filter
txt = [c for c in open('lorem.txt').read().lower() if c.isalpha() or c==' ']
 
#groupBy in a dictionary
wc = dict()
for w in ''.join(txt).split():
  wc[w] = wc.setdefault(w, 0) + 1
 
#output
for k,v in wc.iteritems():
   print('{0}\t{1}'.format(k,v))