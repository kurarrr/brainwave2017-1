void keyPressed(){
  //キーが入力されたとき
  if (key == CODED) {      // コード化されているキーが押された
    //if (keyCode == RIGHT) {    // キーコードを判定
    //      x += speed;
    //} else if (keyCode == LEFT) {
    //       x -= speed;
    //}
  }
  
  currentKeyInput.lastkey = key;
}

void keyReleased(){
  //キーが離されたとき
  System.out.println("released "+key);
}

class KeyInput{
   char lastkey;
}