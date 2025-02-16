function [wrong]=writeF(vfGr,vfA,plength,rA,t,deltat,imeff,imeffep,typn,tni,tnf,nucmod,ttn,typeplot,k,ncs,tgamma,ta,tenv,fphp,msm,plotyn,casename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% White
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a. d. boccardo
% date: 03-02-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%-- write some information
  where=2; % where=1 (in windows), where=2 (in text file)
  wrong=0; % wrong=0 (there isn't error), wrong=1 (there is error)

  if where==1
% volume fraction
    disp('** initial volume fraction:')
    disp(['  * Graphite: ',num2str(vfGr)])
    disp(['  * Austenite: ',num2str(vfA)])
% microstructure
    disp('** microstructure parameters:')
    disp(['  * platelet length: ',num2str(plength),' [micrometro]'])
    disp(['  * austenite shell radious: ',num2str(rA),' [micrometro]'])
% time
    disp('** time:')
    disp(['  * treatment time: ',num2str(t),' [s]'])
    disp(['  * delta time: ',num2str(deltat),' [s]'])
% impediment
    disp('** impediment:')
    if imeff==0 
      disp('  * impediment effect: no')
    elseif imeff==1
      disp('  * impediment effect: yes')
      disp(['  * enhance parameter= ',num2str(imeffep)])
    else
      disp('  * wrong in impediment effect !!!')
      wrong=1;
      break
    end
% sheaf's growth
    disp('** sheafs growth:')
    if typn==1
      disp('  * sheafs growth 1: discrete')
    elseif typn==2
      disp('  * sheafs growth 2: continuous')
    else
      disp('  * wrong in sheafs growth !!!')
      wrong=1;
      break
    end
% nucleation model
    disp('** nucleation')
    if nucmod==1
      disp('  * nucleation model 1: proposed time')
      if ttn==1
	disp('    - type of nucleation 1: fixed')
	disp(['    - time nucleation: ',num2str(tni),' [s/platelet]'])
      elseif ttn==2
	disp('    - type of nucleation 2: increment with austenite') 
	disp('      carbon concentration at rA') 
	disp(['    - initial time nucleation: ',num2str(tni),' [s/platelet]'])
	disp(['    - final time nucleation: ',num2str(tnf),' [s/platelet]'])
      else 
	disp('    - wrong in type of time nucleation !!!')
	wrong=1;
	break
      end
    elseif nucmod==2
      disp('  * nucleation model 2: Matsuda-Bhadeshia')
    else
      nucmod
      disp('  * wrong in nucleation model !!!')
      wrong=1;
      break
    end
% plot
    disp('** plot')
    if typeplot==1
      disp('  * plot volume fraction')
    elseif typeplot==2
      disp('  * plot time nucleation')
    elseif typeplot==3
      disp('  * plot rate ausferrite volume fraction')
    else
      disp('  * wrong in type plot !!!')
      wrong=1;
      break
    end


  elseif where==2
    cd scratch
% file name
    filename = [casename ".res"];
    fid = fopen (filename, "w");
%case name
    fputs (fid, "***Input file to case: ");
    fprintf(fid, "%s", casename);
    fputs (fid, " ***");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% volume fraction
    fputs (fid, "Initial volume fraction");
    fprintf(fid, "\n");
    fputs (fid, "  * Graphite:");
    fprintf(fid, "%g", vfGr);
    fprintf(fid, "\n");
    fputs (fid, "  * Austenite:");
    fprintf(fid, "%g", vfA);
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% nodule count
    fputs (fid, "Nodule conunt");
    fprintf(fid, "\n");
    fputs (fid, "  * nodule: ");
    fprintf(fid, "%g", ncs);
    fputs (fid, "[nodules/mm2]");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% microstructure
    fputs (fid, "Initial austenite chemical composition [w%]");
    fprintf(fid, "\n");
%C
    fputs (fid, "  * carbon: ");
    fprintf(fid, "%g", k(1));
    fprintf(fid, "\n");
%Si
    fputs (fid, "  * silicon: ");
    fprintf(fid, "%g", k(2));
    fprintf(fid, "\n");
%Mn
    fputs (fid, "  * manganese: ");
    fprintf(fid, "%g", k(3));
    fprintf(fid, "\n");
%Ni
    fputs (fid, "  * nickel: ");
    fprintf(fid, "%g", k(4));
    fprintf(fid, "\n");
%Mo
    fputs (fid, "  * molybdenum: ");
    fprintf(fid, "%g", k(5));
    fprintf(fid, "\n");
%Cr
    fputs (fid, "  * chromium: ");
    fprintf(fid, "%g", k(6));
    fprintf(fid, "\n");
%V
    fputs (fid, "  * vanadium: ");
    fprintf(fid, "%g", k(7));
    fprintf(fid, "\n");
%Fe
    fputs (fid, "  * iron: ");
    fprintf(fid, "%g", k(8));
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% microstructure
    fputs (fid, "Microstructure parameters");
    fprintf(fid, "\n");
    fputs (fid, "  * platelet length: ");
    fprintf(fid, "%g", plength);
    fputs (fid, "[micrometro]");
    fprintf(fid, "\n");
    fputs (fid, "  * austenite shell radious: ");
    fprintf(fid, "%g", rA);
    fputs (fid, "[micrometro]");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

%heat treatment temperarute
    fputs (fid, "Heat treatment temperature");
    fprintf(fid, "\n");
    fputs (fid, "  * austenitization temperature: ");
    fprintf(fid, "%g", tgamma);
    fputs (fid, "[ºC]");
    fprintf(fid, "\n");
    fputs (fid, "  * austempered temperature: ");
    fprintf(fid, "%g", ta);
    fputs (fid, "[ºC]");
    fprintf(fid, "\n");
    fputs (fid, "  * ambient temperature: ");
    fprintf(fid, "%g", tenv);
    fputs (fid, "[ºC]");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% time
    fputs (fid, "Time");
    fprintf(fid, "\n");
    fputs (fid, "  * treatment treatment time: ");
    fprintf(fid, "%g", t);
    fputs (fid, "[s]");
    fprintf(fid, "\n");
    fputs (fid, "  * delta time: ");
    fprintf(fid, "%g", deltat);
    fputs (fid, "[s]");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% impediment
    fputs (fid, "Impediment");
    fprintf(fid, "\n");
    if imeff==0 
      fputs (fid, "  * impediment effect: no");
      fprintf(fid, "\n");
    elseif imeff==1
      fputs (fid, "  * impediment effect: yes");
      fprintf(fid, "\n");
      fputs (fid, "  * enhance parameter:");
      fprintf(fid, "%g", imeffep);
      fprintf(fid, "\n");
    else
      fputs (fid, "  * wrong in impediment effect !!!");
      fprintf(fid, "\n");
      wrong=1;
      cd ..
      break
    end
    fprintf(fid, "\n");

% sheaf's growth
    fputs (fid, "Sheafs growth");
    fprintf(fid, "\n");
    if typn==1
      fputs (fid, "  * sheafs growth 1: discrete");
      fprintf(fid, "\n");
    elseif typn==2
      fputs (fid, "  * sheafs growth 2: continuous");
      fprintf(fid, "\n");
    else
      fputs (fid, "  * wrong in sheafs growth !!!");
      fprintf(fid, "\n");
      wrong=1;
      cd ..
      break
    end
    fprintf(fid, "\n");

% incubation model
    fputs (fid, "Incubation model");
    fprintf(fid, "\n");

    if nucmod==1
      fputs (fid, "  * incubation model 1: proposed time");
      fprintf(fid, "\n");
      if ttn==1
	fputs(fid, "    - type of incubation time 1: fixed");
	fprintf(fid, "\n");
	fputs(fid, "    - incubation time: ");
	fprintf(fid, "%g", tni);
	fputs(fid, "[s/platelet]");
	fprintf(fid, "\n");
      elseif ttn==2
	fputs(fid, "    - type of incubation 2: increment with austenite carbon concentration at rA");
	fprintf(fid, "\n");
	fputs(fid, "    - initial incubation time: ");
	fprintf(fid, "%g", tni);
	fputs(fid, "[s/platelet]");
	fprintf(fid, "\n");
	fputs(fid, "    - final incubation time: ");
	fprintf(fid, "%g", tnf);
	fputs(fid, "[s/platelet]");
	fprintf(fid, "\n");
      else 
	fputs (fid, "  * wrong type of incubation time !!!");
	fprintf(fid, "\n");
	wrong=1;
	cd ..
	break
      end
    elseif nucmod==2
      fputs (fid, "  * incubation model 2: Matsuda-Bhadeshia");
      fprintf(fid, "\n");
    else
      fputs (fid, "  * wrong in incubation model !!!");
      fprintf(fid, "\n");
      fputs (fid, "  * model ");
      fprintf(fid, "%g", nucmod);
      fputs (fid, " doesn't exist");
      fprintf(fid, "\n");
      wrong=1;
      cd ..
      break
    end
    fprintf(fid, "\n");

%final phase prediction at ambient temperature
    fputs (fid, "Final phase prediction at ambient temperature");
    fprintf(fid, "\n");
    if fphp==0
      fputs (fid, "  * final phase prediction: no");
      fprintf(fid, "\n");
    elseif fphp==1
      fputs (fid, "  * final phase prediction: yes");
      fprintf(fid, "\n");
      fputs (fid, "  * martensite start temperature model: ");
      if msm==1
	fputs (fid, "Sablich's thesis");
	fprintf(fid, "\n");
      elseif msm==2
	fputs (fid, "Andrews 1965 (a)");
	fprintf(fid, "\n");
      elseif msm==3
	fputs (fid, "Grange and Stewart 1945");
	fprintf(fid, "\n");
      elseif msm==4
	fputs (fid, "Steven and Haynes 1956");
	fprintf(fid, "\n");
      elseif msm==5
	fputs (fid, "Nehrenberg 1945");
	fprintf(fid, "\n");
      elseif msm==6
	fputs (fid, "Dai 2004");
	fprintf(fid, "\n");
      elseif msm==7
	fputs (fid, "Andrews K. W. 1965 (b)");
	fprintf(fid, "\n");
      elseif msm==8
	fputs (fid, "Payson and Savage 1944");
	fprintf(fid, "\n");
      elseif msm==9
	fputs (fid, "Y. X. Liu 1981");
	fprintf(fid, "\n");
      elseif msm==10
	fputs (fid, "Yang, Jang, Bhadeshia and Suh 2011");
	fprintf(fid, "\n");
      else
	fprintf(fid, "\n");
	fputs (fid, "  * wrong in martensite start temperature model !!!");
	fprintf(fid, "\n");
	wrong=1;
	cd ..
	break
      end
      fputs (fid, "  * martensite volume fraction model: Khan-Bhadeshia");
      fprintf(fid, "\n");
      fputs (fid, "  * output result file: ");
      fprintf(fid, "%s", casename);
      fputs (fid, ".out");
      fprintf(fid, "\n");
    else
      fputs (fid, "  * wrong in final phase prediction !!!");
      fprintf(fid, "\n");
      wrong=1;
      cd ..
      break
    end
    fprintf(fid, "\n");

% file results
    fputs (fid, "File results");
    fprintf(fid, "\n");
    fputs (fid, "  * files ");
    fprintf(fid, "%s", casename);
    fputs (fid, "_*.plot");
    fprintf(fid, "\n");
    fprintf(fid, "\n");

% plot
    fputs (fid, "Plot");
    fprintf(fid, "\n");

    if plotyn==1
      if typeplot==1
	fputs (fid, "  * plot volume fraction vs time");
	fprintf(fid, "\n");
      elseif typeplot==2
	fputs (fid, "  * plot incubation time vs time");
	fprintf(fid, "\n");
      elseif typeplot==3
	fputs (fid, "  * plot rate ausferrite volume fraction vs time");
	fprintf(fid, "\n");
      elseif typeplot==4
	fputs (fid, "  * plot incubation time vs austenite carbon content");
	fprintf(fid, "\n");
      else
	fputs (fid, "  * wrong in type plot !!!");
	fprintf(fid, "\n");
	wrong=1;
	cd ..
	break
      end
    elseif plotyn==0
	fputs (fid, "  * plot: no");
	fprintf(fid, "\n");      
    else
      fputs (fid, "  * wrong in type plotyn !!!");
      fprintf(fid, "\n");
      wrong=1;
      cd ..
      break
    end
    fprintf(fid, "\n");


    fclose (fid);
    cd ..
  end
  
end
  
