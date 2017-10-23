void keyPressed(){
  //キーが入力されたとき
  if(currentKeyInput.lastkey != key){
    System.out.println("pressing "+key);
  }
  
  currentKeyInput.lastkey = key;
}

void keyReleased(){
  //キーが話されたとき
  System.out.println("released "+key);
}

class KeyInput{
   char lastkey;
}