module lang::jstm::Compile

import lang::jstm::JStm;
import lang::jstm::TrackIds;

import ParseTree;
import String;
import ValueIO;
import IO;

str compile(start[JStm] cu) = compile(cu.top);
  
str compile((JStm)`<PackageDec pkg> <ImportDec* ds> <Controller ctl>`)
  = "<pkg>
    '<ds>
    '<ctl2java(ctl)>";

str compile((JStm)`<ImportDec* ds> <Controller ctl>`)
  = "<ds>
    '<ctl2java(ctl)>";

str ctl2java((Controller)`statemachine <Id x> {<ClassMemberDec* ms>}`)
  = "public class <x> {
    '  <for (int i := 0, (ClassMemberDec)`<State s>` <- ms) {>
    '  private static final int <stateField(s.name)> = <i>;
    '  <i += 1; }> 
    '
    '  <for ((ClassMemberDec)`event <Id e> <StringLiteral tk>;`  <- ms) {>
    '  private static final String <eventField(e)> = <tk>; 
    '  <}>
    '
    '  <for (ClassMemberDec m <- ms, !(m is event), !(m is state)) {>
    '  <trackedJava(m)>
    '  <}>
    '
    '  private int $state = 0;
    '  
    '  public void step(String $token) {
    '      switch ($state) {
    '        <for ((ClassMemberDec)`state <Id s> {<BlockStm* ss> <Transition* ts>}` <- ms) {>
    '        case <stateField(s)>:
    '          <trackedJava(substTokenKeyword(ss))>
    '          <for ((Transition)`on <Id e> =\> <Id t>;` <- ts) {>
    '            if ($token.equals(<eventField(e)>)) {
    '              $state = <stateField(t)>;
    '            }
    '          <}>
    '          break;
    '        <}>
    '      }
    '  }    
    '}";

str stateField(Id s) = "<s>$state";

str eventField(Id e) = "<e>$event";

BlockStm* substTokenKeyword(BlockStm* ss)
  = visit (ss) { case (Expr)`token` => (Expr)`$token` };
  
