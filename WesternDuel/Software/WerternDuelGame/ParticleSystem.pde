import java.util.*;
class Particle //Establishing Particle object
{
  float x = width/2;
  float y = height/2;
  //float xv = random(1)-.5;
    float xv = random(2,8);
  float yv = -random(0,.5);
  float maxYV = 20;
  float gravity = 0.1;
  float friction = 1;
  float radius = random(.2,1.5);
  color c = color(0,0,0,random(200));
   
  Particle(){  
  }
 
  Particle(float xp,float yp)
  {
    x = xp;
    y = yp;
  }
 
  Particle(float xp,float yp,float xvel,float yvel)
  {
    this(xp, yp);
    xv = xvel;
    yv = yvel;
  }
 
 public void update() //Let's the balloon move through the canvas.
  {
    if((yv < maxYV))
    {
      yv -= gravity*.2;
    }
    
    if(y<height){
    yv *= friction;
    y -= yv;
    x -= xv;
    }
    
/*  If you want the snowflakes to stop at the ceiling, uncomment this. 
    if(y <= 0+radius){
      xv = 0;
      yv = 0;
      y = 0 + radius;
    }
*/    
  }

  void render() 
  {
    noStroke();
    fill(c); //For the actual balloon
    ellipse(x,y,radius,radius);
  }
 
  void run() 
  {
    update();
    render();
  }
 
  
}

class ParticleSystem
{
  ArrayList particles = new ArrayList();
  
  ParticleSystem(){
  }
   
  void add(Particle p)
  {
    particles.add(p);
    
    if(particles.size()>600){
    
     particles.subList(0, 300).clear();
    }
    
  }
   
  void removeAll()
  {
    particles.clear();
  }
   
  void run()
  {
    for(int i = 0; i < particles.size(); i++)
    {
      Particle p = (Particle)particles.get(i);
      p.run();
    }
  }
}
