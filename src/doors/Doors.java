package doors;
import java.util.List;
import java.util.ArrayList;
public class Doors {
  
  private static final int closed$state = 0;
  
  private static final int opened$state = 1;
   

  
  private static final String open$event = "OP2K"; 
  
  private static final String close$event = "CL2K"; 
  

  
  private List/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(99,4,<7,10>,<7,14>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(104,6,<7,15>,<7,21>) */> tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(112,6,<7,23>,<7,29>) */ = new ArrayList/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(125,9,<7,36>,<7,45>) */<String/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(135,6,<7,46>,<7,52>) */>();
  

  private int $state = 0;
  
  
  private void dispatch$closed(String $token) {
     System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(216,6,<13,4>,<13,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(223,3,<13,11>,<13,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(227,7,<13,15>,<13,22>) */("We're closed now");
         tokens/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(260,6,<14,4>,<14,10>) */.add/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(267,3,<14,11>,<14,14>) */($token/*src: |project://multi-language-m3-demo/src/lang/jstm/Compile.rsc|(1856,6) */);
     
       if ($token.equals(open$event)) {
          $state = opened$state;
        }
     
  }
  
  private void dispatch$opened(String $token) {
     System/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(330,6,<19,4>,<19,10>) */.out/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(337,3,<19,11>,<19,14>) */.println/*src: |project://multi-language-m3-demo/src/doors/Doors.jstm|(341,7,<19,15>,<19,22>) */("We're opened now");
     
       if ($token.equals(close$event)) {
          $state = closed$state;
        }
     
  }
  
  public void step(String $token) {
      switch ($state) {
        
        case closed$state:
          dispatch$closed($token);  
          break;
        
        case opened$state:
          dispatch$opened($token);  
          break;
        
      }
  }    
}