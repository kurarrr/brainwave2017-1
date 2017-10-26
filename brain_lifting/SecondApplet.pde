class SecondApplet extends PApplet {
  PApplet parent;
  
  SecondApplet(PApplet _parent) {
    super();
    // set parent
    this.parent = _parent;
    //// init window
    try {
      java.lang.reflect.Method handleSettingsMethod =
        this.getClass().getSuperclass().getDeclaredMethod("handleSettings", null);
      handleSettingsMethod.setAccessible(true);
      handleSettingsMethod.invoke(this, null);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    
    PSurface surface = super.initSurface();
    surface.placeWindow(new int[]{0, 0}, new int[]{0, 0});
    
    this.showSurface();
    this.startSurface();
  }
  
  void settings() {
    size(1000, 600);
  }
  
  void setup() {
    frameRate(30);
    smooth();
  }
  
  void draw() {
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