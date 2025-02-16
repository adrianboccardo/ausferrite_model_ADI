function [tnn]=incubation2F(temp,k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Incubation 2
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
% according to model 2 (proposed time)
% ttn= type of nucleation time ttn=1 (fixed), ttn=2 (linear increment)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% maximum free energy available for para-equilibrium nucleation
  T=temp+273; %temperature in kelvin
  [GMAX]=gmaxBha(k,T);
  Gn=3.637.*(T-273.15)-2540; %J/mol

% incubation time. Matsuda and Bhadeshia.
  kb=1.3806488e-23; % [m2 kg/(s2 K)] Boltzmann constant
  h=6.62606957e-34; % [m2 kg / s] planck constant
  nu=kb.*T./h;
  k3=2540; %J/mol. see matsuda 2004.
  k4=2.25e13; % proposed.
  k5=6.233e4; %J/mol. see matsuda 2004.
  R=8.31432; %J/(K mol)
  tnn=k4./nu.*exp(k5./(R.*T).*(1+GMAX./k3)); %[s]

end

