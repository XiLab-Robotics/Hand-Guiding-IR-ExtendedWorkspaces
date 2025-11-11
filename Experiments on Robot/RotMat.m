function R = RotMat(A,B,C)

cA=cos(A);
sA=sin(A);
cB=cos(B);
sB=sin(B);
cC=cos(C);
sC=sin(C);

R=[ cA*cB    cA*sB*sC-sA*cC    cA*sB*cC+sA*sC;
    sA*cB    sA*sB*sC+cA*cC    sA*sB*cC-cA*sC;
    -sB      cB*sC             cB*cC ];
end