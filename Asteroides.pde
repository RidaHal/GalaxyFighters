class Asteroide {
   private float y = random(height);
   private float x = random(-3600,-1600);
   //postions aléatoire mais à droite de l'écran des astéroides
   private float xspeed=random(1,3.0001);
   private float yspeed=random(-1.5,1.5);
   //gère la vitesse aléatoirement delon x et y des astéroides
   private float bublesize = random(20,35);
   //gère la taille
   private PImage aster = loadImage("asteroide.png") ;
   
   public void move(){
     //gère le mouvcement des astéroïdes
      x = x + xspeed;
      y+=yspeed;
      if (y>height||y<25) {
        y = random(-2600,-1500);
        yspeed=random(-1.5,1.5);
      }
     if(x>width){
       x = random(-2600,-1500);
       xspeed=random(1,3.0001);
     } 
     if(y<=25) {
       y=25;
     }
     if(y>=700) {
       yspeed*=-1;
     }
   }
   
   public void show(){
     //montre les astéroïdes
     image(aster,-x-3,y-3,bublesize,bublesize);
   }
}
