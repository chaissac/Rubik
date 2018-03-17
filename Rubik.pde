int taille = 3;
Cube[][][] c;
float u, v;
PImage logo;
void setup() {
  size(600, 600, P3D);
  logo = loadImage("logo.png");
  c=new Cube[taille][taille][taille];
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++)
        c[i][j][k]=new Cube(i, j, k);
}
void draw() {
  background(255);
  ambientLight(220, 220, 220);
  camera(0, 0, 150, 0, 0, 0, 0, 1, 0);
  if (mouseButton==RIGHT) {
    u -= (mouseY - height / 2.0) / height / 10;
    v += (mouseX - width  / 2.0) / width  / 10;
  }
  rotateX(u); 
  rotateY(v);  
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++)
        c[i][j][k].show();
  camera();
}