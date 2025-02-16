function [xca]=xcaF(Ta,si,mn,ni,cu,mo,cr,v,w,co,al,nb,ti,xcaeq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Carbon concentration
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
% of austenite with graphite (nodular cast iron)
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
% date: 07-08-2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%- carbon concentration equilibrium austenite equation
% xcaeq=1 F. Neumann (1965)
% xcaeq=2 R.C. Voigt (1984)
% xcaeq=3 L.C. Chang (1998)

%-carbon equilibrium concentration austenite
  if xcaeq==1
    xca=3.35e-4.*Ta+1.61e-6.*Ta.^2+0.006.*mn-0.11.*si-0.07.*ni+0.014.*cu-0.3.*mo-0.435; %F. Neumann (1965)
  elseif xcaeq==2
    xca=Ta./420-0.17.*si-0.95; %R.C. Voigt (1984)
  elseif xcaeq==3
    xca=0.0028.*Ta+0.11.*mn-0.057.*si-0.058.*ni+0.013.*cu-0.12.*mo-1.7;	%L.C. Chang (1998)
  elseif xcaeq==4
    xca=0.335e-3.*Ta+1.61e-6.*Ta.^2+0.006.*mn-0.11.*si-0.07.*ni+0.014.*cu-0.3.*mo-0.435; %chang 2003, eq. 4 [all wi/wt%] 
  else
    disp('wrong in xcaF !!!')
	return
  end
 
end
