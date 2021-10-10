
  ComplexNum fromMA(float r,float theta){
    return(new ComplexNum(r*cos(theta),r*sin(theta)));
  }
  ComplexNum simpleMult(ComplexNum q, ComplexNum p){
    float a= q.a * p.a-q.b*p.b;
    float b=q.b*p.a+q.a*p.b;
    return(new ComplexNum(a,b));
  }
  ComplexNum compMult(ComplexNum... args){
    ComplexNum out=new ComplexNum(1,0);
    for(ComplexNum item : args){
      out=simpleMult(out,item);
    }
    return(out);
  }
  
  ComplexNum simpleAdd(ComplexNum q, ComplexNum p){
    float a= q.a +p.a;
    float b= q.b +p.b;
    return(new ComplexNum(a,b));
  }
  
  ComplexNum compAdd(ComplexNum... args){
    ComplexNum out=new ComplexNum(0,0);
    for(ComplexNum item : args){
      out=simpleAdd(out,item);
    }
    return(out);
  }
  
  ComplexNum compPow(ComplexNum base, ComplexNum power){
    //r*e^(it)= r^a * e^(ln(r)*b*i) * e^(i*a*t) * e^(-b*t)
    float r=base.getModulus();
    float t=base.getArgument();
    float a=power.a;
    float b=power.b;
    ComplexNum c1 = this.fromMA(pow(r,a),log(r)*b);
    ComplexNum c2 = this.fromMA(exp(-b*t),a*t);
    
    return(simpleMult(c1,c2));
  }
  
ComplexNum compDiv(ComplexNum p, ComplexNum q){
  ComplexNum numerator= simpleMult(p,new ComplexNum(q.a,-q.b));
  float denominator = q.getModulus();
  denominator=denominator*denominator;
  return(new ComplexNum(numerator.a/denominator, numerator.b/denominator));
}
