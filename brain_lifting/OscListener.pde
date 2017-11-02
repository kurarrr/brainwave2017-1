void oscEvent(OscMessage msg){
  oscListener.listen(msg);
}

final class OscListener{
  final int N_CHANNELS = 4;
  final float EPS = 0.01;
  final float PARAM_MAX_VALUE = 1.0; //alpha_relativeの最大値
  final int PARAM_MAX_LEVEL = 10; //パラメータの最大レベル (1〜10)
  final int UPDATE_CNT = 10; //パラメータ更新の頻度
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
    data_sum = 0.0;
    if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
      for(int ch = 0; ch < N_CHANNELS; ch++){
        data = msg.get(ch).floatValue();
        data = Math.min(data,PARAM_MAX_VALUE - EPS); //大き過ぎたら丸める
        data_sum += data;
      }
    }
    params[cnt] = data_sum;

    if(++cnt == UPDATE_CNT){
      cnt = 0;
      int val_send;
      float data_ave = 0.0;
      for(int i = 0;i<UPDATE_CNT;i++){
        data_ave += params[i];
      }
      data_ave /= ((float)UPDATE_CNT * (float)N_CHANNELS * PARAM_MAX_VALUE ); //averageを[0,1)で正規化
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