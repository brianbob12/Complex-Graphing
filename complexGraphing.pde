float colorScaleRe;
float colorScaleIm;

int sizeX=1024;
int sizeY=1024;

int version=3;

float scale=0.5F/1024;
float shift=0.5;
float shiftAbs=shift*sizeX*scale;
float maxV=1E-30;
float maxVoffset=1;

boolean show=false;
boolean log=false;

float[][][] pix;

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
    String equation = "f(z)=tan(sin(z))";
    String path="v"+Integer.toString(version)+"/"+equation+"/scale "+Float.toString(scale)+" maxVoffset "+Float.toString(maxVoffset)+" shift "+Float.toString(shift);
    if(log){
      path+="l";
    }
    save(path+".png");
    println("saved!");
  }
  else if(key=='v'){
    show=!show;
  }
  else if(key=='l'){
    log=!log;
    maxV=1E-30;
    render();
    render();
  }
  else if(key=='+'){
    maxVoffset*=1.1;
    render();
  }
  else if(key=='-'){
    maxVoffset/=1.1;
    render();
  }
}

void setup(){
  size(1024,1024);
  background(0,0,0);
  //ComplexNum n = new ComplexNum(8,0);
  //println(compArtanh(n).b);
  
  pix= new float[sizeX][sizeY][3];
  render();
  render();
}

void mouseWheel(MouseEvent event){
  float e=event.getCount();
  scale+=0.1F/1024 * e;
  shiftAbs=shift*sizeX*scale;
  maxV=1E-30;
  render();
  render();
}

void mousePressed(){
 
}

ComplexNum f(ComplexNum z){
  ComplexNum out=compTan(compSin(z));
  return(out);
}

void render(){
  println("redering");
  for(int a=0;a<width;a+=1){
    for(int b=0;b<height;b+=1){
      
      //z = a + bi
      //draw z at a,height-b
      ComplexNum z=new ComplexNum(a*scale-shiftAbs,b*scale-shiftAbs);
      ComplexNum fz=f(z);
      
      float fzMod=fz.getModulus();
      if(log){
        if(log(fzMod)>maxV){maxV=log(fzMod);}
      }
      else{
        if(fzMod>maxV){maxV=fzMod;}
      }
      //color stuff
      float h= fz.getArgument()*180/(PI);
      float br;
      if(log){
        br=log(fzMod)/(maxV*maxVoffset) * 100;
      }
      else{
        br =fzMod/(maxV*maxVoffset) * 100;
      }
      if(h<0){h+=360;}
      pix[a][b][0]=h;
      pix[a][b][1]=100;
      pix[a][b][2]=br;
    }
  }
}

void draw(){
  clear();
  
  noStroke();

  colorMode(HSB,360,100,100);
  for(int a=0;a<width;a+=1){
    for(int b=0;b<height;b+=1){
      
      fill(pix[a][b][0],pix[a][b][1],pix[a][b][2]);
      rect(a,height-b,1,1);
    }
  }
  if(show){
    textSize(20);
    fill(0,0,100F);
    text("scale:"+Float.toString(scale),0,20);
    text("maxVoffset:"+Float.toString(maxVoffset),0,40);
    ComplexNum hoverNum=new ComplexNum(mouseX*scale-shiftAbs,(height-mouseY)*scale-shiftAbs);
    ComplexNum hoverVal=f(hoverNum);
    text("z    : "+hoverNum.a+" + "+hoverNum.b+"i",0,60);
    text("z    : "+hoverNum.getModulus()+" ∠ "+hoverNum.getArgument()/PI+"π",0,80);
    text("f(z) : "+hoverVal.a+" + "+hoverVal.b+"i",0,100);
    text("f(z) : "+hoverVal.getModulus()+" ∠ "+hoverVal.getArgument()/PI+"π",0,120);
    if(log){
      text("log",0,140);
    }
  }
}
