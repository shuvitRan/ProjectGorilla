class WildAnimal {
  float  scale;
  PVector location, speed, goal;
  PVector mylocation;
  float anispeed;
  
  
  WildAnimal(float thisscale){
   
    //speed = myspeed;
    scale= thisscale;
    randomLocation();
    //mygoal = 
   
  }
  
  void update(){
    goal = new PVector(width/2, height/2);

   if(dist(mylocation.x,mylocation.y,width/2,height/2)>=10){
    goal.sub(mylocation);
    //if()
    goal.setMag(anispeed);
    speed = goal;
    //println(dist(mylocation.x,mylocation.y,width/2,height/2));
    mylocation.add(speed);
    
   }
   ellipse(mylocation.x, mylocation.y, scale, scale);
  }
  
  void randomLocation(){
  PVector[] seedsP= {new PVector(0, random(height)),
                     new PVector(width, random(height)),
                     new PVector(random(width),0),
                     new PVector(random(width),height)};
    anispeed = random(5);
    mylocation= seedsP[int(random(seedsP.length))];  
  }
  

}
