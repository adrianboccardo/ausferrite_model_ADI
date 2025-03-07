function [F]=energyBha(T,T10,T20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Bhadeshia: Energy
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted to Octave by a.d. boccardo
% date: 03-16-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  T7=T-100.*T20;
  T8=T7-1140;
  if (T7<300)
    F=1.38.*T7-1499;
  end
  
  if (T7<700&T7>=300)
    F=1.65786.*T7-1581;
  end
  
  if (T7<940&T7>=700)
    F=1.30089.*T7-1331;
  end
  
  if (T7<940)
    F=(141.*T10+F).*4.187;
  else
    F=T8.*(-3.58434e-9.*T8+2.70013e-6)-1.04923e-3;
    F=T8.*(F.*T8+0.26557)-8.88909;
    F=(141*T10+F)*4.187;
  end

end