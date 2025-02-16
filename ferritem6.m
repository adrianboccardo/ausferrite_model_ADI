function [xi,vfFpaut,vfFpgb,vfFpi,vfAfi,vfAbi,cGammablocki]=ferritem6(vfFpi,xfpab,cGamma,cAlphap,cGammaTo,GMAX,T,xi,Bk,vol,up,deltat,vfFpaut,Ak,vfFpgb,vfFpgbmax,vfFpmax,rGr,rA,rAusf,denA,denF,denATo,denAb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ferrite growth
% Copyright (C) 2015 Adrian Boccardo (adrianboccardo@gmail.com)
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Adrian Boccardo
% Date: 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% austenite block carbon concentration
  vfAusfi=(rAusf.^3-rGr.^3)./rA.^3;
  vfFpgo=vfFpi./vfAusfi;
  vfAfgo=vfFpgo.*xfpab;
  vfAbgo=1-(vfFpgo+vfAfgo);
  cGammablocki=(cGamma.*denA-(vfFpgo.*cAlphap.*denF+vfAfgo.*cGammaTo.*denATo))./(vfAbgo.*denAb);
  if (cGammablocki>cGammaTo)
    cGammablocki=cGammaTo;
  elseif (cGammablocki<cGamma)
    cGammablocki=cGamma;
  end

% incubation time and nucleation rate
  nr=2; %nucleation region
  [tnn2]=incubationtime(GMAX,T,cGammablocki,cGammaTo,cGamma,nr);
  I=1./tnn2;

% ferrite platelet (autocatalitic)
  Npsaut=(1-xi).*Bk.*(vol.*vfFpi./up);
  delvfFpaut=up.*I.*Npsaut.*deltat./vol;
  vfFpaut=vfFpaut+delvfFpaut;

% ferrite platelet (graphite-austenite)
  Npsgb=(1-xi).*Ak.*(1-vfFpgb./vfFpgbmax);
  delvfFpgb=up.*I.*Npsgb.*deltat./vol;
  vfFpgb=vfFpgb+delvfFpgb;
  if (vfFpgb>vfFpgbmax)
    vfFpgb=vfFpgbmax;
  end

% ferrite platelet volume fraction
  vfFpi=vfFpgb+vfFpaut;
  vfFpadm=vfFpmax.*vfAusfi;
  if (vfFpi>vfFpadm)
    vfFpi=vfFpadm;
  end

% xi. It is put here to avoid some problems when Ak and Bk are higher.
  xi=vfFpi./(vfAusfi.*vfFpmax);
  if xi>1
    xi=1;
  end

% film austenite volume fractions
  vfAfi=vfFpi.*xfpab;

% block austenite volume fraction
  vfAbi=vfAusfi-vfFpi.*(1+xfpab);
  
end
  
