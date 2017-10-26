
void oscEvent(OscMessage msg){
  oscListener.listen(msg);
}

final class OscListener{

  
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
      for(int ch = 0; ch < N_CHANNELS; ch++){
        data = msg.get(ch).floatValue();
        //data = (data - (MAX_MICROVOLTS / 2)) / (MAX_MICROVOLTS / 2); // -1.0 1.0
        //println(data);
        buffer[ch][pointer] = data;
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