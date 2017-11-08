void oscEvent(OscMessage msg){
  oscListener.listen(msg);
}

final class OscListener{
  int cnt = 0; //カウンター
  float params[] = new float[ UPDATE_CNT];
  
  OscListener(){
    //コンストラクタ
    cnt = 0;
    for(int i = 0;i<UPDATE_CNT;i++){
      params[i] = 0.0;
    }
  }
 
  void listen(OscMessage msg){
    //OscMessageを加工してゲームのパラメータにしてsystemの変数に渡す
    float data,data_sum;
    if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
      if(DEBUG) System.out.println("rawdata = "+msg.get(0).floatValue());
      data_sum = 0.0;
      for(int ch = 0; ch < N_CHANNELS; ch++){
        data = msg.get(ch).floatValue();
        data = Math.min(data,PARAM_MAX_VALUE - EPS); //大き過ぎたら丸める
        data_sum += data;
      }
    }else{
      data_sum = (float)(PARAM_MAX_VALUE * N_CHANNELS) /2.0;
    }
    params[cnt++] = data_sum;
    if(cnt == UPDATE_CNT){
      cnt = 0;
      int val_send;
      float data_ave = 0.0;
      for(int i = 0;i<UPDATE_CNT;i++){
        data_ave += params[i];
      }
      data_ave /= ((float)UPDATE_CNT * (float)N_CHANNELS * PARAM_MAX_VALUE ); //averageを[0,1)で正規化
      if(DEBUG) System.out.println("data_ave = "+data_ave);
      val_send = (int)(data_ave * (float)PARAM_MAX_LEVEL) + 1;
      
      system.set_brain_param(val_send);
    }
  }
  
  void draw(){
    if(DEBUG){
      System.out.println("param = " + system.brain_param + ", cnt = " + cnt);
    }
    //textSize(LABEL_SIZE);
    //for(int ch = 0; ch < N_CHANNELS; ch++){
    //  text(LABELS[ch], offsetX[ch], offsetY[ch]);
    //}
  }
}