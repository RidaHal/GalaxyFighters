class Vie extends Asteroide{
   private PImage bonus = loadImage("heartbon.png");
   
   public void show(){
     //montre les vies 
     tint(255,0,0);
     image(bonus,-super.x,super.y,25,25);     
   }
}
