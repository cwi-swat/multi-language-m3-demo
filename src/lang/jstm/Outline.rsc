module lang::jstm::Outline

import lang::jstm::JStm;
import lang::jstm::M3;

import analysis::m3::Core;
import ParseTree;

node outline(start[JStm] pt, M3 m3) {
  states = [""()[@label="<s.name>"][@\loc=s@\loc] | /State s := pt ];
  events = [""()[@label="<e.name>: <e.token>"][@\loc=e@\loc] | /Event e := pt ];
  trans = [""()[@label="<t.event> =\> <t.state>"][@\loc=t@\loc] | /Transition t := pt ];
  
  return ""([
    "events"(events)[@label="Events"],
    "states"(states)[@label="States"],
    "trans"(trans)[@label="Transitions"]
  ]);
} 
