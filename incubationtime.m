function [tnn,fab,csn]=incubationtime(delGmo,T,cGammablock,cGammaTo,cGamma,nr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Incubation
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function calculates the incubation time of a ferrite platelet
% ttn= type of nucleation time ttn=1 (fixed), ttn=2 (linear increment)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% maximum free energy available for para-equilibrium nucleation
  Gn=3.637.*(T-273.15)-2540; %J/mol

% function fab
  if nr==1
%    fab=0;    
    cGammablock=(cGammablock+cGamma)./2;
    fab=(cGammablock-cGamma)./(cGammaTo-cGamma);
  elseif nr==2
%    cGammablock=(cGammaTo+cGammablock)./2;
    fab=(cGammablock-cGamma)./(cGammaTo-cGamma);
  end

% real maximum free energy available for para-equilibrium nucleation
  delGm=delGmo-fab.*(delGmo-Gn); %write as a function of block carbon
				%concentration (done)  

% constant
  kb=1.3806488e-23; % [m2 kg/(s2 K)] Boltzmann constant
  h=6.62606957e-34; % [m2 kg / s] planck constant
  nu=kb.*T./h;
  k3=2540; %J/mol. see matsuda 2004.

%  k4=1.3257e15; % fitted        % paper mmta (gorny and boccardo)
%  k5=4.72e3; %J/mol. fitted  %

%  k4=8.0e15; % fitted        % paper mmta (batra)
%  k5=4.7e3; %J/mol. fitted  %

%  k4=1.15e15; % fitted        % paper mmta (yescas thesis)
%  k5=12.e3; %J/mol. fitted  %

%  k4=1.5e15; % fitted        % paper mmta (vw) (old)
%  k5=4.72e3; %J/mol. fitted  %

  k4=3.5087e14; % fitted        % paper mmta (vw)
  k5=1.9671e4; %J/mol. fitted  %
  
  R=8.31432; %J/(K mol)

% incubation time. Matsuda and Bhadeshia.
  tnn=k4./nu.*exp(k5./(R.*T).*(1+delGm./k3)); %[s]

% chance of successfully nucleation
  csn=nu.*exp(-k5./(R.*T).*(1+delGm./k3)); %[s]
  
end
  

