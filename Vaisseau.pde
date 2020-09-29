class Jeu {
  private boolean ilyacoli= false;
  private boolean ilaunevie= false;
  private int compteb = 0;
  private int comptec = 0;
  private int comptev = 0;
  private boolean ilaunbouclier= false;
  private boolean condition = false;
  //pour les collisions
  private int scorecourant=0;
  private int scoremini=0;
  private int scoremeilleur=0;
  //pour le score
  private PFont font1=null;
  //charge une police utilisée pour le texte
  private int etat=0;
  //gère les différents menus
  //la galaxie
  private int largeurgalax = 1280, hauteurgalax = 720;
  //donne les dimensions de l'écran
  private PImage galax1;
  private PImage galax2;
  private PImage galax3;
  //pour les backgrounds
  private int level=1;
  //gère le background selon le niveau
  private color grey = color(128), red=color(255,0,0), yellow=color(255,255,0), green = color(0,250,0);
  //gère les couleurs utilisées
  
  //le vaisseau
  private PImage vaisseau=null;
  //pour donner une image au vaisseau
  private PImage heart=null;
  private PImage shield, shieldo, coeur;
  //pour afficher les cœeurs représentants la vie
  private int nbvies = 3;
  private int nbbouclier = 0;
  private boolean vie = false;
  private boolean piste = false;
  private boolean bouclier = false;
  //gère le nombre de vies
  private int accx; 
  private int accy;
  private float xvelocite = 0;
  private float yvelocite = 0;
  private float velociterminale = 2.5;
  private float xaccel = 0.5;
  private float yaccel = 0.5;
  private float xpos = 30;
  private float ypos = hauteurgalax/2;
  //gèrent la position, la vitesse et l'accélération du vaisseau
  
  //gèrent la position, la vitesse et l'accélération de la piste d'atterrissage
  private int accx1=2; 
  private float xvelocite1 = 0;
  private float velociterminale1 = 0;
  private float xaccel1 = 0.5;
  private float xpos1 = largeurgalax+50;
  private float ypos1 = hauteurgalax-40;
    
  private PImage gft;
  //permet de charger le "GALAXY FIGHTERS" dans le menu de démarrage
  
  public void Controles(){
  //mettra à jour les positions du vaisseau selon les touches
    if (accy >0)
      accy-=1;
    if (accy <0)
      accy+=1;   
    if (accx >0)
      accx-=1;
    if (accx <0)
      accx+=1;
  }

  public void Acceleration(){    
  //permet l'accélération du vaisseau  
    xaccel= float(accx)/10;
    yaccel= float(accy)/10;
    //permet l'accélération de la piste
    xaccel1= float(accx1)/10;
}

  public void Position(){
  //pour les positions du vaisseau
    yvelocite+=yaccel;
    xvelocite+=xaccel;
    if (abs(yvelocite) > velociterminale){
      if (yvelocite > 0)
        yvelocite = velociterminale;
     else
       yvelocite = -velociterminale;
    }
    if (abs(xvelocite) > velociterminale){
      if (xvelocite > 0)
        xvelocite = velociterminale;
      else
        xvelocite = -velociterminale;
  }
    ypos += yvelocite;
    xpos += xvelocite;
  //pour le positionnement de la piste
   if(scorecourant==100) {
        if(xpos1>800){
           velociterminale1=2.5;
         }        
  }       
  xvelocite1+=xaccel1;
  if (abs(xvelocite1) > velociterminale1){
   if (xvelocite1 > 0)
    xvelocite1 = velociterminale1;
  }
  if(xpos1==900) {
            xvelocite1=0;
            xpos1=900;
         }
  xpos1 -= xvelocite1;
}

  public void chargeoutils() {
    //charge toutes les images et outils afin de faire fonctionner correctement le jeu
    vaisseau=loadImage("vaisseau.png");
    galax1=loadImage("galax1.jpg");
    galax2=loadImage("galax2.jpg");
    galax3=loadImage("galax3.jpg");
    gft=loadImage("gaga.png");
    heart=loadImage("heart.png");
    coeur=loadImage("heartbon.png");
    font1=loadFont("Tahoma-20.vlw");
    shieldo=loadImage("shieldbon.png");
    shield= loadImage("shield.png");
  }

  public void Pause() {
    //gère le fait de mettre en pause le jeu
   if (looping) {
     noLoop();
     stroke(255);
     fill(0,0,0,127);
     rect(130,70,1000,900);
     fill(255);
     textFont(font1,20);
     text("Pause! Appuyer sur ALT pour reprendre",145, 150);
     text("Commandes: flèches directionnelles pour se déplacer.\n\nRègles:\n- Vous devez traverser un champ d'astéroïdes avec votre vaisseau.\n- Vous avez 3 vies au départ.\n- Sortir de l'écran vous fera perdre.\n- Percuter des astéroïdes vous fera perdre des vies, si vous en avez plus c'est perdu.\n- Arriver à un score précis, une piste d'aterrissage apparaîtra en bas à droite, déposer le vaisseau dessus pour gagner\n- Différences entre les niveaux: - vitesse des astéroïdes\n                                                        - score à atteindre pour débloquer la piste \n\nBonus: ",145,190,1000,500);
     tint(0,255,0);
     image(shieldo,145,585);
     noTint();
     tint(255,0,0);
     image(coeur,145,525);
     noTint();
     text("Vous permet de gagner une vie\n\nVous permet d'être invincible pendant un court instant",185,550);

     }
  else loop();
  }

  public void Gameover() {
    //gère la défaite: première partie pour la sortie de l'écran et le reste gère, grâce à l'appel de la méthode collision(), lorsque le vaisseau touche un astéroïdes 
    if(xpos>largeurgalax-20||xpos<largeurgalax-largeurgalax-50||ypos>hauteurgalax-20||nbvies==0){
      nbvies=0;
      xpos = largeurgalax+20;
      stroke(0);
      fill(255,0,0,127);
      rect(377,145,500,350);
      fill(255);
      textFont(font1,90);
      fill(0);
      text("Game Over",405, 260);
      textFont(font1,25);
      text("score final : "+scorecourant ,535,380);
      if(scorecourant>=scoremeilleur) {
        scoremeilleur=scorecourant;
      }
      textFont(font1,15);
      text("      Appuyez sur Entrer pour recommencer\nAppuyez sur b pour revenir au menu principal.\n",470,450);
      text("Meilleur score : " + scoremeilleur,535,420);
      noFill();
      xaccel=0;
      yaccel=0;
      velociterminale=0;
      if(key==ENTER) {
         maj();
         etat=2;
      }
      if(key =='b'){
        maj();
        etat=0;
      }
    }
    collision();
    if(ypos<=25){
      ypos=25;
    }
  }
  //affichage de l'écran de victoire
  public void victoire() {
    piste=false;
    stroke(255);
    fill(0,0,100,127);
    rect(377,145,500,350);
    textFont(font1,90);
    fill(255);
    text("Victoire !!",430, 260);
    textFont(font1,25);
    text("score final : "+scorecourant ,535,380);
    //affichage d'un écran de score
    if(scorecourant>=scoremeilleur) {
      scoremeilleur=scorecourant;
    }
    textFont(font1,15);
    text("     Appuyez sur Entrer pour rejouer\nAppuyez sur b pour revenir au menu principal.\n",470,450);
    textFont(font1,25);
    text("Meilleur score : " + scoremeilleur,535,420);
    setup();
    xaccel=0;
    yaccel=0;
    velociterminale=0;
    if(key==ENTER){         
      maj();
      etat=5;
    }
    if(key =='b'){
      maj();
      etat=0;
    }
  }

  private void getCollision(int h, int w) {
    int ccolor;
    ccolor=get(int(xpos+w),int(ypos+h));
    if(ccolor==grey) {
      if (ilaunbouclier==false)
        if (ilyacoli==false)
          condition = true;
          ilyacoli=true; 
          } 
      
    else if(ccolor== red&&!ilaunevie) {
      vie=true;
      ilaunevie=true;    
    }
    else if(ccolor==yellow){
      piste = true;
    }
    else if(ccolor==green) {
      bouclier=true;
      ilaunbouclier=true;
    }
  }
    
  public void collision() {
    int h,w;
    for  (h=4; h<41; h++) { 
      for (w=1; w<27; w++) getCollision(h,w);
    }
     
    for (h = 5; h<40; h++) {
      for (w = 27; w<43; w++) getCollision(h,w);
    }
     
    for (h = 9; h<34; h++) {
      for (w = 43; w<57; w++) getCollision(h,w);
    }
    
    for (h=12; h<33; h++) {
      for (w=56; w<79; w++) getCollision(h,w);
    }
  }

 public void maj() {
   //permet de mettre à jour les valeurs du vaisseau et de la piste après avoir recommencé
   xpos = 30;
   ypos = height/2;
   xaccel= 0.5;
   yaccel= 0.5;
   velociterminale = 2.5;
   xvelocite = 0;
   yvelocite = 0;
   accx = 0;
   accy = 0;
   accx1 = 2;
   xvelocite1 = 0;
   velociterminale1 = 0;
   xaccel1 = 0.5;
   xpos1 = largeurgalax+20;
   ypos1 = hauteurgalax-40;
   condition=false;
   scorecourant = 0;
   nbvies=3;
   nbbouclier=0;
   ilaunbouclier=false;
   compteb=0;
   comptev=0;
   comptec=0;
  }
  
  public void compteb () {
    if (ilaunbouclier== true) { 
      compteb++;
      if (compteb >150 ) { 
        ilaunbouclier=false;
        nbbouclier=0;
        compteb=0; 
      }
    }
  }
  
  public void comptec() {
   if (ilyacoli==true) {
     comptec++;
     if (comptec>40) { 
       ilyacoli=false;
       comptec=0; 
       }
    }  
  } 
   
  public void comptev() {
    if(ilaunevie==true) {
      comptev++;
      if(comptev>150) {
        ilaunevie=false;
        comptev=0;
      }
    }
  }
}
