A = load 'wordcount-input/lorem.txt' as (f1:chararray);
B = foreach A generate flatten((tokenize(f1)) as word;
C = foreach B generate LOWER(REPLACE(word,'\\W+',''));
D = group C by word;
E = foreach D generate group, COUNT(C);
store D into 'wordcount-pig-output';
