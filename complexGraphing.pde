float colorScaleRe;
float colorScaleIm;

int sizeX=1024;
int sizeY=1024;

float scale=0.5F/1024;
float shift=0.5;
float shiftAbs=shift*sizeX*scale;
float maxV=1E-30;
float maxVoffset=1;

ComplexNum n1 =new ComplexNum(1,0);
ComplexNum n2 =new ComplexNum(2,0);
ComplexNum n3 =new ComplexNum(3,0);
ComplexNum n4 =new ComplexNum(4,0);
ComplexNum n5 =new ComplexNum(5,0);
ComplexNum n6 =new ComplexNum(6,0);
ComplexNum n7 =new ComplexNum(7,0);
ComplexNum n8 =new ComplexNum(8,0);
ComplexNum n9 =new ComplexNum(9,0);
ComplexNum n10=new ComplexNum(10,0);

void keyPressed(){
  save("v2/"+"f(z)=z(z+i)"+"/scale "+Float.toString(scale)+" maxVoffset "+Float.toString(maxVoffset)+" shift "+Float.toString(shift)+".png");
  println("saved!");
}

void setup(){
  size(1024,1024);
  background(0,0,0);
  
}

void mouseWheel(MouseEvent event){
  float e=event.getCount();
  scale+=0.1F/1024 * e;
  shiftAbs=shift*sizeX*scale;
  maxV=1E-30;
}

void mousePressed(){
  if(mouseButton==LEFT){
    maxVoffset*=1.1;
  }
  else{
    maxVoffset/=1.1;
  }
}

void draw(){
  clear();
  
  noStroke();

  colorMode(HSB,360,100,100);
  for(int a=0;a<width;a+=1){
    for(int b=0;b<height;b+=1){
      
      //z = a + bi
      //draw z at a,height-b
      ComplexNum z=new ComplexNum(a*scale-shiftAbs,b*scale-shiftAbs);
      ComplexNum fz=compMult(z,compAdd(z,new ComplexNum(0,1)));
      
      float fzMod=fz.getModulus();
      if(fzMod>maxV){maxV=fzMod;}
      //color stuff
      float h= fz.getArgument()*180/(PI);
      float br =fzMod/(maxV*maxVoffset) * 100;
      if(h<0){h+=360;}
      fill(h,100,br);
      rect(a,height-b,1,1);
    }
  }
  textSize(20);
  fill(0,0,100F);
  text("scale:"+Float.toString(scale),0,20);
  text("maxVoffset:"+Float.toString(maxVoffset),0,40);
}
