module lang::jstm::IDE

import lang::jstm::JStm;
import lang::jstm::Compile;
import lang::jstm::M3;
import lang::jstm::TrackIds;


import util::IDE;
import ParseTree;
import Message;
import IO;

import analysis::m3::Core;
import analysis::m3::Registry;
import lang::java::m3::Core;


private str JSTM = "JStm";

M3 mergeM3s(M3 jstm, M3 j, rel[loc, loc] orgs) {
  jstm.declarations += { <jentity, recoverLoc(jsrc, orgs)> | <loc jentity, loc jsrc> <- j.declarations };
  jstm.uses += { <recoverLoc(jsrc, orgs), jentity> | <loc jsrc, loc jentity> <- j.uses };
  jstm.messages += [ msg[at=recoverLoc(msg.at, orgs)] | Message msg <- j.messages ];
  return jstm;
}

void main() {
  registerLanguage(JSTM, "jstm", start[JStm](str src, loc org) {
    return parse(#start[JStm], src, org);
  });
  
  
  registerContributions(JSTM, {
    
    annotator(Tree(Tree t) {
      if (start[JStm] pt := t) {

        M3 jstm = stm2m3(pt);

        str javaCode = compile(pt.top);
        loc javaFile = pt@\loc[extension="java"].top;
        M3 jm3 = createM3FromString(javaFile, javaCode, errorRecovery = true);
        
        jpt = parse(#start[CompilationUnit], javaCode, javaFile);
        orgs = recover(jpt);

        jstm = mergeM3s(jstm, jm3, orgs);
        
        registerProject(|project://<pt@\loc.authority>|, jstm);
        
        return annotateStm(pt, jstm);
      }
    }),
    
    builder(set[Message](start[JStm] pt) {
      loc javaFile = pt@\loc[extension="java"].top;
      writeFile(javaFile, compile(pt.top));
      return {};
    })
  });
}