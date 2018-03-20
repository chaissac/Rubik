int taille = 3; //<>//
Cube[] c;
Integer[][][] rubik;
float u, v;
PImage logo;
PVector selection;
void setup() {
  size(600, 600, P3D);
  logo = loadImage("logo.png");
  c=new Cube[6*taille*taille-12*taille+8];
  rubik = new Integer[taille][taille][taille];
  int index = 0;
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++)
        if (i==0 || i==taille-1 || j==0 || j==taille-1 || k==0 || k==taille-1) {
          c[index]=new Cube(i, j, k);
          rubik[i][j][k]=index;
          index++;
        } else rubik[i][j][k]=-1;
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
  for (Cube cube : c) cube.show();
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
        if (rubik[i][j][k]>=0) c[rubik[i][j][k]].cube.setStroke((sel.x==i || sel.y==j || sel.z==k)?#B000B0:#000000);
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
  Integer[][][] tmp = new Integer[taille][taille][taille];
  clone(rubik, tmp);
  println("Rotation X #"+x+" , "+dir);
  for (int j=0; j<taille; j++)
    for (int k=0; k<taille; k++) {
      if (rubik[x][j][k]>=0) {
        c[rubik[x][j][k]].rot(dir, 0, 0);
        if (dir==1) 
          tmp[x][k][taille-1-j]=rubik[x][j][k];
        else tmp[x][taille-1-k][j] = rubik[x][j][k];
      }
    }
  clone(tmp, rubik);
}
void rotY(int y, int dir) {
  Integer[][][] tmp = new Integer[taille][taille][taille];
  clone(rubik, tmp);
  println("Rotation Y #"+y+" , "+dir);
  for (int i=0; i<taille; i++)
    for (int k=0; k<taille; k++) {
      if (rubik[i][y][k]>=0) {
        c[rubik[i][y][k]].rot(0, dir, 0);
        if (dir==1) 
          tmp[k][y][taille-1-i]=rubik[i][y][k];
        else tmp[taille-1-k][y][i] = rubik[i][y][k];
      }
    }
  clone(tmp, rubik);
}
void rotZ(int z, int dir) {
  Integer[][][] tmp = new Integer[taille][taille][taille];
  clone(rubik, tmp);
  println("Rotation Z #"+z+" , "+dir);
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++) {
      if (rubik[i][j][z]>=0) {
        c[rubik[i][j][z]].rot(0, 0, dir);
        if (dir==1) 
          tmp[j][taille-1-i][z]=rubik[i][j][z];
        else tmp[taille-1-j][i][z] = rubik[i][j][z];
      }
    }
  clone(tmp, rubik);
}
void clone(Integer[][][] a1, Integer[][][] a2) {
  for (int i=0; i<taille; i++)
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++) 
        a2[i][j][k]=a1[i][j][k];
}