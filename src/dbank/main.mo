import Debug "mo:base/Debug"; // import motoko debug package 
import Time "mo:base/Time";
import Float "mo:base/Float";

// all expression in motoko finished with ';' 

// to create a canister like an object on OOP
actor DBank {
  stable var currentValue: Float = 300; // stable : persistent variable (orthogonal persistance)
  //once the state change, this is keeped in each cycle 
  
  //currentValue := 100; // replace the older value with a new one 
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  let id =  215454215241; // let: the data never change 
  //id := 4454154; // do not to work  
  //Debug.print("Hello"); // print: only with str 
  //Debug.print(debug_show(currentValue)); // for printing other type of data like vars
  Debug.print(debug_show(id));

  //private function 
  /*func topUp(){
    currentValue += 1;
    Debug.print(debug_show(currentValue));
  };*/

  // Updated methods
  // public function 
  public func topUp(amount: Float){ // parameterName: type, Nat : natural number , Float: floating number
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  }; // never forget the ';'

  public func withdrawl(amount: Float){ // parameterName: type
    let tempValue:Float = currentValue - amount;
    if(tempValue>=0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Error :(");
    }
  };

  // query call : time execution very less vs updating methods
  // to see easily the updates 
  public query func checkBalance(): async  Float {
    return currentValue;
  };
  //can run the function on the terminal like :
  //dfx canister call dbank setUp  
  
  //at the place we can test the function with canndi ui, after deploy : dfx deploy
  
  //calculating compound interest: formula 
  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime-startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;  
  };
  //topUp();
}
