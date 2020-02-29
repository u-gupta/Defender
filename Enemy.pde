class Enemy{
  double x,y;
  boolean is_dead;
  int l;
  boolean is_killable;
  Enemy(double y, int l){
    this.y=y;
    this.l=l;
    y=l*200;
    is_dead=false;
    is_killable=false;
  }
  boolean check_collision(){
    if(y>=10)
      is_dead=true;
    return is_dead;
  }
  boolean check_death(int shot_l){
    if(is_dead==false && l==shot_l)
      is_dead=true;
    return is_dead;
  }
  boolean check_killable(){
    if(y>0)
      is_killable=true;
    return is_killable;
  }
  void move(int wave){
    y+=(((float)1/120)*((float)(wave+1)/4));
  }
}
