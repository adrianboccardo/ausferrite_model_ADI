function [ms]=msF(c,si,mn,ni,cu,mo,cr,v,w,co,al,nb,ti,n,mseq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to evaluate martensite star
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c= carbon [w%]
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
% mseq= martensite star equation
% ms= martensite star temperature [ºC]
% msflag= flag to run end the program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% autor: adrian boccardo
% date: 07-08-2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%- martensite star equation
% mseq=1 thesis sablich
% mseq=2 Andrews 1965, phd's Yang
% mseq=3 Grange and Stewart 1945, phd's Yang
% mseq=4 Steven and Haynes 1956, phd's Yang
% mseq=5 Nehrenberg 1945, phd's Yang
% mseq=6 Steven W. and Haynes A. G. 1965.
% mseq=7 Andrews K. W. 1965.
% mseq=8 Andrews K. W. 1965.
% mseq=9 Y. X. Liu 1981
% mseq=10 Yang, Jang, Bhadeshia and Suh 2011

%-martensite start temperature [ºc]
  msflag=0;
  if mseq==1
    ms=539-423.*c-30.4.*mn; %thesis sablich
  elseif mseq==2 
    ms=785-453.*c-16.9.*ni-15.*cr-9.5.*mo+217.*c.^2-71.5.*c.*mn-67.6.*c.*cr-273;%Andrews 1965, phd's Yang (originally in kelvin)
  elseif mseq==3  
    ms=811-361.*c-38.9.*mn-38.9.*cr-19.4.*ni-27.8.*mo-273; %Grange and Stewart 1945, phd's Yang
  elseif mseq==4   %equal than mseq=6 
    ms=834.2-473.9.*c-33.*mn-16.7.*cr-16.7.*ni-21.2.*mo-273; %Steven and Haynes 1956, phd's Yang (originally in kelvin)
  elseif mseq==5  
    ms=772-300.*c-33.3.*mn-11.1.*si-22.2.*cr-16.7.*ni-11.1.*mo-273; %Nehrenberg 1945, phd's Yang
  elseif mseq==6  
    ms=667-710.5.*(c+1.4.*n)-18.5.*ni-12.4.*mn-8.4.*cr+3.4.*si-1.6.*mo-22.7.*al+11.6.*(c+1.4.*n).*(mo+cr+mn)-3.7.*((ni+mn).*(cr+mo+al+si)).^(1./2)-273;%Dai 2004. phd' thesis yang (originally in kelvin)
  elseif mseq==7   
    ms=539-423.*c-30.4.*mn-12.1.*cr-17.7.*ni-7.5.*mo; %Andrews K. W. 1965.
  elseif mseq==8  
    ms=772-316.7.*c-33.3.*mn-11.1.*si-27.8.*cr-16.7.*ni-11.1.*mo-11.1.*w-273; %Payson and Savage 1944 (originally in kelvin)
  elseif mseq==9  
    ms=550-361.*c-39.*mn-35.*v-20.*cr-17.*ni-10.*cu-5.*mo-5.*w+16.*co+30.*al; %Y. X. Liu 1981
  elseif mseq==10 
    ms=303-489.*c-9.1.*mn-17.6.*ni-9.2.*cr+21.3.*al+4.1.*si-19.4.*mo-1.*co-41.3.*cu-50.*nb-86.*ti-34.*v-13.*w;%Yang, Jang, Bhadeshia and Suh 2011
  else
    disp('wrong in msF !!!')
	return
  end

end
