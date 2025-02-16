function [xTo]=xtoF(T,si,mn,ni,cu,mo,cr,v,w,co,al,nb,ti,xcaeq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Carbon concentration of austenite
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function to evaluate the carbon concentration equilibrium
% of austenite whit graphite (nodular cast iron)
%
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
