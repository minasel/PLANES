model_data.lx=1;
model_data.ly=10;
model_data.nx=5;
model_data.ny=ceil(model_data.nx*model_data.ly/model_data.lx);
model_data.label=[3 1 1 1];
theta_DGM.nb=4;
tilt=0*pi/theta_DGM.nb;

[nb,nodes,elem,edge_msh]=createmshH12(model_data.lx,model_data.ly,model_data.nx,model_data.ny,model_data.label);

% All the elements are DGM on H

elem.model=11*ones(nb.elements,1);