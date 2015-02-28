% analyze_mesh_DGM.m
%
% Copyright (C) 2015 < Olivier DAZEL <olivier.dazel@univ-lemans.fr> >
%
% This file is part of PLANES.
%
% PLANES (Porous LAum NumErical Simulator) is a software to compute the
% vibroacoustic response of sound packages containing coupled
% acoustic/elastic/porous substructures. It is mainly based on the
% Finite-Element Method and some numerical methods developped at
% LAUM (http://laum.univ-lemans.fr).
%
% You can download the latest version of PLANES at
% https://github.com/OlivierDAZEL/PLANES
% or find more details on Olivier's webpage
% http://perso.univ-lemans.fr/~odazel/
%
% For any questions or if you want to
% contribute to this project, contact Olivier.
%
% PLANES is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
%%


period=max(nodes(:,1))-min(nodes(:,1));

ondes_element=zeros(nb_elements,1);
for ie=1:nb_elements
   switch floor(element_label(ie)/1000)
       case {0,2,3,8}
           ondes_element(ie)=1;
       case {1}
           ondes_element(ie)=2;   
       case {4,5}
           ondes_element(ie)=3;
   end
end

dof_start_element=zeros(nb_elements,1);
dof_start_element(1)=1;
for ie=2:nb_elements
   dof_start_element(ie)=dof_start_element(ie-1)+ondes_element(ie-1)*nb_theta; 
end


nb_dof_DGM=dof_start_element(ie)+ondes_element(ie)*nb_theta-1; 

vec_theta=pi/2+linspace(0,2*pi,nb_theta+1);
vec_theta(end)=[];


if nb_periodicity~=0
    
    % Separation of the left and right edges
    nb_periodicity=nb_periodicity/2

    edge_left= find(periodicity(:,4)==98);
    edge_right=find(periodicity(:,4)==99);
    periodicity_left=periodicity(edge_left,1:3)
    periodicity_right=periodicity(edge_right,1:3)
    
    % Ordering of the edge so that they are ordered on both sides from
    % increasing y coordinate
    
    y_min_left=min(reshape(nodes(periodicity_left(:,1:2),2),nb_periodicity,2),[],2);
    y_min_right=min(reshape(nodes(periodicity_right(:,1:2),2),nb_periodicity,2),[],2);

    [temp,i_left] =sort(y_min_left);
    [temp,i_rigtt]=sort(y_min_right);

    periodicity_left=periodicity_left(i_left,:);
    periodicity_right=periodicity_right(i_left,:);    
    
end







