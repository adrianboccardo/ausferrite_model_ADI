%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUSFERRITE MODEL
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
% The model consideres ausferrite description, nucleation and growth of ferrite platelets
% within ausferrite, and graphite nodules of different sizes (multiset)
%
% Main output: Evolution of ferrite platelet fraction and deformation due to
% phase change.
%
% The model description is published at:
% Boccardo, A.D., Dardati, P.M., Celentano, D.J. et al. A Microscale Model for 
% Ausferritic Transformation of Austempered Ductile Irons. Metall Mater Trans A 48,
% 524–535 (2017). https://doi.org/10.1007/s11661-016-3816-9
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author: a.d. boccardo
% date: 07-12-2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

disp('AUSFERRITE MODEL')
disp('Copyright (C) 2015 Adrian Boccardo')
disp('This program comes with ABSOLUTELY NO WARRANTY')
disp('This is free software, and you are welcome to redistribute it')
disp('under certain conditions.')
disp(' ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%--case name
casename=input('case name= ','s');

%%--microstructure
%ncs=[82.5,247.5]; %superficial nodule count [nodules/mm2]
%ncs=[140]; %superficial nodule count [nodules/mm2]
%ncs=[330]; %superficial nodule count [nodules/mm2]
%ncs=[840]; %superficial nodule count [nodules/mm2]
%ncs=[1992]; %superficial nodule count [nodules/mm2]
ncs=[200]; %superficial nodule count [nodules/mm2] (vw)
%ncs=[64]; %superficial nodule count [nodules/mm2]
sfset=[1]; %set superficial fraction
%sfset=[0.7,0.3]; %set superficial fraction

%%%--matrix chemical composition [w%] (Brata 2007, Cu-iron) ncs=250,
%%%Tgamma=850/900, TA=330.
%k=zeros(1,8);
%cc=3.48;               %C
%k(2)=2.028;            %Si
%k(3)=0.22;             %Mn
%k(4)=0.016;            %Ni
%cu=0.6;                %cu
%k(5)=0.03;             %Mo
%k(6)=0.05;             %Cr
%k(7)=0.;               %V

%%%--matrix chemical composition [w%] (Brata 2007, Ni-Cu-iron) ncs=198,
%%%Tgamma=850, TA=330.
%k=zeros(1,8);
%cc=3.48;               %C
%k(2)=1.83;             %Si
%k(3)=0.23;             %Mn
%k(4)=1.05;             %Ni
%cu=0.6;                %cu
%k(5)=0.015;            %Mo
%k(6)=0.01;             %Cr
%k(7)=0.;               %V

%%%--matrix chemical composition [w%] (Bahmani 1997) ncs=95,
%k=zeros(1,8);
%cc=3.5;                %C
%k(2)=2.6;              %Si
%k(3)=0.25;             %Mn
%k(4)=0.96;             %Ni
%cu=0.48;               %cu
%k(5)=0.27;             %Mo
%k(6)=0.;               %Cr
%k(7)=0.;               %V

%%%--matrix chemical composition [w%] (fras MST vol28) Tgamma=920
%k=zeros(1,8);
%cc=3.7;               %C
%k(2)=2.7;             %Si
%k(3)=0.1;             %Mn
%k(4)=0.;              %Ni
%cu=0.;                %cu
%k(5)=0.;              %Mo
%k(6)=0.;              %Cr
%k(7)=0.;              %V

%%--matrix chemical composition [w%] (vw)
k=zeros(1,8);
cc=3.4;               %C
k(2)=2.3;             %Si
k(3)=0.8;             %Mn
k(4)=0.;              %Ni
cu=0.4;               %cu
k(5)=0.;              %Mo
k(6)=0.03;            %Cr
k(7)=0.;              %V

%%--matrix chemical composition [w%] (yescas thesis) Tgamma=950ºC
%% ncs=64 [nodules/mm2] and sfset=1.
%k=zeros(1,8);
%cc=3.55;              %C
%k(2)=2.5;             %Si
%k(3)=0.55;            %Mn
%k(4)=0.;              %Ni
%cu=0.31;              %cu
%k(5)=0.15;            %Mo
%k(6)=0.;              %Cr
%k(7)=0.;              %V

%%--heat treatment time
t=3600;      %total time [s]
deltat=1;    %delta time [s]

%%--heat treatment temperature
tgamma=880; %temperature [ºC]
ta=300;     %temperature [ºC]
tenv=20;    %temperature [ºC]

%%--models
%impediment
imeff=1; %impediment effect: imeff=0 (no), imeff=1 (yes).

%sheaf's growth
typn=2;  %type of sheaf's growth: typn=1 (discrete), typn=2 (continuous).

%phase fraction at ambient temperatura
fphp=1; %fphp=0 (no), fphp=1 (yes)
msm=5;  %martensite start temperature equation

%%--plot
plotyn=1;    %plotyn=1 (plot), plotyn=0 (not plot)
typeplot=1;  %type of plot: typeplot=1 (volume fractions),
		     %typeplot=2 (incubation time vs time),
			 %typeplot=3 (rate ausferrite volume fraction).
			 %typeplot=4 (incubation time vs austenite carbon content),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- check
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sfsetcheck=sum(sfset);
if sfsetcheck~=1.0
  disp('**sum of set fraction different to one')
  sfsetcheck
  return
end

[r,nset]=size(ncs); %nset
[r1,c1]=size(sfset);
if nset~=c1
  disp('**number of ncs different to one to sfset')
  nset
  c1
  return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%austenite carbon concentration at tgamma [w%]
[cGamma]=xcaF(tgamma,k(2),k(3),k(4),cu,k(5),k(6),k(7),0,0,0,0,0,4);
%austenite carbon concentration xto [w%]
[cGammaTo]=xtoF(ta,k(2),k(3),k(4),cu,k(5),k(6),k(7),0,0,0,0,0,1);
%platelets ferrite carbon concentration [w%]
cAlphap=0.03;
%chemical composition to k array
Si=k(2);
Mn=k(3);
Ni=k(4);
Mo=k(5);
Cr=k(6);
%initial volume fraction
denAtga=8099.79-0.506.*tgamma+(-118.26+0.00739.*tgamma).*cGamma+(-7.59+(3.422e-3).*tgamma-(5.388e-7)*tgamma.^2-0.014271.*Cr).*Cr+(1.54+(2.267e-3).*tgamma-(11.26e-7).*tgamma.^2+0.062642.*Ni).*Ni-68.24.*Si-6.01.*Mn+12.45.*Mo;
denGro=2200; %[kg/m3] see paper adi boccardo et al.
alphasgr=4.06e-6.*(0.853157+4.26564e-4.*tgamma-1.42849e-7.*tgamma.^2); %see paper adi boccardo et al.
denGrtga=denGro./(1+3.*alphasgr.*(tgamma-tenv)); % see paper adi boccardo et al.
vfGr=0.09; %initial value for iteration
cGr=100;
for i=1:1:100
  denTo=vfGr.*denGrtga+(1-vfGr).*denAtga;
  vfGr=(cc.*denTo-(1-vfGr).*cGamma.*denAtga)./(cGr.*denGrtga);
end
vfA=1-vfGr;
xfpab=0.12; % percent of austenite film repect to ferrite platelet fraction (Gaude 2006)

%austempered heat treatment temperature
temp=ta; %temperature in ºC
T=temp+273; %temperature in kelvin
Tgeo=T;
Tgeomax=450+273;     %[K] because subunit it too big and there is no experimental material to validate this value
Tgeomin=260+273;     %[K] because subunit dimension are negative
if (Tgeo>=Tgeomax) 
  Tgeo=Tgeomax;
elseif (Tgeo<=Tgeomin)
  Tgeo=Tgeomin;
end
up=20.*((Tgeo-528)./150).^(3);  %volume platelet [micrometro3]
plength=10.*(Tgeo-528)./150;    %platelet length. See matsuda 2004 [micro metro]

%rve zise
srve=sfset./ncs;                    %rve surface (at ecuador) [area set/nodule (mm2/nodule)]
vrve=4./3.*pi.*(srve./pi).^(3./2);  %rve volume [volume set/nodule (mm3/nodule)]
rAm=((srve./pi).^(1./2)).*1000;     %austenite radious [micrometer]
rGrm=rAm.*vfGr.^(1./3);             %graphite radious [micrometer]
rAusfm=rGrm;                        %initial ausferrite radious
volm=(4./3.*pi.*rAm.^3);            %rve volume (microm3/nodule)
ncv=sfset./(vrve.*1000.^3);         %volumetric nodule count [nodules/microm3]
vfAini=vfA;

%density
denA=8099.79-0.506.*temp+(-118.26+0.00739.*temp).*cGamma+(-7.59+(3.422e-3).*temp-(5.388e-7)*temp.^2-0.014271.*Cr).*Cr+(1.54+(2.267e-3).*temp-(11.26e-7).*temp.^2+0.062642.*Ni).*Ni-68.24.*Si-6.01.*Mn+12.45.*Mo;
denATo=8099.79-0.506.*temp+(-118.26+0.00739.*temp).*cGammaTo+(-7.59+(3.422e-3).*temp-(5.388e-7)*temp.^2-0.014271.*Cr).*Cr+(1.54+(2.267e-3).*temp-(11.26e-7).*temp.^2+0.062642.*Ni).*Ni-68.24.*Si-6.01.*Mn+12.45.*Mo;
denF=7875.96-0.297.*temp-(5.62e-5).*temp.^2+(-206.35+0.00778.*temp+(1.472e-6).*temp.^2).*cAlphap+(-8.58+(1.229e-3).*temp+(0.852e-7).*temp.^2+0.018367.*Cr).*Cr+(-0.22-(0.47e-3).*temp-(1.855e-7).*temp.^2+0.104608.*Ni).*Ni-36.86.*Si-7.24.*Mn+30.78.*Mo;
denGro=2200;                                                       %[kg/m3] see paper adi boccardo et al.
alphasgr=4.06e-6.*(0.853157+4.26564e-4.*temp-1.42849e-7.*temp.^2); %see paper adi boccardo et al.
denGr=denGro./(1+3.*alphasgr.*(temp-tenv));                        %see paper adi boccardo et al.

%bhadeshia constant
R=8.31432; %J/(K mol)
r=2540;    %J/mol

vfFpmax=(cGammaTo.*denATo-cGamma.*denA)./(cGammaTo.*denATo-cAlphap.*denF);
vfAtmax=1-vfFpmax;
vfFpgbmaxm=vfFpmax.*(((rGrm+plength)./rAm).^3-(rGrm./rAm).^3);

% model constant
Akm=(4.*pi./3)*vfFpmax.*((rGrm+plength).^3-rGrm.^3)./up;
Bk=1;

% deformation
rhomico=vfGr.*denGr+vfAini.*denA;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- empty arrays 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time=[0];     %time's matrix for storage
vfAusfm=[0];  %ausferrite volume fraction's matrix for storage
vfAhm=[vfA];  %austenite hallo volume fraction's matrix for storage
vfGrm=[vfGr]; %graphite volume fraction's matrix for storage
vfFpm=[0];    %platelet ferrite volume fraction's matrix for storage
vfAfm=[0];    %film austenite volume fraction's matrix for storage
vfAbm=[0];    %block austenite volume fraction's matrix for storage
vfAtm=[vfA];  %total austenite volume fraction's matrix for storage
vfFpgbm=[];   %grain boundary platelet ferrite volume fraction
vfFpautm=[];  %autocatalitic platelet ferrite volume fraction
ratevfAusfm=[]; %rate ausferrite volume fraction's matrix for storage
cGammablockm=[cGamma]; %
ccAm=[cGamma]; %austenite carbon concentration matrix for storage
tfn1m=[];     %time for nucleation's matrix for storage
tfn2m=[];     %time for nucleation's matrix for storage
xim=[0];      %time for nucleation's matrix for storage
fabm=[];
delGmm=[];
deltam=[0];
Ipgbm=[];
Ipautm=[];
defm=[0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vfAusf=0;
vfFp=0;
vfFpgbm1=zeros(1,nset);
vfFpautm1=zeros(1,nset);
tfn=0;    %time for nucleation [s]
tnn2=0;
tfn2=0;
xim1=zeros(1,nset);
vfFpm1=zeros(1,nset);
vfAfm1=zeros(1,nset);
vfAbm1=zeros(1,nset);
cGammablockm1=cGamma.*ones(1,nset);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------%%%%%  solve %%%%%----------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- maximum free energy available for para-equilibrium nucleation
%%   (initial value)
k(1)=cGamma; %rees et al.
k(8)=0;
k(8)=100-sum(k);
T=temp+273; %temperature in kelvin
[GMAX]=gmaxBha(k,T);

for i=deltat:deltat:t

  %%-- time
  tfn=i;

  %%-- ausferrite growth 
  vfAusflast=vfAusf;
  vfAusf=0;
  vfAh=0;
  for iset=1:1:nset
% load set variable
    rGr=rGrm(iset);
    rA=rAm(iset);
    rAusf=rAusfm(iset);
    vol=volm(iset); %don't add
    Ak=Akm(iset);   %don't add
    vfFpgbmax=vfFpgbmaxm(iset); %don't add
    vfFpgb=vfFpgbm1(iset);      %don't add
    vfFpaut=vfFpautm1(iset);    %don't add
    ncvi=ncv(iset);
    cGammablocki=cGammablockm1(iset);

% rAusf growth
    [rAusf]=ausferritem6(GMAX,T,cGammablocki,cGammaTo,cGamma,plength,deltat,rAusf,rA,vfAusflast,rGr,vfGr,imeff,vfA,vfAini);

% ausferrite and hallo austenite volume fraction
    vfAusf=vfAusf+4./3.*pi.*ncvi.*(rAusf.^3-rGr.^3);
    vfAh=vfAh+4./3.*pi.*ncvi.*(rA.^3-rAusf.^3);

% save set variable
    rAusfm(iset)=rAusf;
    vfFpgbm1(iset)=vfFpgb;   %don't add
    vfFpautm1(iset)=vfFpaut; %don't add
  end

  %%-- ferrite growth 
  vfFp=0;
  vfAf=0;
  vfAb=0;
  vfAt=0;
  for iset=1:1:nset
% load set variable
    rGr=rGrm(iset);
    rA=rAm(iset);
    rAusf=rAusfm(iset);
    vol=volm(iset);
    Ak=Akm(iset);
    vfFpgbmax=vfFpgbmaxm(iset);
    xi=xim1(iset);
    vfFpgb=vfFpgbm1(iset);
    vfFpaut=vfFpautm1(iset);
    ncvi=ncv(iset);
    vfFpi=vfFpm1(iset);
    vfAfi=vfAfm1(iset);
    vfAbi=vfAbm1(iset);
    cGammablocki=cGammablockm1(iset);

% vFpi growth
    denAb=8099.79-0.506.*temp+(-118.26+0.00739.*temp).*cGammablocki+(-7.59+(3.422e-3).*temp-(5.388e-7)*temp.^2-0.014271.*Cr).*Cr+(1.54+(2.267e-3).*temp-(11.26e-7).*temp.^2+0.062642.*Ni).*Ni-68.24.*Si-6.01.*Mn+12.45.*Mo;
	[xi,vfFpaut,vfFpgb,vfFpi,vfAfi,vfAbi,cGammablocki]=ferritem6(vfFpi,xfpab,cGamma,cAlphap,cGammaTo,GMAX,T,xi,Bk,vol,up,deltat,vfFpaut,Ak,vfFpgb,vfFpgbmax,vfFpmax,rGr,rA,rAusf,denA,denF,denATo,denAb);

% vFp volume fraction
    vfFp=vfFp+4./3.*pi.*ncvi.*vfFpi.*rA.^3; %sum(volseti/volt*volF/volseti)=volF/volt
    vfAf=vfAf+4./3.*pi.*ncvi.*vfAfi.*rA.^3; %sum(volseti/volt*volAf/volseti)=volAf/volt
    vfAb=vfAb+4./3.*pi.*ncvi.*vfAbi.*rA.^3; %sum(volseti/volt*volAb/volseti)=volAb/volt
    vfAt=vfAt+4./3.*pi.*ncvi.*(rA.^3.*(1-vfFpi)-rGr.^3); %other form to compute vfAt

% save set variable
    rAusfm(iset)=rAusf; %don't add
    xim1(iset)=xi;
    vfFpgbm1(iset)=vfFpgb;
    vfFpautm1(iset)=vfFpaut;
    vfFpm1(iset)=vfFpi;
    vfAfm1(iset)=vfAfi;
    vfAbm1(iset)=vfAbi;
    cGammablockm1(iset)=cGammablocki;
  end
  cGammablockav=sum(cGammablockm1)./nset;
  vfAfb=vfAf+vfAb;

%%-- xioverall and deltaoverall
  xio=vfFp./(vfAini.*vfFpmax);
  deltao=vfAusf./vfAini;

%%-- deformation
  denAb=8099.79-0.506.*temp+(-118.26+0.00739.*temp).*cGammablockav+(-7.59+(3.422e-3).*temp-(5.388e-7)*temp.^2-0.014271.*Cr).*Cr+(1.54+(2.267e-3).*temp-(11.26e-7).*temp.^2+0.062642.*Ni).*Ni-68.24.*Si-6.01.*Mn+12.45.*Mo;
  rhomic=vfGr.*denGr+vfFp.*denF+vfAf.*denATo+vfAb.*denAb+vfAh.*denA;
  def=(rhomico./rhomic-1)./3.*100; % [%]

%%-- save some variables
  time=[time,i];
  vfAusfm=[vfAusfm,vfAusf];
  vfAhm=[vfAhm,vfAh];
  vfGrm=[vfGrm,vfGr];
  vfFpm=[vfFpm,vfFp];
  vfAfm=[vfAfm,vfAf];
  vfAbm=[vfAbm,vfAb];
  vfAtm=[vfAtm,vfAt];
  deltam=[deltam,deltao];
  xim=[xim,xio];
  cGammablockm=[cGammablockm,cGammablockav];
  ccAm=[ccAm,k(1)]; % austenite carbon concentration
  defm=[defm,def];
end

%%-- check some problems
xi=sum(xim1)./nset;
xi=ceil(10000.*xi)./10000; %to avoid some problems
if (xi==1)
  cGammablockav=ceil(10000.*cGammablockav)./10000;
  cGammaTo=ceil(10000.*cGammaTo)./10000;
  if (cGammablockav~=cGammaTo)
    disp(' ')
    disp('error: xi=1 and cGammablockav is not equal than cGammaTo')
    disp(['cGammablockav= ',num2str(cGammablockav)])
    disp(['cGammaTo= ',num2str(cGammaTo)])
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- final volume fraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if fphp==1
  [vfAt,vfM]=fphfF_new(vfFp,vfAt,vfAf,vfAini,vfGr,k,tenv,vfA,msm,casename,t,cGammablockav,vfAb);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- output file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd scratch

% ferrite platelets volume fraction
Fpm=[transpose(time),transpose(vfFpm)];
filename = [casename "_vFp.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vFp");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Fpm));
fclose(fid);

