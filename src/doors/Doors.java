package doors;
import java.util.List;
import java.util.ArrayList;
public class Doors {
  
    private static final int closed_state = 0;
  
    private static final int opened_state = 1;
  
    private static final int locked_state = 2;
   

  
    private static final String open_event = "OP2K"; 
  
    private static final String close_event = "CL2K"; 
  
    private static final String unlock_event = "UNLK"; 
  
    private static final String lock_event = "LCK"; 
  

  
    private List/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(99,4,<7,10>,<7,14>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(104,6,<7,15>,<7,21>) */> tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(112,6,<7,23>,<7,29>) */ = new ArrayList/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(125,9,<7,36>,<7,45>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(135,6,<7,46>,<7,52>) */>();
  
  
  public void run(java.util.Scanner input) {
    int $state = 0;
    while (true) {
      String $token = input.nextLine();
      switch ($state) {
        
        case closed_state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(259,6,<15,4>,<15,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(266,3,<15,11>,<15,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(270,7,<15,15>,<15,22>) */("We're closed now");
              if ($token/*src: |project://multi-language-m3-demo/src/lang/jstm/Compile.rsc|(1625,6) */.equals/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(313,6,<16,14>,<16,20>) */(tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(320,6,<16,21>,<16,27>) */)) {
                tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(337,6,<17,6>,<17,12>) */.add/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(344,3,<17,13>,<17,16>) */($token/*src: |project://multi-language-m3-demo/src/lang/jstm/Compile.rsc|(1625,6) */);
              }
          
            if ($token.equals(open_event)) {
              $state = opened_state;
            }
          
            if ($token.equals(lock_event)) {
              $state = locked_state;
            }
          
          break;
        
        case opened_state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(436,6,<24,4>,<24,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(443,3,<24,11>,<24,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(447,7,<24,15>,<24,22>) */("We're opened now");
          
            if ($token.equals(close_event)) {
              $state = closed_state;
            }
          
          break;
        
        case locked_state:
          
          
            if ($token.equals(unlock_event)) {
              $state = closed_state;
            }
          
          break;
        
      }
    }
  }    
}