
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
    ComplexNum c1 = fromMA(pow(r,a),log(r)*b);
    ComplexNum c2 = fromMA(exp(-b*t),a*t);
    
    return(simpleMult(c1,c2));
  }
  
ComplexNum compDiv(ComplexNum p, ComplexNum q){
  ComplexNum numerator= simpleMult(p,new ComplexNum(q.a,-q.b));
  float denominator = q.getModulus();
  denominator=denominator*denominator;
  return(new ComplexNum(numerator.a/denominator, numerator.b/denominator));
}

//e^x
ComplexNum compExp(ComplexNum x){
  ComplexNum partA = new ComplexNum(exp(x.a),0);
  ComplexNum partB = fromMA(1,x.b);
  return(compMult(partA,partB));
}

ComplexNum compSin(ComplexNum theta){
  ComplexNum minusOne = new ComplexNum(-1,0);
  ComplexNum iTheta = compMult(new ComplexNum(0,1),theta);
  ComplexNum eToITheta = compExp(iTheta);
  ComplexNum eToMITheta = compExp(compMult(minusOne,iTheta));
  ComplexNum numer = compAdd(eToITheta,compMult(minusOne,eToMITheta));
  ComplexNum i2 = new ComplexNum(0,2);
  return(compDiv(numer,i2));
}

ComplexNum compCos(ComplexNum theta){
  ComplexNum minusOne = new ComplexNum(-1,0);
  ComplexNum iTheta = compMult(new ComplexNum(0,1),theta);
  ComplexNum eToITheta = compExp(iTheta);
  ComplexNum eToMITheta = compExp(compMult(minusOne,iTheta));
  ComplexNum numer = compAdd(eToITheta,eToMITheta);
  ComplexNum r2 = new ComplexNum(2,0);
  return(compDiv(numer,r2));
}

ComplexNum compTan(ComplexNum theta){
  //(i(e^i2t-1)/(e^i2t+1)
  ComplexNum eTo2iTheta = compExp(compMult(new ComplexNum(0,2),theta));
  ComplexNum numer = compMult(new ComplexNum(0,1),compAdd(eTo2iTheta,new ComplexNum(-1,0)));
  ComplexNum denom = compAdd(eTo2iTheta,new ComplexNum(1,0));
  return(compDiv(numer,denom));
}

ComplexNum compSinh(ComplexNum x){
  ComplexNum eX = compExp(x);
  ComplexNum eMX = compExp(compMult(new ComplexNum(-1,0),x));
  ComplexNum numer = compAdd(eX,compMult(new ComplexNum(-1,0),eMX));
  ComplexNum r2 = new ComplexNum(2,0);
  return(compDiv(numer,r2));
}

ComplexNum compCosh(ComplexNum x){
  ComplexNum eX = compExp(x);
  ComplexNum eMX = compExp(compMult(new ComplexNum(-1,0),x));
  ComplexNum numer = compAdd(eX,eMX);
  ComplexNum r2 = new ComplexNum(2,0);
  return(compDiv(numer,r2));
}

ComplexNum compTanh(ComplexNum x){
  ComplexNum e2x = compExp(compMult(new ComplexNum(2,0),x));
  ComplexNum numer = compAdd(e2x,new ComplexNum(-1,0));
  ComplexNum denom = compAdd(e2x,new ComplexNum(1,0));
  return(compDiv(numer,denom));
}

ComplexNum compLn(ComplexNum x){
  return(compAdd(new ComplexNum(log(x.getModulus()),0),new ComplexNum(0,x.getArgument())));
}

ComplexNum compArsinh(ComplexNum x){
  ComplexNum x2plus1= compAdd(compMult(x,x),new ComplexNum(1,0));
  return(compLn(compAdd(x,compPow(x2plus1,new ComplexNum(0.5,0)))));
}

ComplexNum compArcosh(ComplexNum x){
  ComplexNum x2plus1= compAdd(compMult(x,x),new ComplexNum(-1,0));
  return(compLn(compAdd(x,compPow(x2plus1,new ComplexNum(0.5,0)))));
}

ComplexNum compArtanh(ComplexNum x){
  ComplexNum a= compLn(compAdd(x,new ComplexNum(1,0)));
  ComplexNum b = compMult(new ComplexNum(-1,0),compLn(compAdd(compMult(new ComplexNum(-1,0),x),new ComplexNum(1,0))));
  return(compMult(new ComplexNum(0.5,0),compAdd(a,b)));
}
