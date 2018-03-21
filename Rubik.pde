float u, v; //<>//
PVector selection;
Puzzle rubiksCube;
void setup() {
  size(600, 600, P3D);
  rubiksCube = new Puzzle(3);           //  Change Rubik's Cube size here 
  selection = new PVector(0, -1, -1);
  rubiksCube.select(selection);
}
void draw() {
  background(255);
  ambientLight(220, 220, 220);
  camera(0, 0, 150, 0, 0, 0, 0, 1, 0);
  if (mouseButton==LEFT && mousePressed) {
    u -= (mouseY - height / 2.0) / height / 10;
    v += (mouseX - width  / 2.0) / width  / 10;
  }
  rotateX(u); 
  rotateY(v);  
  rubiksCube.show();
  camera();
}
void keyPressed() {
  switch(keyCode) {
  case 88 :  // 'x'
    selection.set((selection.x+1)%rubiksCube.taille, -1, -1);
    break;
  case 67 : // 'c' 
    selection.set(-1, (selection.y+1)%rubiksCube.taille, -1);
    break;
  case 86 : // 'v'
    selection.set(-1, -1, (selection.z+1)%rubiksCube.taille );
    break;
  case UP :
    rubiksCube.rot(selection, -1);
    break;
  case DOWN :
    rubiksCube.rot(selection, 1);
    break;
  case 2:
    rubiksCube.shuffle();
    break;
  }
  rubiksCube.select(selection);
}
void mouseWheel(MouseEvent event) {
  rubiksCube.rot(selection, -(int)event.getCount());
}