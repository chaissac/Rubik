class Puzzle {
  int taille;
  Cube[] c;
  Integer[][][] rubik, tmp;
  PImage logo;
  PVector selection;
  public Puzzle(int t) {
    taille = t;
    logo = loadImage("logo.png");
    c=new Cube[6*taille*taille-12*taille+8];
    rubik = new Integer[taille][taille][taille];
    tmp = new Integer[taille][taille][taille];
    int index = 0;
    for (int i=0; i<taille; i++)
      for (int j=0; j<taille; j++)
        for (int k=0; k<taille; k++)
          if (i==0 || i==taille-1 || j==0 || j==taille-1 || k==0 || k==taille-1) {
            c[index]=new Cube(i, j, k, taille, logo);
            rubik[i][j][k]=index;
            index++;
          } else rubik[i][j][k]=-1;
  }
  void show() {
    for (Cube cube : c) cube.show();
  }
  void select(PVector sel) {
    for (int i=0; i<taille; i++)
      for (int j=0; j<taille; j++)
        for (int k=0; k<taille; k++) 
          if (rubik[i][j][k]>=0) c[rubik[i][j][k]].cube.setStroke((sel.x==i || sel.y==j || sel.z==k)?#B000B0:#000000);
  }
  void shuffle() {
    int axis, dir, i;
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
    }
  }
  void rot(PVector sel, int direction) {
    clone(rubik, tmp);
    if (sel.x>=0) 
      rotX((int)sel.x, direction);
    else if (sel.y>=0) 
      rotY((int)sel.y, direction);
    else if (sel.z>=0) 
      rotZ((int)sel.z, direction);
    clone(tmp, rubik);
  }
  void rotX(int x, int dir) {
    for (int j=0; j<taille; j++)
      for (int k=0; k<taille; k++) {
        if (rubik[x][j][k]>=0) {
          c[rubik[x][j][k]].rot(dir, 0, 0);
          if (dir==-1) 
            tmp[x][k][taille-1-j]=rubik[x][j][k];
          else tmp[x][taille-1-k][j] = rubik[x][j][k];
        }
      }
  }
  void rotY(int y, int dir) {
    for (int i=0; i<taille; i++)
      for (int k=0; k<taille; k++) {
        if (rubik[i][y][k]>=0) {
          c[rubik[i][y][k]].rot(0, dir, 0);
          if (dir==1) 
            tmp[k][y][taille-1-i]=rubik[i][y][k];
          else tmp[taille-1-k][y][i] = rubik[i][y][k];
        }
      }
  }
  void rotZ(int z, int dir) {
    for (int i=0; i<taille; i++)
      for (int j=0; j<taille; j++) {
        if (rubik[i][j][z]>=0) {
          c[rubik[i][j][z]].rot(0, 0, dir);
          if (dir==-1) 
            tmp[j][taille-1-i][z]=rubik[i][j][z];
          else tmp[taille-1-j][i][z] = rubik[i][j][z];
        }
      }
  }
  void clone(Integer[][][] a1, Integer[][][] a2) {
    for (int i=0; i<taille; i++)
      for (int j=0; j<taille; j++)
        for (int k=0; k<taille; k++) 
          a2[i][j][k]=a1[i][j][k];
  }
}