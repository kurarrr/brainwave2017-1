void keyPressed(){
  //キーが入力されたとき
  if (key == CODED) {      // コード化されているキーが押された
    if (keyCode == RIGHT) {    // キーコードを判定
        system.sidemove = 1;
    } else if (keyCode == LEFT) {
        system.sidemove = -1;
    } else if (keyCode == UP){
        system.lengthmove=1;
    } else if (keyCode==DOWN){
        system.lengthmove =-1;
    }
  }
  
  currentKeyInput.lastkey = key;
}

void keyReleased(){
  //キーが離されたとき
  if (key == CODED) {      // コード化されているキーが押された
    if (keyCode == RIGHT) {    // キーコードを判定
        system.sidemove = 0;
    } else if (keyCode == LEFT) {
        system.sidemove = 0;
    } else if (keyCode == UP){
        system.lengthmove0;
    } else if (keyCode==DOWN){
        system.lengthmove =0;
    }

class KeyInput{
   char lastkey;
}