int taille = 3;
Cube[][][] c;
float u, v;
PImage logo;
PVector selection;
void setup() {
  size(600, 600, P3D);
  logo = loadImage("logo.png");
  c=new Cube[taille][taille][taille];
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++)
        c[i][j][k]=new Cube(i, j, k);
  selection = new PVector(0, -1, -1);
  select(selection);
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
void keyPressed() {
  switch(keyCode) {
  case 88 :  // 'x'
    selection.set((selection.x+1)%taille, -1, -1);
    break;
  case 67 : // 'c' 
    selection.set(-1, (selection.y+1)%taille, -1);
    break;
  case 86 : // 'v'
    selection.set(-1, -1, (selection.z+1)%taille );
    break;
  case UP :
    rot(selection, -1);
    break;
  case DOWN :
  case 32 :
    rot(selection, 1);
    break;
  case 2:
    shuffle();
    break;
  }
  select(selection);
}
void mousePressed() {
  switch (mouseButton) {
  case LEFT :
    rot(selection, 1);
    break;
  case CENTER :
    rot(selection, -1);
    break;
  }
}
void select(PVector sel) {
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++) {
        c[i][j][k].cube.setStroke((sel.x==i || sel.y==j || sel.z==k)?#B000B0:#000000);
      }
}
void shuffle() {
  int axis, dir, i;
  println("Shuffle!");
  for (int n = 0; n<50*taille; n++) {
    dir = (random(1)<.5)?-1:1;
    i = floor(random(taille));
    axis = floor(random(3));
    switch (axis) {
    case 0 : 
      rot(new PVector(i, -1, -1), dir); 
      break;
    case 1 : 
      rot(new PVector(-1, i, -1), dir); 
      break;
    case 2 : 
      rot(new PVector(-1, -1, i), dir); 
      break;
    }
    println(n+" : ("+axis+","+i+")=>"+dir+"  /  ");
  }
}
// Starting here, I'm lost...
void rot(PVector sel, int direction) {
  // HERE ARE DRAGONS
  if (sel.x>=0) 
    rotX((int)sel.x, direction);
  else if (sel.y>=0) 
    rotY((int)sel.y, direction);
  else if (sel.z>=0) 
    rotZ((int)sel.z, direction);
}
void rotX(int x, int dir) {
  Cube[][][] tmp = new Cube[taille][taille][taille];
  arrayCopy(c, tmp);
  println("Rotation X "+x+" , "+dir);
  for (int j=0; j<taille; j++)
    for (int k=0; k<taille; k++) {
      c[x][j][k].rot(dir, 0, 0);
      if (dir==1) 
        tmp[x][k][taille-1-j]=c[x][j][k];
      else tmp[x][taille-1-k][j] = c[x][j][k];
    }
  arrayCopy(tmp, c);
}
void rotY(int y, int dir) {
  Cube[][][] tmp = new Cube[taille][taille][taille];
  arrayCopy(c, tmp);
  println("Rotation Y "+y+" , "+dir);
  for (int i=0; i<taille; i++)
    for (int k=0; k<taille; k++) {
      c[i][y][k].rot(0, dir, 0);
      if (dir==1) 
        tmp[k][y][taille-1-i]=c[i][y][k];
      else tmp[taille-1-k][y][i] = c[i][y][k];
    }
  arrayCopy(tmp, c);
}
void rotZ(int z, int dir) {
  Cube[][][] tmp = new Cube[taille][taille][taille];
  arrayCopy(c, tmp);
  println("Rotation Z "+z+" , "+dir);
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++) {
      c[i][j][z].rot(0, 0, dir);
      if (dir==1) 
        tmp[j][taille-1-i][z]=c[i][j][z];
      else tmp[taille-1-j][i][z] = c[i][j][z];
    }
  arrayCopy(tmp, c);
}