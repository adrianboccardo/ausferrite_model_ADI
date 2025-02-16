function [tnn]=incubation1F(ttn,tni,tnf,vfAusf,vfGr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   this function calculates the incubation time of a ferrite platelet
%   acconding to model 1 (proposed time)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ttn= type of nucleation time ttn=1 (fixed), ttn=2 (linear increment)
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a.d. boccardo
% date: 03-10-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if ttn==1     %fixed time
    tnn=tni;
  elseif ttn==2 %variable time
    tnn=tni+(tnf-tni).*(vfAusf./(1-vfGr)); %if vfAusf=0 tnn=tni and vfAus=vfAusfMax tnn=tnf
  end

end