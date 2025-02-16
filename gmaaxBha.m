function [A1,X]=gmaaxBha(A,W1,F,R,T,AFE,H1,S1,AJ1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Bhadesia: CALCULATION OF THE OPTIMUM NUCLEUS C CONTENT AND ACTIVITY OF C IN
%     FERRITE NUCLEUS
%     
%     Estimate a value for X, the optimum carbon concentration of
%     the ferrite nucleus, in mole fraction
%     February 1991
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted to Octave by a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  X=6.3998e-7.*T-3.027e-4;
  
  if (X<=0)
    X=1e-13;
  elseif (X>0.32e-3)
    X=0.32e-3;
  end

%  Estimation complete
  
  TEST=15;
  i=0;
  while (abs(TEST)>10)
    D1=sqrt(9-6.*X.*(2.*AJ1+3)+(9+16.*AJ1).*X.*X);
    B1=((D1-3+5.*X)./(D1+3-5.*X));
    B2=((3-4.*X)./X);
    B3=(H1-S1.*T+4.*W1)./(R.*T);
    A1=log(B1.*B1.*B1.*B1.*B2.*B2.*B2)+B3;
    if (X<1e-8)
      A1FE=log(1-X);
    else
      A1FE=X;
    end
    TEST=F+R.*T.*(A1FE-AFE)-R.*T.*(A1-A);
    DA1=(3.*X./(3-4.*X)).*((4.*X-3)./(X.*X)-4./X);
    DA2=(0.5./D1).*(-12.*AJ1-18+18.*X+32.*AJ1.*X);
    DA2=4.*(((DA2+5)./(D1-3+5.*X))-((DA2-5)./(D1+3-5.*X)));
    DA1=DA1+DA2;
    DA1FE=1./(X-1);
    ERROR=TEST/(R.*T.*(DA1FE-DA1));
    if (ERROR>X) 
      ERROR=0.3.*X;
    end
    X=abs(X-ERROR);
    i=i+1;
  end

end
