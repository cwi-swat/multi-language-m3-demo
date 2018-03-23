module lang::jstm::TrackIds

import lang::java::\syntax::Java15;

import ParseTree;
import String;
import ValueIO;

str trackedJava(Id x) = "<x>/*src: <x@\loc> */";

str trackedJava(char(int n)) = stringChar(n);
  
default str trackedJava(appl(_, list[Tree] args))
  = ( "" | it + trackedJava(a) | Tree a <- args );
  
rel[loc, loc] recover(start[CompilationUnit] pt)
  = recoverOrigins(pt.args[1], pt.args[2]);
  
rel[loc, loc] recoverOrigins(char(_), _) = {};

rel[loc, loc] recoverOrigins(Id x, Tree k) 
  = { <x@\loc, readTextValueString(#loc, l)> }
  when /^\/\*src: <l:[^*]*> \*\// := "<k>"; 
  
default rel[loc, loc] recoverOrigins(appl(_, list[Tree] args), Tree k)
  = ( {} | it + recoverOrigins(args[i], i == size(args) - 1 ? k : args[i+1]) | int i <- [0..size(args)] );

loc recoverLoc(loc l, rel[loc, loc] orgs) = r
  when 
    // lengths are borked by M3 (includes whitespace after tokens)
    <loc m3loc, loc r> <- orgs, m3loc.path == l.path, m3loc.offset == l.offset;
    
default loc recoverLoc(loc l, rel[loc, loc] orgs) = l;
