d_x=1;
d_PEM=0.03;
labelPEM=4006;
nx=90;
nx=8;
n_PEM=3;
n_PEM=1;


fid=fopen(name_file_input_FreeFem,'w');
fprintf(fid,'%s\n',name_file_msh);
fprintf(fid,'%12.8f\n',d_x);
fprintf(fid,'%12.8f\n',d_PEM);
fprintf(fid,'%d\n',labelPEM);
fprintf(fid,'%d\n',nx);
fprintf(fid,'%d\n',n_PEM);
fclose(fid);


nb_layers=1;
multilayer(1).d=d_PEM;
multilayer(1).mat=labelPEM;
% Termination condition // 0 for rigid backing 1 for radiation
termination=0;

% Number of waves (two ways) in each layer
% For the resolution, the incident waves is included in the system and put to RHS at the
% end of the procedure

% Addition of a new layer for the incident medium
l0.d=0;
l0.mat=0;
multilayer=[l0 multilayer];
nb_layers=nb_layers+1;

compute_number_PW_TMM