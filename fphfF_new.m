function [vfAt,vfM]=fphfF_new(vfFp,vfAt,vfAf,vfAori,vfGr,k,tenv,vfA,msm,casename,t,cGammablockav,vfAb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% final volume fraction
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% autor: adrian boccardo
% date: 07-08-2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% martensite start temperature [ºC]
  [msfb]=msF(cGammablockav,k(2),k(3),k(4),0,k(5),k(6),k(7),0,0,0,0,0,0,msm);
  [msh]=msF(k(1),k(2),k(3),k(4),0,k(5),k(6),k(7),0,0,0,0,0,0,msm);

% martensite volume fraction [vol martensite/vol austenite halo (vfA)]
  itmax=1000;
  c2=0.0029;  %martensitic parameter
  evmat=0.01; %admissible iteration error [%]
  
  if msfb>tenv
    evmt=1.1.*evmat; %for input in while
    in=0;
    vfmfb=0.5;
    while (evmat<=evmt)
      vfmfblast=vfmfb;
      vfmfb=1-exp(-vfmfb.*(1+c2.*(msfb-tenv)));
      evmt=100.*abs(vfmfblast-vfmfb);
      in=in+1;
      if in>=itmax
	disp('wrong in fphfF: increase iterations numbers !!!')
	break
      end
    end
  else
    vfmfb=0;
  end

  if msh>tenv
    evmt=1.1.*evmat; %for input in while
    in=0;
    vfmh=0.5;
    while (evmat<=evmt)
      vfmhlast=vfmh;
      vfmh=1-exp(-vfmh.*(1+c2.*(msh-tenv)));
      evmt=100.*abs(vfmhlast-vfmh);
      in=in+1;
      if in>=itmax
	disp('wrong in fphfF: increase iterations numbers !!!')
	break
      end
    end
  else
    vfmh=0;
  end

%volume fraction at ambient temperature
  vfAh=vfAt-(vfAf+vfAb);
  vfAhini=vfAh;
  vfAbini=vfAb;

  vfAh=vfAhini.*(1-vfmh); %final austenite halo volume fraction (retained)
  vfMh=vfAhini.*vfmh; %final martensite volume fraction

  vfAb=vfAbini.*(1-vfmfb); %final austenite halo volume fraction (retained)
  vfMb=vfAbini.*vfmfb; %final martensite volume fraction

  vfAt=vfAf+vfAh+vfAb; %total austenite volume fraction (retained)
  vfM=vfMh+vfMb;

  vfFp; %ferrite platelets volume fraction
  vfGr; %graphite volume fraction

  check=vfGr+vfFp+vfAt+vfM;

% volume fraction respect to matrix volume at ambient temperature
  vfFpm=vfFp./vfAori;
  vfAtm=vfAt./vfAori;
  vfMm=vfM./vfAori;
  
%output file
  cd scratch
  filename = [casename '.out'];
  fid = fopen (filename, "w");

%case name
  fputs (fid, "***Output file to case: ");
  fprintf(fid, "%s", casename);
  fputs (fid, " ***");
  fprintf(fid, "\n");
  fprintf(fid, "\n");

%heat treatment time
  fputs (fid, "heat treatment time: ");
  fprintf(fid, "%g", t);
  fputs (fid, "[s]");
  fprintf(fid, "\n");
  fprintf(fid, "\n");

% volume fraction at ambient temperature
  fputs (fid, "Volume fraction at ambiente temperature");
  fprintf(fid, "\n");
  fputs (fid, "  * Graphite: ");
  fprintf(fid, "%g", vfGr);
  fprintf(fid, "\n");
  fputs (fid, "  * Ferrite platelets: ");
  fprintf(fid, "%g", vfFp);
  fprintf(fid, "\n");
  fputs (fid, "  * Retained austenite: ");
  fprintf(fid, "%g", vfAt);
  fprintf(fid, "\n");
  fputs (fid, "  * Martensite: ");
  fprintf(fid, "%g", vfM);
  fprintf(fid, "\n");
  fprintf(fid, "\n");

% volume fraction at ambient temperature respect to matrix volume
  fputs (fid, "Volume fraction at ambiente temperature, respect to volume of matrix");
  fprintf(fid, "\n");
  fputs (fid, "  * Ferrite platelets: ");
  fprintf(fid, "%g", vfFpm);
  fprintf(fid, "\n");
  fputs (fid, "  * Retained austenite: ");
  fprintf(fid, "%g", vfAtm);
  fprintf(fid, "\n");
  fputs (fid, "  * Martensite: ");
  fprintf(fid, "%g", vfMm);
  fprintf(fid, "\n");
  
  fclose (fid);
  cd ..
  
end
  