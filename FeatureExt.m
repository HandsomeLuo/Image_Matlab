function FeatureExt(n,Ori_test)
if n == 0
%%%%%%%%%%%%%%%%%%训练样本特征提取%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%训练样本特征提取%%%%%%%%%%%%%%%%%%%%%%%%%%


%------------------PCA降维处理---------------------------%    
    color = cat(1,color1,color2,color3,color4);
    texture = cat(1,texture1,texture2,texture3,texture4);
    
    [COEFF,SCORE,latent] = pca(color);        %对颜色特征降维
    x = cumsum(latent)./sum(latent);
    y = find(x>0.9);
    n = y(1);
    Pcolor = SCORE(:,1:n);
    
    trainset = cat(2,Pcolor,texture);
    %trainset = cat(1,TrainsetC.water_color,TrainsetC.bear_color,TrainsetC.grass_color,TrainsetC.land_color);

    % water_test = cat(2,TestsetC.water_color,TestsetT.water_texture);
    % bear_test = cat(2,TestsetC.bear_color,TestsetT.bear_texture);
    % grass_test = cat(2,TestsetC.grass_color,TestsetT.grass_texture);
    % land_test = cat(2,TestsetC.land_color,TestsetT.land_texture);
    % testset = cat(1,water_test,bear_test,grass_test,land_test);
    % %testset = cat(1,TestsetC.water_color,TestsetC.bear_color,TestsetC.grass_color,TestsetC.land_color);

    %P=mapminmax(trainset');%初始训练值
    P = trainset';
    % T 为目标矢量 
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


    %%%%%%%%%%%%%%%%%%%%%%%%测试样本特征提取%%%%%%%%%%%%%%%%%%%%%%%%%%
if n ==1
    
    color_test= colorhist(Ori_test);
    texture_test= statxture(Ori_test);
    
     [COEFF,SCORE,latent] = pca(color);        %对颜色特征降维
    x = cumsum(latent)./sum(latent);
    y = find(x>0.9);
    n = y(1);
    Pcolor = SCORE(:,1:n);
    
    trainset = cat(2,Pcolor,texture_test);
    P = trainset';
    save('testMat\P.mat','P');
%save('testsetMat\Test_colorhist.mat','water_color','bear_color','grass_color','land_color');
%save('testsetMat\Test_texture.mat','water_texture','bear_texture','grass_texture','land_texture');
%%%%%%%%%%%%%%%%%%%%%%%测试样本特征提取%%%%%%%%%%%%%%%%%%%%%%%%%%


end    