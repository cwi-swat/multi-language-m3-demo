module lang::jstm::M3

import analysis::m3::Core;
import lang::jstm::JStm;

import ParseTree;
import util::IDE;
import Message;	
import IO;
	
data M3(
  rel[loc from, loc to] mapsTo = {}
);
	
	
M3 stm2m3(start[JStm] stm) {
  M3 m = m3(stm@\loc);
  
  str pkg = "/<stm.top.ctl.name>";
  
  if ((PackageDec)`<Anno* _> package <PackageName pkgName>;` := stm.top.pkg.args[0]) { 
    pkg = "/<pkgName><pkg>";
  }
  
  loc stmName() = |stm+state://<pkg>|;
  loc stateName(Id s) = |stm+state://<pkg>/<"<s>">|;
  loc eventName(Id e) = |stm+event://<pkg>/<"<e>">|;
  loc transName(Id s, Id t) = |stm+transition://<pkg>/<"<s>">/<"<t>">|;
  
  m.declarations = { <stateName(s.name), s@\loc> | (ClassMemberDec)`<State s>` <- stm.top.ctl.members }
    + { <eventName(e.name), e@\loc> | (ClassMemberDec)`<Event e>` <- stm.top.ctl.members }
    + { <transName(s.name, t.event), t@\loc> | (ClassMemberDec)`<State s>` <- stm.top.ctl.members, Transition t <- s.transitions };
    
  m.uses = { <t.state@\loc, stateName(t.state)> | /Transition t := stm }
    + { <t.event@\loc, eventName(t.event)> | /Transition t := stm };
  
  m.containment = { <stmName(), stateName(s.name)> | (ClassMemberDec)`<State s>` <- stm.top.ctl.members }
    + { <stmName(), eventName(e.name)> | (ClassMemberDec)`<Event e>` <- stm.top.ctl.members }
    + { <stateName(s.name), transName(s.name, t.event)> | (ClassMemberDec)`<State s>` <- stm.top.ctl.members, Transition t <- s.transitions };
  
  m.mapsTo = { <stateName(s.name), |java+field:///<pkg>/<s.name>$state| > | (ClassMemberDec)`<State s>` <- stm.top.ctl.members }
    + { <stateName(s.name), |java+method:///<pkg>/dispatch$<s.name>| > | (ClassMemberDec)`<State s>` <- stm.top.ctl.members }
    + { <eventName(e.name), |java+field:///<pkg>/<e.name>$event| > | (ClassMemberDec)`<Event e>` <- stm.top.ctl.members }
    + { <stmName(), |java+class:///<pkg>| > };
 
  m.messages = [ error("Undefined event", use) | /Transition t := stm, loc use := t.event@\loc, <use, loc decl> <- m.uses, decl notin m.declarations<0> ]
    + [ error("Undefined state", use) | /Transition t := stm, loc use := t.state@\loc, <use, loc decl> <- m.uses, decl notin m.declarations<0> ];   
  
  return m;  
}


