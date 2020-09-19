% script makepiechart

% Fukugita & Peebles (2004), p. 3
h = 0.7;

Omega_dark       = 0.954;

Omega_warm_virialized_regions_of_galaxies = 0.024;   % 1  % This means groups and galactic halos
Omega_warm_intergalactic                  = 0.016;   % 2
Omega_intracluster_plasma                 = 0.0018;  % 3
Omega_main_sequence_stars_sph_and_bulges  = 0.0015;  % 4
Omega_main_sequence_stars_disks_and_irr   = 0.00055; % 5
Omega_white_dwarfs                        = 0.00036; % 6
Omega_neutron_stars                       = 0.00005; % 7
Omega_black_holes                         = 0.00007; % 8
Omega_substellar_objects                  = 0.00014; % 9
Omega_HI_HeI                              = 0.00062; %10
Omega_molecular_gas                       = 0.00016; %11
Omega_planets                             = 10^-6;   %12

xx = [Omega_warm_virialized_regions_of_galaxies, Omega_warm_intergalactic, Omega_intracluster_plasma, Omega_main_sequence_stars_sph_and_bulges, Omega_main_sequence_stars_disks_and_irr, Omega_white_dwarfs, Omega_neutron_stars, Omega_black_holes, Omega_substellar_objects, Omega_HI_HeI, Omega_molecular_gas, Omega_planets];
Omega_baryon     = sum(xx);


%%%%%% DO NOT ERASE f_Omega_WHIM     = 0.35; % from dave et al.
yy = xx/Omega_baryon;

f_groups_halos = yy(1);
f_WHIM         = yy(2);
f_clustgas     = yy(3);
f_MSstars      = yy(4)+yy(5);
f_compactobj   = sum(yy(6:8));
f_browndwarf   = yy(9);
f_atommolgas   = yy(10)+yy(11);
f_planets      = yy(12);
f_starsrems    = sum(yy(4:9)); % stars and remnants

%f = [f_planets f_groups_halos f_clustgas f_MSstars f_compactobj f_WHIM f_browndwarf f_atommolgas];

f2 = [f_WHIM f_atommolgas f_groups_halos f_clustgas f_starsrems];

%explode = [1 0 1 0 0];
%h = pie(f2,explode);
h = pie(f2);

colormap jet

title('Present Epoch Baryon Budget','fontsize', 20, 'fontname', 'Times-Roman')

% labeling
textObjs = findobj(h,'Type','text');
oldStr = get(textObjs,{'String'});
val = get(textObjs,{'Extent'});
oldExt = cat(1,val{:});

%Names = {'Stars: ';'Atomic/Mol. Gas: ';'Hot Cluster Gas: ';'Cool Plasma Clouds: ';'Group Plasma: ';'WHIM: '};
Names0 = {''; ''; 'Group Plasma/'; ''; ''};
Names  = {'WHIM: ';'Atomic/Mol. Gas: ';'Galactic Halos: ';'Cluster Gas: ';'Stars and Remnants: '};
newStr = strcat(Names,oldStr);
set(textObjs,{'String'},newStr,'fontsize',16,'fontname','Times-Roman')

val1 = get(textObjs, {'Extent'});
newExt = cat(1, val1{:});
offset = sign(oldExt(:,1)).*(newExt(:,3)-oldExt(:,3))/2;
pos = get(textObjs, {'Position'});
textPos =  cat(1, pos{:});
textPos(:,1) = textPos(:,1)+offset;
set(textObjs,{'Position'},num2cell(textPos,[3,2]))

text(0.9, -0.67, 'Group Plasma/', 'fontname', 'Times-Roman', 'fontsize', 16)

print -depsc piechart
