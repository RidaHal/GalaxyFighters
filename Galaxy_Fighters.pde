//les données des contrôles du vaisseau
Jeu vaisseau = new Jeu();

Asteroide [] asteroides = new Asteroide[60];
//astéroïdes

Vie [] vies = new Vie[2];
//vies

Bouclier [] boucliers = new Bouclier[2];
//bouclier


public void setup() {
  //charge le jeu  
  size(1280, 720, P2D);
  //forme l'écran
  vaisseau.chargeoutils();
  //charge toutes les images utilisées
  for(int i=0;i<asteroides.length;i++){
    asteroides[i]=new Asteroide();    
  } 
   //crée les astéroïdes
   for(int i=0;i<vies.length;i++){
     vies[i] = new Vie(); 
   }
  //crée les vies
  for(int i = 0;i<boucliers.length;i++) {
    boucliers[i] = new Bouclier();
  }
  //crée les boucliers
}
   
public void draw(){
  //affiche le jeu
  vaisseau.compteb();
  vaisseau.comptev();
  vaisseau.comptec();
  if(vaisseau.level==1) {
    background(vaisseau.galax1);
    vaisseau.scoremini=1000; 
  }   
 //gère le niveau 1
   
  else if(vaisseau.level==2) {
    background(vaisseau.galax2);
    for(int i = 0; i<asteroides.length; i++) {
      asteroides[i].xspeed=random(1.005,3.0051);
      asteroides[i].yspeed=random(-1.5,1.5);
    }
    vaisseau.scoremini=1300;
  }
   
  else {
    background(vaisseau.galax3);
    for(int i = 0; i<asteroides.length; i++) {
      asteroides[i].xspeed=random(1.01,3.0101);
      asteroides[i].yspeed=random(-1.5005,1.5005);
    }
    vaisseau.scoremini=1600;
  } 
    
  if(vaisseau.etat==0) {
    background(vaisseau.galax1);
    stroke(255);
    fill(12,127,127,127);
    rect(30,250,300,400);
    image(vaisseau.gft,270,50);
    fill(255);
    textFont(vaisseau.font1);
    text("Appuyez sur Entrée pour jouer\n\n\nEspace pour entrer dans les options\n\n\nx pour quitter",38,300,300,400);
    //Commandes du menu   
    if(key==ENTER) {
      vaisseau.etat=5;
    }
 
    if(key == 'x'||key == 'X') {
      exit();
    }
    if(key==' '){
      vaisseau.etat=1;  
    }
  }

  //Commandes 

  if(vaisseau.etat==1) {
    background(vaisseau.galax1);
    image(vaisseau.gft,270,50);
    stroke(255);
    fill(12,127,127,127);
    rect(130,170,1010,500);
    fill(255);
    textSize(20);
    text("Commandes: flèches directionnelles pour se déplacer.\n\nRègles:\n- Vous devez traverser un champ d'astéroïdes avec votre vaisseau.\n- Vous avez 3 vies au départ.\n- Sortir de l'écran vous fera perdre.\n- Percuter des astéroïdes vous fera perdre des vies, si vous en avez plus c'est perdu.\n- Arriver à un score précis, une piste d'aterrissage apparaîtra en bas à droite, déposer le vaisseau dessus pour gagner\n- Différences entre les niveaux: - vitesse des astéroïdes\n                                                        - score à atteindre pour débloquer la piste \n\nBonus: ",145,190,1000,500);
    tint(0,255,0);
    image(vaisseau.shieldo,145,585);
    noTint();
    tint(255,0,0);
    image(vaisseau.coeur,145,525);
    noTint();
    text("Vous permet de gagner une vie\n\nVous permet d'être invincible pendant un court instant",185,550);
    textSize(15);
    text("Pressez la touche o pour revenir à l'écran titre\nPressez la touche x pour quitter le jeu",139,645);

    if(key=='o'||key=='O'){
      vaisseau.etat=0;
    }
   
    if(key=='x'||key=='X') {
      exit();
    }
  } 
  if(vaisseau.etat==2) {  
    for(int i=0;i<asteroides.length;i++){
      asteroides[i].show();
      asteroides[i].move();
    }
   
  for(int i=0;i<vies.length;i++){
    vies[i].show();
    vies[i].move();
  }

  for(int i=0;i<boucliers.length;i++){
     boucliers[i].show();
     boucliers[i].move();
  }
    
  tint(250,0,0);// Début du changement de couleur des images sélectionnées ci-dessous
  vaisseau.Controles();
  vaisseau.Acceleration();
  vaisseau.Position();
  noTint();      
  for(int i = 0; i<vaisseau.nbbouclier; i++) {
    image(vaisseau.shield,30*i,40);
  }
   
  textFont(vaisseau.font1);
  fill(255,0,0);  
  text("Score : " + vaisseau.scorecourant + " " + "|Meilleur score : " + vaisseau.scoremeilleur,900,25);
  text("Niveau : " + vaisseau.level,500,25);
  fill(255);
   
  if(vaisseau.nbvies!=0) {
    vaisseau.scorecourant++;
    if(vaisseau.xpos==30&&vaisseau.ypos==height/2){
      vaisseau.scorecourant = -1;
      if(vaisseau.xpos!=30||vaisseau.ypos==height/2){
        vaisseau.scorecourant++;        
      }
    }
    if(vaisseau.scorecourant>=vaisseau.scoremini) {// apparition de la piste 
      stroke(255,255,0);
      fill(255,255,0);
      rect(vaisseau.xpos1, vaisseau.ypos1,180,20);
      if(vaisseau.xpos1>=1100) vaisseau.xpos1=vaisseau.xpos1-vaisseau.accx1;
      else {
        vaisseau.xpos1=1100;
        vaisseau.accx1=0;
      }
      if(vaisseau.piste==true){
        vaisseau.scorecourant+=500;
        vaisseau.etat=4;
      } 
    }
  }   
   
  image(vaisseau.vaisseau, vaisseau.xpos, vaisseau.ypos);
  vaisseau.Gameover();
    if(vaisseau.vie==true && vaisseau.nbvies<4) {
      vaisseau.nbvies+=1;
      vaisseau.scorecourant+=50;
      vaisseau.vie=false;
    }
    if(vaisseau.bouclier==true && vaisseau.nbbouclier==0){
      vaisseau.nbbouclier++;
      vaisseau.scorecourant+=50;
      vaisseau.bouclier=false;
    }
    else if(vaisseau.bouclier==true && vaisseau.nbbouclier==1) {
      vaisseau.bouclier=false;
    }
    if (vaisseau.condition==true){
       --vaisseau.nbvies;
       if(vaisseau.scorecourant<=50) {
         vaisseau.scorecourant=0;
       }
    else {
      vaisseau.scorecourant-=50;
    }
    if(vaisseau.nbbouclier!=0) {
      vaisseau.nbbouclier=0;
      if(vaisseau.scorecourant<=50) {
        vaisseau.scorecourant=0;
      }
      else {
        vaisseau.scorecourant-=50;
      }  
    }
    vaisseau.condition=false;
  }

  if(vaisseau.nbvies!=0){
    tint(255,0,0);// Début du changement de couleur des images sélectionnées ci-dessous 
    for(int i = 0; i<vaisseau.nbvies; i++) {
      image(vaisseau.heart,30*i,5);
    }
      noTint(); // Fin du changement de couleur
      image(vaisseau.vaisseau,vaisseau.xpos,vaisseau.ypos);
  }
   
    else if(vaisseau.nbvies==0){   
      image(vaisseau.vaisseau,vaisseau.xpos,vaisseau.ypos);
      noTint();
      vaisseau.etat=3;
    }
  }

  if (vaisseau.etat==3){
    vaisseau.Gameover();
    setup();
  }
   
  if(vaisseau.etat==4) {
    vaisseau.victoire();
  }
   
  if(vaisseau.etat==5) {
    background(vaisseau.galax1);
    image(vaisseau.gft,270,50);
    stroke(255);
    fill(12,127,127,127);
    rect(30,250,400,350);
    image(vaisseau.gft,270,50);
    fill(255);
    textFont(vaisseau.font1);
    text("Choix du niveau:\n\n\nAppuyez sur 1 pour jouer au niveau 1\n\nAppuyez sur 2 pour jouer au niveau 2\n\nAppuyez sur 3 pour jouer au niveau 3",38,300,400,400);
    textSize(15);
    text("Appuyez sur o pour revenir au menu principal",40,590);

    if(key=='&'||key=='1') {
      vaisseau.etat=2; 
      vaisseau.level=1;
    }
    
    else if (key=='é'||key=='2') {
      vaisseau.etat=2; 
      vaisseau.level=2;
    }
    
    else if(key=='"'||key=='3') {
      vaisseau.etat=2;
      vaisseau.level=3;
    }
    
    if(key=='o'||key=='O') {
      vaisseau.etat = 0;//renvoie au menu principal
    }
    
    if(key=='x'||key=='X') {
      exit();//quitte le jeu
    }
  }
}

public void keyPressed() {
//Cette fonction permettra d'assigner certaines touches à certaines fonctionnalités
  if(vaisseau.etat==2){
    if(keyCode==ALT){ 
      vaisseau.Pause();     
    }
    else if (looping) {
      if (keyCode == UP) vaisseau.accy-=6;
      else if (keyCode == DOWN) vaisseau.accy+=6;
      else if (keyCode == LEFT) vaisseau.accx-=6;
      else if (keyCode == RIGHT) vaisseau.accx+=6; 
    }
  }
}
