package doors;
import java.util.List;
import java.util.ArrayList;
public class Doors {
  
  private static final int closed$state = 0;
  
  private static final int opened$state = 1;
  
  private static final int locked$state = 2;
   

  
  private static final String open$event = "OP2K"; 
  
  private static final String close$event = "CL2K"; 
  
  private static final String unlock$event = "UNLK"; 
  
  private static final String lock$event = "LCK"; 
  

  
  private List/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(99,4,<7,10>,<7,14>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(104,6,<7,15>,<7,21>) */> tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(112,6,<7,23>,<7,29>) */ = new ArrayList/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(125,9,<7,36>,<7,45>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(135,6,<7,46>,<7,52>) */>();
  

  private int $state = 0;
  
  public void step(String $token) {
      switch ($state) {
        
        case closed$state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(259,6,<15,4>,<15,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(266,3,<15,11>,<15,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(270,7,<15,15>,<15,22>) */("We're closed now");
              tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(303,6,<16,4>,<16,10>) */.add/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(310,3,<16,11>,<16,14>) */($token/*src: |project://multi-language-m3-demo/src/lang/jstm/Compile.rsc|(1635,6) */);
          
            if ($token.equals(open$event)) {
              $state = opened$state;
            }
          
            if ($token.equals(lock$event)) {
              $state = locked$state;
            }
          
          break;
        
        case opened$state:
          System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(396,6,<22,4>,<22,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(403,3,<22,11>,<22,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(407,7,<22,15>,<22,22>) */("We're opened now");
          
            if ($token.equals(close$event)) {
              $state = closed$state;
            }
          
          break;
        
        case locked$state:
          
          
            if ($token.equals(unlock$event)) {
              $state = closed$state;
            }
          
          break;
        
      }
  }    
}