class Cube {
  PVector pos ;
  PVector ini ;
  PShape  cube ;
  color[] colors = {#A00000, #F06000, #008000, #0000FF, #FFFF00, #FFFFFF, #000000}; 
  Cube (float x, float y, float z) {
    float size = width/(8*taille);
    pos = new PVector((x-(taille-1.0)/2)*size, (y-(taille-1.0)/2)*size, (z-(taille-1.0)/2)*size);
    stroke(0);
    strokeWeight(size/5);
    cube = createShape();
    cube.beginShape(QUADS);
    cube.texture(logo);
    float d=size*.45;
    for (int i=0; i<6; i++) {
      cube.fill(colors[((i==0 && x!=0) || (i==1 && x!=taille-1) || (i==4 && z!=0) || (i==5 && z!=taille-1) || (i==2 && y!=0) || (i==3 && y!=taille-1))?6:i], 255);
      float l=(i==5 && (x-taille/2==0) && (y-taille/2==0))?1:0; 
      cube.vertex((i==1)?d:-d, (i==3)?d:-d, (i==5)?d:-d, 0, 0);
      cube.vertex((i==1)?d:-d, (i==0 ||i==2)?-d:d, (i==1 ||i==4)?-d:d, 0, l*logo.height);
      cube.vertex((i==0)?-d:d, (i==2)?-d:d, (i==4)?-d:d, l*logo.width, l*logo.height);
      cube.vertex((i==0)?-d:d, (i==0 ||i==3)?d:-d, (i==1 ||i==5)?d:-d, l*logo.width, 0);
    }
    cube.endShape();
  }
  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z); 
    shape(cube);
    popMatrix();
  }
  void rot(int rotX, int rotY, int rotZ) {
    cube.translate(pos.x, pos.y, pos.z);
    cube.rotateX(rotX*HALF_PI);
    cube.rotateY(rotY*HALF_PI);
    cube.rotateZ(rotZ*HALF_PI);
    cube.translate(-pos.x, -pos.y, -pos.z);
  }
}