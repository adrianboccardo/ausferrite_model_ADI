function [c,T10,T20,XBAR,W]=omegaBha(k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Bhadesia: SUBROUTINE MAP_STEEL_OMEGA(C,W,XBAR,T10,T20,J)
%     SUBROUTINE TO CALCULATE THE CARBON CARBON INTERACTION ENERGY IN
%     AUSTENITE, AS A FUNCTION OF ALLOY COMPOSITION.  BASED ON .MUCG18
%     THE ANSWER IS IN JOULES PER MOL.   **7 OCTOBER 1981**
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted to Octave by a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% chemical composition [molar fraction]
  c=zeros(1,8);
  c(1)=k(1)./12.0115;
  c(2)=k(2)./28.09;
  c(3)=k(3)./54.94;
  c(4)=k(4)./58.71;
  c(5)=k(5)./95.94;
  c(6)=k(6)./52.0;
  c(7)=k(7)./50.94;
  c(8)=k(8)./55.84;
  B1=c(1)+c(2)+c(3)+c(4)+c(5)+c(6)+c(7)+c(8);
  for IU=2:1:7
    Y(IU)=c(IU)./c(8);
  end
  for IU=1:1:8
    c(IU)=c(IU)./B1; %molar fraction 
  end
      
% mean carbon concentration
  XBAR=c(1);
  XBAR=floor(10000*XBAR);
  XBAR=XBAR./10000;
  T10=Y(2).*(-3)+Y(3).*2+Y(4).*12+Y(5).*(-9)+Y(6).*(-1)+Y(7).*(-12);
  T20=-3.*Y(2)-37.5.*Y(3)-6.*Y(4)-26.*Y(5)-19.*Y(6)-44.*Y(7);

%     Polynomials representing carbon-carbon interaction energy (J/mol)
%     in austenite as a function of the molecular fraction of individual
%     solutes.
  P=zeros(1,7);
  P(2)=-2.4233e7+6.9547e7.*c(2);
  P(2)=3.864e6+P(2).*c(2);
  P(2)=45802.87+(-280061.63+P(2).*c(2)).*c(2); 
  P(2)=2013.0341+(763.8167+P(2).*c(2)).*c(2);
  P(3)=2.0119e6+(3.1716e7-1.3885e8.*c(3)).*c(3);
  P(3)=6287.52+(-21647.96+P(3).*c(3)).*c(3);
  P(3)=2012.067+(-1764.095+P(3).*c(3)).*c(3);
  P(4)=-2.4968e7+(1.8838e8-5.5531e8.*c(4)).*c(4);
  P(4)=-54915.32+(1.6216e6+P(4).*c(4)).*c(4);
  P(4)=2006.8017+(2330.2424+P(4).*c(4)).*c(4);
  P(5)=-1.3306e7+(8.411e7-2.0826e8.*c(5)).*c(5);
  P(5)=-37906.61+(1.0328e6+P(5).*c(5)).*c(5);
  P(5)=2006.834+(-2997.314+P(5).*c(5)).*c(5);
  P(6)=8.5676e6+(-6.7482e7+2.0837e8.*c(6)).*c(6);
  P(6)=33657.8+(-566827.83+P(6).*c(6)).*c(6);
  P(6)=2012.367+(-9224.2655+P(6).*c(6)).*c(6);
  P(7)=5411.7566+(250118.1085-4.1676e6.*c(7)).*c(7);
  P(7)=2011.9996+(-6247.9118+P(7).*c(7)).*c(7);
  
  B2=0;
  B3=0;
  for IU=2:1:7
    B2=B2+Y(IU);
    B3=B3+P(IU).*Y(IU);
  end
  if (B2==0)
    W=8054;
  else
    W=(B3./B2).*4.187;
  end
  
end