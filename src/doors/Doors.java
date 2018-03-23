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
  

  
    private List/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(100,4,<8,10>,<8,14>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(105,6,<8,15>,<8,21>) */> tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(113,6,<8,23>,<8,29>) */ = new ArrayList/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(126,9,<8,36>,<8,45>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(136,6,<8,46>,<8,52>) */>();
  
  
  public void run(java.util.Scanner input) {
    int $state = 0;
    while (true) {
      String $token = input.nextLine();
      switch ($state) {
        
        case closed_state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(260,6,<16,4>,<16,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(267,3,<16,11>,<16,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(271,7,<16,15>,<16,22>) */("We're closed now");
              tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(304,6,<17,4>,<17,10>) */.add/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(311,3,<17,11>,<17,14>) */($token/*src: |project://multi-language-m3-demo/src/lang/jstm/Compile.rsc|(1625,6) */);
          
            if ($token.equals(open_event)) {
              $state = opened_state;
            }
          
            if ($token.equals(lock_event)) {
              $state = locked_state;
            }
          
          break;
        
        case opened_state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(397,6,<23,4>,<23,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(404,3,<23,11>,<23,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(408,7,<23,15>,<23,22>) */("We're opened now");
          
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