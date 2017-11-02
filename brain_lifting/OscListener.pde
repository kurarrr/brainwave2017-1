
void oscEvent(OscMessage msg){
  oscListener.listen(msg);
}

final class OscListener{
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

  
  OscListener(){
    //コンストラクタ
      for(int ch = 0; ch < N_CHANNELS; ch++){
        offsetX[ch] = (width / N_CHANNELS) * ch + 15;
        offsetY[ch] = height / 2;
      }
  }
 
  void listen(OscMessage msg){
    //OscMessageを加工してゲームのパラメータにしてsystemの変数に渡す
    float data;
    if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
      if(DEBUG){
        for(int ch = 0; ch < N_CHANNELS; ch++){
          data = msg.get(ch).floatValue();
          outfile.print(data+",");
          //data = (data - (MAX_MICROVOLTS / 2)) / (MAX_MICROVOLTS / 2); // -1.0 1.0
          //println(data);
          buffer[ch][pointer] = data;
        }else{
          data = 
        }
      outfile.println("");
    }  
      pointer = (pointer + 1) % BUFFER_SIZE;
    }    
  }
  
  void draw(){
    //デバッグ用
    //脳波の描画が必要なときに呼ぶ
    
   float x1, y1, x2, y2;
    background(BG_COLOR);
    for(int ch = 0; ch < N_CHANNELS; ch++){
      for(int t = 0; t < BUFFER_SIZE; t++){
        stroke(GRAPH_COLOR);
        x1 = offsetX[ch] + t;
        y1 = offsetY[ch] + buffer[ch][(t + pointer) % BUFFER_SIZE] * DISPLAY_SCALE;
        x2 = offsetX[ch] + t + 1;
        y2 = offsetY[ch] + buffer[ch][(t + 1 + pointer) % BUFFER_SIZE] * DISPLAY_SCALE;
        line(x1, y1, x2, y2);
      }
      stroke(AXIS_COLOR);
      x1 = offsetX[ch];
      y1 = offsetY[ch];
      x2 = offsetX[ch] + BUFFER_SIZE;
      y2 = offsetY[ch];
      line(x1, y1, x2, y2);
    }
    fill(LABEL_COLOR);
    textSize(LABEL_SIZE);
    for(int ch = 0; ch < N_CHANNELS; ch++){
      text(LABELS[ch], offsetX[ch], offsetY[ch]);
    }
  }
}