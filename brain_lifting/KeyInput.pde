void keyPressed(){
  //キーが入力されたとき
  //if(currentKeyInput.lastkey != key){
  //  System.out.println("pressing "+key);
  //}
  outfile.flush(); 
  outfile.close(); 
  exit();
  
  currentKeyInput.lastkey = key;
}

void keyReleased(){
  //キーが離されたとき
  System.out.println("released "+key);
}

class KeyInput{
   char lastkey;
}