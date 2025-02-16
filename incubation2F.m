function [tnn]=incubation2F(temp,k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   this function calculates the incubation time of a ferrite platelet
%   acconding to model 2 (proposed time)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ttn= type of nucleation time ttn=1 (fixed), ttn=2 (linear increment)
%
%
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

