%% Paths (RS)
fieldtripDir    = '/Users/rs_mac_air/Documents/scripts/fieldtrip-20191213';

% Add Fieldtrip to path
disp('Adding Fieldtrip to your MATLAB path');
addpath(fieldtripDir)
ft_defaults;

%%

cd('/Users/rs_mac_air/Documents/GitHub/MQ_MEG_parcel/hcp_mmp1');

atlas_nii = ft_read_atlas('MMP_in_MNI_corr.nii');

cfg                 = [];
cfg.funparameter    = 'parcellation';
ft_sourceplot(cfg,atlas_nii);


load('standard_sourcemodel3d5mm.mat');

% and call ft_sourceinterpolate:
cfg                 = [];
cfg.interpmethod    = 'nearest';
cfg.parameter       = 'parcellation';
sourcemodel2        = ft_sourceinterpolate(cfg, atlas_nii, gii);

b = [1 181];

c = ismember(sourcemodel2.parcellation, b)
% Extract the elements of a at those indexes.
indx = find(c);


%gii = ft_read_headshape('cortex_20484.surf.gii');

%figure; ft_plot_mesh(gii);


figure;
ft_plot_mesh(gii.pos,'vertexsize',1);
hold on;
ft_plot_mesh(gii.pos(indx,:),'vertexsize',20,'vertexcolor','r');

mri = ft_read_mri('single_subj_T1.nii');

ft_determine_coordsys(mri,'interactive','no'); hold on;
ft_plot_mesh(gii,'vertexsize',1,'facealpha',0.4);
hold on;
ft_plot_mesh(gii.pos(indx,:),'vertexsize',20,'vertexcolor','r');
camlight;


y = unique(sourcemodel2.parcellation(:));










