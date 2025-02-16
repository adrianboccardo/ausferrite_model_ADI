function [rAusf]=impedimentF_new(vfi,rAusflast,rA,drAusf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   this function calculates the ausferrite volume fraction and its
%   radius, taking into account the impediment effect
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a.d. boccardo
% date: 03-10-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%solve without iterative method
  drAusfic=drAusf.*((1-vfi)./(1-0.5)).^(2./3);
  
  rAusf=rAusflast+drAusfic;
  
  if rAusf>rA
    rAusf=rA;
  end
  
end
  