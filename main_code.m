%% Main Program
clc;
clear all;
close all;

addpath(genpath('images'))
addpath(genpath('manual1'))



%% pathToFeatures 

file = fullfile(base_path, '\*.jpg');

for i = 1:length(file)
II{i}= imread(fullfile(base_path,file(i).name));

% Image resize
Img=II{i};
Img=imresize(Img,[512 512]);



%RGB 2 gray
I=rgb2gray(Img);

% Adaptive Hist Equalization
GR = adapthisteq(I,'NumTiles',[8 8],'ClipLimit',0.01,'Distribution','uniform');

% Gabor filter
M=15;
N=5;
a=(0.4 / 0.05)^(1/(M-1));
count=1;
[JT1]=gabor(M,N,a,count,GR);

% Feature Extraction
feat=hog_vector(JT1); 

% Energy calculation
E=feat.^2;
Energy=(sum(E(:)))/(512*512);

%features set
features = [mean(feat(:)),var(feat(:)),skewness(feat(:)),kurtosis(feat(:)),entropy(feat(:)),Energy];
FeaturesHog(i,:)=features;



end

%color image
figure;imshow(Img);title('Input retinal color image')

%grey image
figure;imshow(I);title('Input retinal grey image')

% Adaptive Hist Equalization image
figure;imshow(GR);title('Adaptive Hist Equalization')



group={'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';...
        'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';...
        'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy';'Diabetic';'Glaucoma';'Healthy'};

save('FeaturesHog','FeaturesHog');
save('group','group');


% group={'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';'Normal';...
%         'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma';'Glaucoma'};
% save('FeaturesHog','FeaturesHog');
% save('group','group');