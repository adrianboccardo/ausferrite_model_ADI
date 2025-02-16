function [rAusf]=ausferritem6(GMAX,T,cGammablocki,cGammaTo,cGamma,plength,deltat,rAusf,rA,vfAusflast,rGr,vfGr,imeff,vfA,vfAini)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ausferrite growth
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

