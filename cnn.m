function [net] = cnn()

TrainsetC = load('trainsetMat\Train_colorhist.mat');
% TestsetC = load('Test_colorhist.mat');

TrainsetT = load('trainsetMat\Train_texture.mat');
% TestsetT = load('Test_texture.mat');

train1 = cat(2,TrainsetC.color1,TrainsetT.texture1);
train2 = cat(2,TrainsetC.color2,TrainsetT.texture2);
train3 = cat(2,TrainsetC.color3,TrainsetT.texture3);
train4 = cat(2,TrainsetC.color4,TrainsetT.texture4);
trainset = cat(1,train1,train2,train3,train4);
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
 
%  ����һ���µ�ǰ�������� 
%net=newff(minmax(P),[10,1],{'tansig','purelin'},'traingdm');
%net=newff(P,T,14,{'tansig','purelin'},'trainlm');
net=newff(P,T,14);
%  ��ǰ�����Ȩֵ����ֵ 
inputWeights=net.IW{1,1}; 
inputbias=net.b{1}; 
%  ��ǰ�����Ȩֵ����ֵ 
layerWeights=net.LW{2,1}; 
layerbias=net.b{2}; 
 
%  ����ѵ������ 
net.trainParam.show = 50; 
net.trainParam.lr = 0.0005; 
net.trainParam.mc = 0.9; 
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-3; 
 

%  ���� TRAINGDM �㷨ѵ�� BP ���� 
[net,tr]=train(net,P,T); 
 
%p =testset';
%  �� BP ������з��� 
%A = sim(net,p); %�����
%  ���������� 
 % E = T - A; 
 %MSE=mse(E);