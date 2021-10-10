class ComplexNum{
  float a;
  float b;
  ComplexNum(float a,float b){
    this.a=a;
    this.b=b;
  }
  
  float getModulus(){
    return(sqrt(this.a*this.a+this.b*this.b));
  }
  float getArgument(){
    if(this.a==0){
      if(this.b>0){
        return(HALF_PI);
      }
      else if(this.b<0){
        return(-HALF_PI);
      }
      else if(this.b==0){
        return(0);
      }
    }
    float raw=atan(this.b/a);
    if(this.a<0&&this.b>=0){
      return(raw+PI);
    }
    else if(this.a<0&&this.b<0){
      return(raw-PI);
    }
    return(raw);
  }
}
