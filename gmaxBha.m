function [GMAX]=gmaxBha(k,T)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Bhadeshia: maximum free energy available for para-equilibrium nucleation
%   according to bhadeshia model
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k= chemical composition [w%]
% c= chemical composition [mole fraction]
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted to Octave by a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  [c,T10,T20,XBAR,W]=omegaBha(k);
  FTO=-1;
  X1=c(1);
  XA=0.001;
  R=8.31432;
  W1=48570;
  H=38575;
  S=13.48;
  XEQ=0.2;
  XTO=0.07;
  XTO400=0.06;
  CTEMP=T-273; %temperature [ºC]
  if (T<=1000)
    H1=111918;
    S1=51.44;
  else
    H1=105525;
    S1=45.34521;
  end
  [F]=energyBha(T,T10,T20);
  AJ=1-exp(-W/(R.*T));
  AJ1=1-exp(-W1/(R.*T));
  [A]=cgBha(X1,AJ,W,R,T);
  [AFE]=afegBha(X1,AJ);
  [A1,X]=gmaaxBha(A,W1,F,R,T,AFE,H1,S1,AJ1);
  GMAX=R.*T.*(A1-A);

end