import com.phidget22.*;
int timer;
int wave;
int c;
double factor;
double angle;
RCServo test; 
Enemy enemies[];
int lives;
int missile_counter;
float joypad1_init;
float joypad2_init;
VoltageRatioInput joypad1, joypad2, rota;
DigitalOutput LED1,LED2,LED3;
int shot;
int []counter;
int temp_timer;
VoltageRatioInput tempSensor;
double rota_init_value;
int rota_timer;
void setup(){
  frameRate(60);
  size(800,600);
  start();
  try{
    test=new RCServo();
    test.open(5000);
    joypad1=new VoltageRatioInput();
    joypad2=new VoltageRatioInput();
    joypad1.setDeviceSerialNumber(407802);
    joypad2.setDeviceSerialNumber(407802);
    joypad1.setChannel(0);
    joypad2.setChannel(1);
    joypad1.open();
    joypad2.open();
    
    rota=new VoltageRatioInput();
    rota.setDeviceSerialNumber(407802);
    rota.setChannel(2);
    rota.open();
    
    tempSensor=new VoltageRatioInput();
    tempSensor.setDeviceSerialNumber(407802);
    tempSensor.setChannel(3);
    tempSensor.open();
    
    LED1=new DigitalOutput();
    LED1.setDeviceSerialNumber(407802);
    LED1.setChannel(1);
    LED1.open();
    LED2=new DigitalOutput();
    LED2.setDeviceSerialNumber(407802);
    LED2.setChannel(3);
    LED2.open();
    LED3=new DigitalOutput();
    LED3.setDeviceSerialNumber(407802);
    LED3.setChannel(6);
    LED3.open();
  } catch(Exception e){
    System.out.println("1 - "+e);
  }
  
}
void start(){
  lives=2;
  wave=0;
  c=0;
}
void start_wave(){
  temp_timer=(int)300;
  timer=3600+(900*wave);
  factor=(double)180/(double)timer;
  angle=(double)180;
  enemies=new Enemy[timer/120];
  float t=1;
  for(int i=0;i<enemies.length;i++){
    float y=0-(t*(float)random(0,1));
    enemies[i]=new Enemy(y, (int)random(0,3));
    t++;
  }
  missile_counter=enemies.length+3;
  try{
    rota_init_value=rota.getVoltageRatio();
    test.setTargetPosition(180);
    test.setEngaged(true);
    joypad1_init=(float)joypad1.getVoltageRatio();
    joypad2_init=(float)joypad2.getVoltageRatio();
  } catch(Exception e){
  System.out.println("2 - "+e);
  }
}
void draw(){
  background(176,191,26);
  if(c==0){
    start_wave();
    c++;
  }
  if(check_wave()==0){
    if((angle-factor)>=0)
      angle-=factor;
    if(timer==0)
      System.exit(0);
    try{
      test.setTargetPosition(angle);
      test.setEngaged(true);
    } catch(Exception e){
    System.out.println("3 - "+e);
    }
    counter=new int[3];
    for(int i=0;i<enemies.length;i++)
      counter[enemies[i].l]++;
    fill(71,71,71);
    textAlign(CENTER);
    text("Wave:"+(wave+1)+ "\nLives:"+lives+ "\nMissiles Left:"+missile_counter,width/2,200);
    if(temp_timer!=300)
      text("\n\n\nReveal Ability Used",width/2,200);
    else
      text("\n\n\nReveal Ability Available to be used",width/2,200);
    try{
      if((tempSensor.getVoltageRatio()>=0.39 && temp_timer==300) || (temp_timer>=0 && temp_timer!=300)){
        double y=enemies[0].y;
        int templ=enemies[0].l;
        for(int i=0;i<enemies.length;i++){
          if(y>enemies[i].y && enemies[i].is_dead==false){
            templ=enemies[i].l;
            y=enemies[i].y;
          }
        }
        fill(71,71,71);
        textAlign(CENTER);
        text("\n\n\n\nNumber of Enemies left: "+enemies.length+ "\nClosest Enemy's lane:"+(templ+1)+"\nNumber of Enemies left in Lane 1:" +counter[0]+"\nNumber of Enemies left in Lane 2:"+counter[1]+"\nNumber of Enemies left in Lane 3:"+counter[2],width/2,200);
        temp_timer--;
      }
    }catch (Exception e){}
    timer--;
    try{
      if(shot==0 &&( joypad1.getVoltageRatio()<0.3 || joypad1.getVoltageRatio()>0.7 || joypad2.getVoltageRatio()<0.3 || joypad2.getVoltageRatio()>0.7 ))
        check_shot();
      else{
        joypad1_init=(float)joypad1.getVoltageRatio();
        joypad2_init=(float)joypad2.getVoltageRatio();
        if(joypad1.getVoltageRatio()>0.3 && joypad1.getVoltageRatio()<0.7 && joypad2.getVoltageRatio()>0.3 && joypad2.getVoltageRatio()<0.7 )
          shot=0;
      }
    } 
    catch(Exception e){
      System.out.println(e);
    }
    set_LED();
    move_enemies();
    for(int i=0;i<enemies.length;i++){
      if(enemies[i].check_collision()){
        lives--;
      }
    }
    remove_enemies();
    try{
      if(rota.getVoltageRatio()<rota_init_value && rota_init_value-rota.getVoltageRatio()>=0.05){
        double t=(double)rota_init_value/60;
        double tempFrameRate= 61-(((double)rota_init_value-(double)rota.getVoltageRatio())/t);
        rota_timer=(int)tempFrameRate*6;
        frameRate((float)tempFrameRate);
        rota_init_value=rota.getVoltageRatio();
      }
      if(rota_timer!=0){
        textAlign(CENTER);
        fill(71,71,71);
        text("Current Frame Rate:"+(int)frameRate,width/2,500);
        fill(71,71,71);
        text("\nTime left:"+rota_timer,width/2,500);
        rota_timer--;}
      if(rota_timer==0)
        frameRate(60);
        
    }catch(Exception e){
      System.out.println(e);
    }
  }
  if(check_wave()==1){
    wave++;
    start_wave();
  }
  if(check_wave()==2){
    background(140,22,22);
    textSize(32);
    textAlign(CENTER);
    fill(71,71,71);
    text("You Lost!\n Wave:"+(wave+1),width/2,height/2);
    try{
      LED1.setDutyCycle(0);
      LED2.setDutyCycle(0);
      LED3.setDutyCycle(0);
    } catch(Exception e){
      System.out.println(e);
    }
  }
}
int check_wave(){
  if(lives<=0)
    return 2;
  if(((int)angle==0 && lives>0) || enemies.length==0)
    return 1;
  return 0;
}

