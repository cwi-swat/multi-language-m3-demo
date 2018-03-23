module lang::jstm::JStm

extend lang::java::\syntax::Java15;

start syntax JStm 
  = PackageDec? pkg ImportDec* imports Controller ctl;
 
syntax Controller = "statemachine" Id name "{" ClassMemberDec* members "}"; 

syntax ClassMemberDec
  = event: Event
  | state: State
  ;

syntax Expr
  = "token";
  
keyword Keyword
  = "token";

syntax Event = event: "event" Id name StringLiteral token ";";

syntax State  
  = "state" Id name "{" BlockStm* actions Transition* transitions "}";

syntax Transition 
  = "on" Id event "=\>" Id state ";"
  ; 
