A = load 'wordcount-input/lorem.txt' as (line:chararray);
B = foreach A generate FLATTEN(TOKENIZE(line)) as word;
C = foreach B generate LOWER(REPLACE(word,'\\W+','')) as word;
D = group C by word;
E = foreach D generate group, COUNT(C);
store E into 'wordcount-pig-output';