% deformation
defm=defm./max(defm);
deftime=[transpose(time),transpose(defm)];
filename = [casename "_def.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   normalized def [pct]");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(deftime));
fclose(fid);

% austenite film volume fraction
Afm=[transpose(time),transpose(vfAfm)];
filename = [casename "_vAf.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vAf");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Afm));
fclose(fid);

% austenite block volume fraction
Abm=[transpose(time),transpose(vfAbm)];
filename = [casename "_vAb.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vAb");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Abm));
fclose(fid);

% austenite hallo volume fraction
Ahm=[transpose(time),transpose(vfAhm)];
filename = [casename "_vAh.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vAh");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Ahm));
fclose(fid);

% total austenite volume fraction
Atm=[transpose(time),transpose(vfAtm)];
filename = [casename "_vAt.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vAt");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Atm));
fclose(fid);

% ausferrite volume fraction
Ausfm=[transpose(time),transpose(vfAusfm)];
filename = [casename "_vAusf.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vAusf");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Ausfm));
fclose(fid);

% graphite volume fraction
Grm=[transpose(time),transpose(vfGrm)];
filename = [casename "_vGr.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   vGr");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(Grm));
fclose(fid);

%% incubation time 1 vs temperature
%tfn1mT=[transpose(time),transpose(tfn1m)];
%filename = [casename "_tfn1T.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   incubation time 1[s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(tfn1mT));
%fclose(fid);

%% incubation time 1 vs austenite carbon concentration
%tfn1mA=[transpose(ccAm),transpose(tfn1m)];
%filename = [casename "_tfn1A.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#austenite carbon content [w%]   incubation time 1[s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(tfn1mA));
%fclose(fid);

%% incubation time 2 vs temperature
%tfn2mT=[transpose(time),transpose(tfn2m)];
%filename = [casename "_tfn2T.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   incubation time 2[s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(tfn2mT));
%fclose(fid);

%% incubation time 2 vs austenite carbon concentration
%tfn2mA=[transpose(ccAm),transpose(tfn2m)];
%filename = [casename "_tfn2A.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#austenite carbon content [w%]   incubation time 2[s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(tfn2mA));
%fclose(fid);

%% rate austenite volume fraction 
%ratevfAusfmf=[transpose(time),transpose(ratevfAusfm)];
%filename = [casename "_ratevfAusf.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   rate vfAusf[1/s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(ratevfAusfmf));
%fclose(fid);

% xi 
timexi=[transpose(time),transpose(xim)];
filename = [casename "_xi.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   xi");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(timexi));
fclose(fid);

% delta
timedelta=[transpose(time),transpose(deltam)];
filename = [casename "_delta.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   delta");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(timedelta));
fclose(fid);

%% fabm
%timefabm=[transpose(time),transpose(fabm)];
%filename = [casename "_fab.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   fab");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(timefabm));
%fclose(fid);

% cGammablock 
timecGammablock=[transpose(time),transpose(cGammablockm)];
filename = [casename "_cGammablock.plot"];
fid = fopen (filename, "w");
fputs (fid, "#time [s]   cGammablock [w percent]");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(timecGammablock));
fclose(fid);

%% delGm
%timedelGm=[transpose(time),transpose(delGmm)];
%filename = [casename "_delGm.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   delGm [J/mol]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(timedelGm));
%fclose(fid);

% delta-xi
deltaxi=[transpose(deltam),transpose(xim)];
filename = [casename "_deltaxi.plot"];
fid = fopen (filename, "w");
fputs (fid, "#delta    xi");
fprintf(fid,"\n");
fprintf(fid,"%g %g  \n",transpose(deltaxi));
fclose(fid);

%% Ipgb
%Ipgbtime=[transpose(time),transpose(Ipgbm)];
%filename = [casename "_Ipgb.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#Ipgb [nucleo/(s micrometro^3)]  time [s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(Ipgbtime));
%fclose(fid);

%% Ipaut
%Ipauttime=[transpose(time),transpose(Ipautm)];
%filename = [casename "_Ipaut.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#Ipaut [nucleo/(s micrometro^3)]  time [s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(Ipauttime));
%fclose(fid);

%% Ip
%Ipm=Ipgbm+Ipautm;
%Iptime=[transpose(time),transpose(Ipm)];
%filename = [casename "_Ip.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#Ip [nucleo/(s micrometro^3)]  time [s]");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(Iptime));
%fclose(fid);

%% ferrite platelets volume fraction (grain boundary)
%Fpgbm=[transpose(time),transpose(vfFpgbm)];
%filename = [casename "_vFpgb.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   vFpgb");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(Fpgbm));
%fclose(fid);

%% ferrite platelets volume fraction (autocatalitic)
%Fpautm=[transpose(time),transpose(vfFpautm)];
%filename = [casename "_vFpaut.plot"];
%fid = fopen (filename, "w");
%fputs (fid, "#time [s]   vFpaut");
%fprintf(fid,"\n");
%fprintf(fid,"%g %g  \n",transpose(Fpautm));
%fclose(fid);


cd ..


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plotyn==1
  clf
  hold on
  if typeplot==1
    plot(time,vfAusfm,'b')
    %plot(time,vfAm,'r')
    plot(time,vfGrm,'g')
    plot(time,vfFpm,'*m')
    %plot(time,vfAfbm,'*y')
    plot(time,vfAtm,'r')
    %legend('vfAus','vfA','vfGr','vfFp','vfAfb','vfAt')
    %legend('vfAus','vfGr','vfFp','vfAfb','vfAt')
	legend('vfAus','vfGr','vfFp','vfAt')
    xlabel('time [s]')
    ylabel('volume fractions')
    lim=[0 t];
    xlim(lim)
    lim=[0 1];
    ylim(lim)
  elseif typeplot==2
    plot(time,tfnm,'g')
    legend('incubation time')
    xlabel('time [s]')
    ylabel('time nucleation [s]')
  elseif typeplot==3
    plot(time,ratevfAusfm,'b')
    legend('rate vfAusf')
    xlabel('time [s]')
    ylabel('rate vfAus [volume fraction/s]')
  elseif typeplot==4
    plot(ccAm,tfnm,'g')
    legend('incubation time')
    xlabel('austenite carbon content [w%]')
    ylabel('time nucleation [s]')
  end
  hold off
  grid
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-- end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
disp(['> case ',num2str(casename),' has finished'])

