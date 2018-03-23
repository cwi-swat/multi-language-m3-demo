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

void main() {
  registerLanguage(JSTM, "jstm", start[JStm](str src, loc org) {
    return parse(#start[JStm], src, org);
  });
  
  registerContributions(JSTM, {
    annotator(Tree(Tree t) {
      if (start[JStm] pt := t) {
        loc javaFile = pt@\loc[extension="java"].top;
        M3 jm3 = m3(javaFile);
        rel[loc, loc] orgs = {}; 
        if (exists(javaFile)) {
          jm3 = createM3FromFile(javaFile);
          jpt = parse(#start[CompilationUnit], javaFile);
          orgs = recover(jpt);
        }
        m = stm2m3(pt);
        
        m.declarations += { <jentity, recoverLoc(jsrc, orgs)> | <loc jentity, loc jsrc> <- jm3.declarations };
        m.uses += { <recoverLoc(jsrc, orgs), jentity> | <loc jsrc, loc jentity> <- jm3.uses };
        registerProject(|project://<pt@\loc.authority>|, m);
        return annotateStm(pt, m);
      }
    }),
    builder(set[Message](start[JStm] pt) {
      loc javaFile = pt@\loc[extension="java"].top;
      writeFile(javaFile, compile(pt.top));
      return {};
    })
  });
}