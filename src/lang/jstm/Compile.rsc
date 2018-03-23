module lang::jstm::Compile

import lang::jstm::JStm;
import lang::jstm::TrackIds;

import ParseTree;
import String;
import ValueIO;
import IO;

str compile(start[JStm] cu)
  = compile(cu.top);
  
str compile((JStm)`<PackageDec pkg> <ImportDec* ds> <Controller ctl>`)
  = "<pkg>
    '<ds>
    '<ctl2java(ctl)>";

str compile((JStm)`<ImportDec* ds> <Controller ctl>`)
  = "<ds>
    '<ctl2java(ctl)>";

str ctl2java((Controller)`statemachine <Id x> {<ClassMemberDec* ms>}`)
  = "public class <x> {
    '  <for ((ClassMemberDec)`<State s>` <- ms) {>
    '    private static final int <s.name>_state = <i>;
    '  <i += 1; }> 
    '
    '  <for ((ClassMemberDec)`event <Id e> <StringLiteral tk>;`  <- ms) {>
    '    private static final String <e>_event = <tk>; 
    '  <}>
    '
    '  <for (ClassMemberDec m <- ms, !(m is event), !(m is state)) {>
    '    <trackedJava(m)>
    '  <}>
    '  
    '  public void run(java.util.Scanner input) {
    '    int $state = 0;
    '    while (true) {
    '      String $token = input.nextLine();
    '      switch ($state) {
    '        <for ((ClassMemberDec)`state <Id s> {<BlockStm* ss> <Transition* ts>}` <- ms) {>
    '        case <s>_state:
    '          <trackedJava(substTokenKeyword(ss))>
    '          <for ((Transition)`on <Id e> =\> <Id t>;` <- ts) {>
    '            if ($token.equals(<e>_event)) {
    '              $state = <t>_state;
    '            }
    '          <}>
    '          break;
    '        <}>
    '      }
    '    }
    '  }    
    '}"
  when int i := 0;


BlockStm* substTokenKeyword(BlockStm* ss)
  = visit (ss) { case (Expr)`token` => (Expr)`$token` };
  
