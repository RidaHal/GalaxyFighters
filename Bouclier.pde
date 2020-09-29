class Bouclier extends Asteroide{
  PImage shield;
    
  public void show(){
    //montre les boucliers
    shield = loadImage("shieldbon.png");
    fill(0,255,0);
    stroke(0,255,0);
    tint(0,255,0);
    image(shield,-super.x,super.y,25,25);
   }
}
