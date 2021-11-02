float colorScaleRe;
float colorScaleIm;

int sizeX=1024;
int sizeY=1024;

float scale=0.5F/1024;
float shift=0.5;
float shiftAbs=shift*sizeX*scale;
float maxV=1E-30;
float maxVoffset=1;

boolean show=false;

ComplexNum r1 =new ComplexNum(1,0);
ComplexNum r2 =new ComplexNum(2,0);
ComplexNum r3 =new ComplexNum(3,0);
ComplexNum r4 =new ComplexNum(4,0);
ComplexNum r5 =new ComplexNum(5,0);
ComplexNum r6 =new ComplexNum(6,0);
ComplexNum r7 =new ComplexNum(7,0);
ComplexNum r8 =new ComplexNum(8,0);
ComplexNum r9 =new ComplexNum(9,0);
ComplexNum r10=new ComplexNum(10,0);
ComplexNum i1 =new ComplexNum(0,1);
ComplexNum i2 =new ComplexNum(0,2);
ComplexNum i3 =new ComplexNum(0,3);
ComplexNum i4 =new ComplexNum(0,4);
ComplexNum i5 =new ComplexNum(0,5);
ComplexNum i6 =new ComplexNum(0,6);
ComplexNum i7 =new ComplexNum(0,7);
ComplexNum i8 =new ComplexNum(0,8);
ComplexNum i9 =new ComplexNum(0,9);
ComplexNum i10=new ComplexNum(0,10);

void keyPressed(){
  if(key=='s'){
    save("v2/"+"f(z)=e^iz"+"/scale "+Float.toString(scale)+" maxVoffset "+Float.toString(maxVoffset)+" shift "+Float.toString(shift)+".png");
    println("saved!");
  }
  else if(key=='v'){
    show=!show;
  }
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
      ComplexNum fz=compExp(compMult(i1,z));
      
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
  if(show){
    textSize(20);
    fill(0,0,100F);
    text("scale:"+Float.toString(scale),0,20);
    text("maxVoffset:"+Float.toString(maxVoffset),0,40);
  }
}
