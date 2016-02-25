function FeatureExt(n)
if n == 0
%%%%%%%%%%%%%%%%%%ѵ������������ȡ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Images = dir(fullfile('Data\1\','*.jpeg'));

LengthFiles =length(Images);
  
 for i = 1:LengthFiles;
     
    Ori = imread(strcat('Data\1\',Images(i).name));
    I = Ori;
    color1(i,:) = colorhist(I);
    texture1(i,:) = statxture(I);
 end

 Images = dir(fullfile('Data\2\','*.jpeg'));

LengthFiles =length(Images);
  
 for i = 1:LengthFiles;
     
    Ori = imread(strcat('Data\2\',Images(i).name));
    I = Ori;
    color2(i,:) = colorhist(I);
    texture2(i,:) = statxture(I);
 end
 
 Images = dir(fullfile('Data\3\','*.jpeg'));

LengthFiles =length(Images);
  
 for i = 1:LengthFiles;
     
    Ori = imread(strcat('Data\3\',Images(i).name));
    I = Ori;
    color3(i,:) = colorhist(I);
    texture3(i,:) = statxture(I);
 end
 
 Images = dir(fullfile('Data\4\','*.jpeg'));

LengthFiles =length(Images);
  
 for i = 1:LengthFiles;
     
    Ori = imread(strcat('Data\4\',Images(i).name));
    I = Ori;
    color4(i,:) = colorhist(I);
    texture4(i,:) = statxture(I);
 end
 
save('trainsetMat\Train_colorhist.mat','color1','color2','color3','color4');
save('trainsetMat\Train_texture.mat','texture1','texture2','texture3','texture4');
%%%%%%%%%%%%%%%%%%%%%%%%ѵ������������ȡ%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%��������������ȡ%%%%%%%%%%%%%%%%%%%%%%%%%%
% Images = dir(fullfile('E:\Matlab projects\FeatureExtraction\grass_testset\','*.jpeg'));
% 
% LengthFiles =length(Images);
%   
%  for i = 1:LengthFiles;
%      
%     Ori = imread(strcat('E:\Matlab projects\FeatureExtraction\grass_testset\',Images(i).name));
%     I = Ori;
%     %grass_color(i,:) = colorhist(I);
%     grass_texture(i,:) = statxture(I);
%  end
% 
%  Images = dir(fullfile('E:\Matlab projects\FeatureExtraction\water_testset\','*.jpeg'));
% 
% LengthFiles =length(Images);
%   
%  for i = 1:LengthFiles;
%      
%     Ori = imread(strcat('E:\Matlab projects\FeatureExtraction\water_testset\',Images(i).name));
%     I = Ori;
%     %water_color(i,:) = colorhist(I);
%     water_texture(i,:) = statxture(I);
%  end
%  
%  Images = dir(fullfile('E:\Matlab projects\FeatureExtraction\land_testset\','*.jpeg'));
% 
% LengthFiles =length(Images);
%   
%  for i = 1:LengthFiles;
%      
%     Ori = imread(strcat('E:\Matlab projects\FeatureExtraction\land_testset\',Images(i).name));
%     I = Ori;
%     %land_color(i,:) = colorhist(I);
%     land_texture(i,:) = statxture(I);
%  end
%  
%  Images = dir(fullfile('E:\Matlab projects\FeatureExtraction\bear_testset\','*.jpeg'));
% 
% LengthFiles =length(Images);
%   
%  for i = 1:LengthFiles;
%      
%     Ori = imread(strcat('E:\Matlab projects\FeatureExtraction\bear_testset\',Images(i).name));
%     I = Ori;
%     %bear_color(i,:) = colorhist(I);
%     bear_texture(i,:) = statxture(I);
%  end
%  
% %save('testsetMat\Test_colorhist.mat','water_color','bear_color','grass_color','land_color');
% save('testsetMat\Test_texture.mat','water_texture','bear_texture','grass_texture','land_texture');
%%%%%%%%%%%%%%%%%%%%%%%%��������������ȡ%%%%%%%%%%%%%%%%%%%%%%%%%%

%     train1 = cat(2,Pcolor1,texture1);
%     train2 = cat(2,Pcolor2,texture2);
%     train3 = cat(2,Pcolor3,texture3);
%     train4 = cat(2,Pcolor4,texture4);
%     trainset = cat(1,train1,train2,train3,train4);
%------------------PCA��ά����---------------------------%    
    color = cat(1,color1,color2,color3,color4);
    
    [COEFF,SCORE,latent] = pca(color);        %����ɫ������ά
    x = cumsum(latent)./sum(latent);
    y = find(x>0.9);
    n = y(1);
    Pcolor = SCORE(:,1:n);
    
    texture = cat(1,texture1,texture2,texture3,texture4);
    trainset = cat(2,Pcolor,texture);
    %trainset = cat(1,TrainsetC.water_color,TrainsetC.bear_color,TrainsetC.grass_color,TrainsetC.land_color);

    % water_test = cat(2,TestsetC.water_color,TestsetT.water_texture);
    % bear_test = cat(2,TestsetC.bear_color,TestsetT.bear_texture);
    % grass_test = cat(2,TestsetC.grass_color,TestsetT.grass_texture);
    % land_test = cat(2,TestsetC.land_color,TestsetT.land_texture);
    % testset = cat(1,water_test,bear_test,grass_test,land_test);
    % %testset = cat(1,TestsetC.water_color,TestsetC.bear_color,TestsetC.grass_color,TestsetC.land_color);

    %P=mapminmax(trainset');%��ʼѵ��ֵ
    P = trainset';
    % T ΪĿ��ʸ�� 
    %T1=ones(1,size(water_train,1)); 
    T1 = repmat([0,0],size(train1,1),1);
    %T2=2*ones(1,size(bear_train,1));
    T2 = repmat([0,1],size(train2,1),1);
    %T3=3*ones(1,size(grass_train,1));
    T3 = repmat([1,0],size(train3,1),1);
    %T4=4*ones(1,size(land_train,1));
    T4 = repmat([1,1],size(train4,1),1);
    T = cat(1,T1,T2,T3,T4)';
    save('trainsetMat\P.mat','P');
    save('trainsetMat\T.mat','T');
end


%%%%%%%%%%%%%%%%%%��������������ȡ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n ==1
    
end    