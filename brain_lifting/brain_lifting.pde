import oscP5.*;
import netP5.*;

KeyInput currentKeyInput;
GameSystem system;
OscListener oscListener;

boolean DEBUG = true;

final color BG_COLOR = color(0, 0, 0);
final color AXIS_COLOR = color(255, 0, 0);
final color GRAPH_COLOR = color(0, 0, 255);
final color LABEL_COLOR = color(255, 255, 0);
final int LABEL_SIZE = 21;

final int N_CHANNELS = 4;
final float EPS = 0.01;
final float PARAM_MAX_VALUE = 0.6; //alpha_relativeの最大値
final int PARAM_MAX_LEVEL = 4; //パラメータの最大レベル (1〜PARAM_MAX_LEVEL)
final int UPDATE_CNT = 50; //パラメータ更新の頻度

final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

void setup(){
  size(1000, 600,P3D);
  //frameRate(30);
  currentKeyInput = new KeyInput();
  system = new GameSystem();
  oscListener = new OscListener();
  smooth();
}

void mouseClicked () {
  if (system.gameover) system.reset();
  system.time=0;
  system.frame=0;
}
void draw(){
  system.run();
  if(DEBUG){
    oscListener.draw();
  }
}