void shoot(int lane){
  if(missile_counter>0){
    for(int i=0;i<enemies.length;i++){
      if(lane==enemies[i].l && enemies[i].check_killable()){
        enemies[i].check_death(lane);
        break;
      }
    }
    missile_counter--;
  }
  remove_enemies();
  set_LED();
}
void set_LED(){
  int l1,l2,l3;
  l1=l2=l3=0;
  try{
    remove_enemies();
    for(int i=0;i<enemies.length;i++){
      if(enemies[i].y>=0){
        if(enemies[i].l==0)
          l1++;
        if(enemies[i].l==1)
          l2++;        
        if(enemies[i].l==2)
          l3++;
      }
    }
    if(l1>0)
      LED1.setDutyCycle(1);
    else
      LED1.setDutyCycle(0);
      
    if(l2>0)
      LED2.setDutyCycle(1);
    else
      LED2.setDutyCycle(0);
      
    if(l3>0)
      LED3.setDutyCycle(1);
    else
      LED3.setDutyCycle(0);
      
  } catch(Exception e){
    System.out.println("4 - "+e);
  }
}
void remove_enemies(){
  int t=enemies.length;
  for(int i=0;i<t;i++){
    if(enemies[i].is_dead==true){
      Enemy temp[]=enemies;
      enemies=new Enemy[temp.length-1];
      for(int j=0;j<i;j++)
        enemies[j]=temp[j];
      for(int j=i;j<enemies.length;j++)
        enemies[j]=temp[j+1];
    }
    t=enemies.length;
  }
}
void move_enemies(){
  for(int i=0;i<enemies.length;i++)
    enemies[i].move(wave+1);
}
void check_shot(){
  try{
    if(joypad2.getVoltageRatio()>=0.7){
      shoot(0);
    }
    if(joypad2.getVoltageRatio()<=0.3){
      shoot(2);
    }
    if(joypad1.getVoltageRatio()>=0.7){
      shoot(1);
    }
    if(joypad1.getVoltageRatio()<=0.3){
      shoot(1);
    }
    shot=1;
    joypad1_init=(float)joypad1.getVoltageRatio();
    joypad2_init=(float)joypad2.getVoltageRatio();
  } catch(Exception e){
    System.out.println("5 - "+e);
  }
}
