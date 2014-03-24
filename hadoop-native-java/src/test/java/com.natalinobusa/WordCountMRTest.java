package com.natalinobusa;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mrunit.mapreduce.MapDriver;
import org.apache.hadoop.mrunit.mapreduce.ReduceDriver;
import org.apache.hadoop.mrunit.mapreduce.MapReduceDriver;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.TestCase.fail;

public class WordCountMRTest {

    /*
     * Declare harnesses that let you test a mapper, a reducer, and
     * a mapper and a reducer working together.
     */
    MapDriver<LongWritable, Text, Text, IntWritable> mapDriver;
    ReduceDriver<Text, IntWritable, Text, IntWritable> reduceDriver;
    MapReduceDriver<LongWritable, Text, Text, IntWritable, Text, IntWritable> mapReduceDriver;
  
    /*
     * Set up the test. This method will be called before every test.
     */
    @Before
    public void setUp() {

    /*
     * Set up the mapper test harness.
     */
        WordCountMapper mapper = new WordCountMapper();
        mapDriver = new MapDriver<LongWritable, Text, Text, IntWritable>();
        mapDriver.setMapper(mapper);

    /*
     * Set up the reducer test harness.
     */
        SumReducer reducer = new SumReducer();
        reduceDriver = new ReduceDriver<Text, IntWritable, Text, IntWritable>();
        reduceDriver.setReducer(reducer);
    
    /*
     * Set up the mapper/reducer test harness.
     */
        mapReduceDriver = new MapReduceDriver<LongWritable, Text, Text, IntWritable, Text, IntWritable>();
        mapReduceDriver.setMapper(mapper);
        mapReduceDriver.setReducer(reducer);
    }

    /*
     * Test the mapper.
     */
    @Test
    public void testMapper() {

    /*
     * For this test, the mapper's input will be "1 cat cat dog" 
     */
        mapDriver.withInput(new LongWritable(1), new Text("cat cat dog"));
	  
    /*
     * The expected output is "cat 1", "cat 1", and "dog 1".
     */
        mapDriver.withOutput(new Text("cat"), new IntWritable(1));
        mapDriver.withOutput(new Text("cat"), new IntWritable(1));
        mapDriver.withOutput(new Text("dog"), new IntWritable(1));
    
    /*
     * Run the test.
     */
        try {
            mapDriver.runTest();
        } catch (IOException e) {
            fail(e.getMessage());
            e.printStackTrace();
        }
    }

    /*
     * Test the reducer.
     */
    @Test
    public void testReducer() {

        List<IntWritable> values = new ArrayList<IntWritable>();
        values.add(new IntWritable(1));
        values.add(new IntWritable(1));

    /*
     * For this test, the reducer's input will be "cat 1 1".
     */
        reduceDriver.withInputKey(new Text("cat"));
        reduceDriver.withInputValues(values);

    /*
     * The expected output is "cat 2"
     */
        reduceDriver.withOutput(new Text("cat"), new IntWritable(2));

    /*
     * Run the test.
     */
        try {
            reduceDriver.runTest();
        } catch (IOException e) {
            fail(e.getMessage());
            e.printStackTrace();
        }
    }

    /*
     * Test the mapper and reducer working together.
     */
    @Test
    public void testMapReduce() {

    /*
     * For this test, the mapper's input will be "1 cat cat dog" 
     */

        mapReduceDriver.withInput(new LongWritable(1), new Text("cat cat dog"));
	  
    /*
     * The expected output (from the reducer) is "cat 2", "dog 1". 
     */

        mapReduceDriver.withOutput(new Text("cat"), new IntWritable(2));
        mapReduceDriver.withOutput(new Text("dog"), new IntWritable(1));
    /*
     * Run the test.
     */
        try {
            mapReduceDriver.runTest();
        } catch (IOException e) {
            fail(e.getMessage());
            e.printStackTrace();
        }
    }
}