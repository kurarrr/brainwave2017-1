import oscP5.*;
import netP5.*;

KeyInput currentKeyInput;
GameSystem system;
OscListener oscListener;
SecondApplet secondApplet;

boolean DEBUG = true;

final color BG_COLOR = color(0, 0, 0);
final color AXIS_COLOR = color(255, 0, 0);
final color GRAPH_COLOR = color(0, 0, 255);
final color LABEL_COLOR = color(255, 255, 0);
final int LABEL_SIZE = 21;
final int FRAME_RATE = 60;
final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

final int N_CHANNELS = 4;
final int BUFFER_SIZE = 220;
final float MAX_MICROVOLTS = 1.0;
final float DISPLAY_SCALE = 200.0;
final String[] LABELS = new String[] {
  "TP9", "FP1", "FP2", "TP10"
};

float[][] buffer = new float[N_CHANNELS][BUFFER_SIZE];
int pointer = 0;
float[] offsetX = new float[N_CHANNELS];
float[] offsetY = new float[N_CHANNELS];


void settings() {
  size(1000, 600,P3D);
}

void setup(){
  frameRate(FRAME_RATE);
  currentKeyInput = new KeyInput();
  system = new GameSystem();
  oscListener = new OscListener();

  smooth();
  
  secondApplet = new SecondApplet(this);
}

void draw(){
  system.run();
}