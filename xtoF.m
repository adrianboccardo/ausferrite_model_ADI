function [xTo]=xtoF(T,si,mn,ni,cu,mo,cr,v,w,co,al,nb,ti,xcaeq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to evaluate the carbon concentration equilibrium
% of austenite whit graphite (nodular cast iron)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ta= austenization temperature [ºC]
% si= silicon [w%]
% mn= manganese [w%]
% ni= nickel [w%]
% cu= copper [w%]
% mo= moblidenum [w%] 
% cr= chromium [w%]
% v= vanadium [w%]
% w= wolframium [w%]
% co= cobalt [w%]
% al= aluminium [w%]
% nb= novio [w%]
% ti= titanium [w%]
% xcaeq= carbon concentration equilibrium austenite equation
% xca= carbon equilibrium concentration austenite
% xaflag= xa flag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% autor: adrian boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%- carbon concentration equilibrium austenite equation
% xcaeq=1 L.C. CHANG (mmta 2003)

%- xto austenite carbon concentration
  if xcaeq==1
    xTo=3.072-0.0016.*T-0.24.*si-0.16.*mn-0.115.*ni+0.25.*cu+0.06.*mo+2.69.*cr;%L.C. CHANG (mmta 2003)
  else
    disp('wrong in xtoF !!!')
	return
  end

end