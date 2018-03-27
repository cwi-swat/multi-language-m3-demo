module lang::jstm::Visualize

import lang::jstm::JStm;

import salix::Core;
import salix::App;
import salix::HTML;
import salix::lib::Highlight;
import salix::lib::Dagre;



alias Model = start[JStm];

App[Model] jstmApp(start[JStm] pt)
  = app(Model() { return pt; }, view, update, |http://localhost:7223/index.html|,
      |project://multi-language-m3-demo/src|);


data Msg;

Model update(Msg _, Model pt) = pt;

void view(Model pt) {
  div(() {
    
    h2("JStm <pt.top.ctl.name>");
    
    h3("Code");
    for (ClassMemberDec cd <- pt.top.ctl.members, !(cd is event), !(cd is state)) {
      highlightToHtml(cd);
    }
    
    h3("Events");
    
    table(() {
      thead(() {
        th("Event");
        th("Token");
      });
      tbody(() {
	    for ((ClassMemberDec)`event <Id e> <StringLiteral token>;` <- pt.top.ctl.members) {
	      tr(() {
	        td("<e>");
	        td("<token>");
	      });
	    }
      });
    });
    
    
    h3("State machine");
    
    dagre("mygraph", rankdir("LR"), width(960), height(600), (N n, E e) {
      for ((ClassMemberDec)`state <Id x> {<BlockStm* stms> <Transition* _>}` <- pt.top.ctl.members) {
        n("<x>", shape("ellipse"), () { 
          div(() {
	          h3(style(<"color", "black">), "<x>");
	          div(() {
	            highlightToHtml(stms);
	          });
	        });
        });
      }
      for ((ClassMemberDec)`state <Id x> {<BlockStm* _> <Transition* ts>}` <- pt.top.ctl.members) {
        for (Transition t <- ts) {
          e("<x>", "<t.state>", lineInterpolate("basis"), edgeLabel("<t.event>"));
        }
      }
    });    
    
  });
}
