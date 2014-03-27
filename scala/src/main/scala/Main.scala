package wordcount

import scala.io.Source.fromFile

object Main extends App {
  //read in
  val text = fromFile("lorem.txt").mkString
 
  //group
  val wc = text.
           toLowerCase.
           split("\\W+").
           groupBy(identity).
           mapValues( _.length )
 
  //writeout
  wc.foreach( kv => printf("%s\t%d\n", kv._1, kv._2 ) )
 }

