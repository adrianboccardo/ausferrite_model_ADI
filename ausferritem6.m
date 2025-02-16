function [rAusf]=ausferritem6(GMAX,T,cGammablocki,cGammaTo,cGamma,plength,deltat,rAusf,rA,vfAusflast,rGr,vfGr,imeff,vfA,vfAini)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ausferrite growth
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Adrian Boccardo
% Date: 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% incubation time
  nr=1; %nucleation region
  [tnn1]=incubationtime(GMAX,T,cGammablocki,cGammaTo,cGamma,nr);

% sheaf growth
  drAusf=(plength./tnn1).*deltat; %continuous
  rAusflast=rAusf; %radius at time i-1
  rAusf=rAusf+drAusf; % radius at time t without impediment
  if rAusf>rA
    rAusf=rA;
  end
  
% impediment effect
  vfi=vfGr+vfAusflast;
  if vfi>1 % control
    vfi=1;
  end

  if ((imeff==1)&&(vfi>=0.5)&&(vfA>0))
    [rAusf]=impedimentF_new(vfi,rAusflast,rA,drAusf);
  end
  
  end

