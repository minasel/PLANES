% export_fig_TR6.m
%
% Copyright (C) 2014 < Olivier DAZEL <olivier.dazel@univ-lemans.fr> >
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



x=[];
y=[];

hold on
for ie=1:nb_elements
    
    
    vertices=[nodes(elements(ie,:),:)'];
    
    %changement de base (cart to triangle)
    coord=[];
    for i=1:length(vertices(1,:))
        coord=[coord vertices(1:2,i)-vertices(1:2,1)];
    end
    coeffksi=zeros(2,1);
    coeffeta=zeros(2,1);
    M=[coord(:,3)' 0 0; 0 0 coord(:,5)'; coord(:,5)' 0 0; 0 0 coord(:,3)'];
    coeffbase=inv(M)*[1;1;0;0];
    coeffksi=coeffbase(1:2);
    coeffeta=coeffbase(3:4);
    
    
    faces = [1 2 3]';
    vert=coord(:,[1 3 5]);
    for i=1:1
        [vert, faces]=linearSubdivision(vert, faces);
    end
    
    ksi=vert'*coeffksi;
    eta=vert'*coeffeta;
    lambda=1-eta-ksi;
    mat_ksi_eta=[-lambda.*(1-2*lambda) 4*ksi.*lambda -ksi.*(1-2*ksi) 4*ksi.*eta -eta.*(1-2*eta) 4*eta.*lambda];
    
    
    
    
    if ismember(floor(element_label(ie)/1000),[1 4 5])
       
        c=sol(2+(3*(elements(ie,:)-1)));
        val_int=mat_ksi_eta*c.';
        
        for i_faces=1:size(faces,2)
            figure(0002)
            patch(vert(1,faces(:,i_faces))+vertices(1,1)',vert(2,faces(:,i_faces))+vertices(2,1)',abs(val_int(faces(:,i_faces))));
        end
        
    end
    
  
    if ismember(floor(element_label(ie)/1000),[1 4 5])
       
        c=sol(2+(3*(elements(ie,:)-1)));
        val_int=mat_ksi_eta*c.';
        
        for i_faces=1:size(faces,2)
            figure(0002)
            patch(vert(1,faces(:,i_faces))+vertices(1,1)',vert(2,faces(:,i_faces))+vertices(2,1)',abs(val_int(faces(:,i_faces))));
        end
        
    end
    
    
       if ismember(floor(element_label(ie)/1000),[0 2 3 4 5])
       
        c=sol(3+(3*(elements(ie,:)-1)));
        val_int=mat_ksi_eta*c.';
        
        for i_faces=1:size(faces,2)
            figure(0003)
            patch(vert(1,faces(:,i_faces))+vertices(1,1)',vert(2,faces(:,i_faces))+vertices(2,1)',abs(val_int(faces(:,i_faces))));
        end
        
    end 
    
end
title('Pression EF (module)')
axis equal
colorbar



