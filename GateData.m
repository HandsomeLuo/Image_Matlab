function GateData(imagepath,segpath,sigpath)

% Ori = imread('100035.jpeg');                  %��ȡԭͼ
% Seg = imread('100035_SLIC.jpg');       %��ȡ�ָ���
% Sig = load('100035.mat');                       %��ȡ��ע��Ϣ 
                                        



% [filename, pathname] = uigetfile( ...
%     {'*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
%     '*.*','All Files' },...
%     '��ѡ��ԭʼͼƬ', ...
%     'MultiSelect', 'on');
% src = strcat(pathname,filename);
% Ori = imread(src);
% 
% [filename1, pathname1] = uigetfile( ...
%     {'*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
%     '*.*','All Files' },...
%     '��ѡ��ָ�ͼƬ', ...
%     'MultiSelect', 'on');
% src = strcat(pathname1,filename1);
% Seg = imread(src);
% 
% [filename2, pathname2] = uigetfile( ...
%     {'*.mat;*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
%     '*.*','All Files' },...
%     '��ѡ���ע��Ϣ', ...
%     'MultiSelect', 'on');
% src = strcat(pathname2,filename2);
% Sig = load(src);

 Images = dir(fullfile(imagepath,'*.jpeg'));
 Segments = dir(fullfile(segpath,'*.jpg'));
 Sign = dir(fullfile(sigpath,'*.mat'));
 
 LengthFiles =length(Images);
  
 for m = 1:LengthFiles;
                  Ori = imread(strcat(imagepath,'\',Images(m).name));
                  Seg = imread(strcat(segpath,'\',Segments(m).name));
                  Sig = load(strcat(sigpath,'\',Sign(m).name));
                  
Seg = im2bw(Seg);                                  %���ָ���ͼת��Ϊ��ֵͼ
Sig1=Sig.A;    
I = Ori;
for k = 1:4
    Sig1=Sig.A; 
    Sig1(find(Sig.A ~= k)) = 0;                       %����ע�����б�ע��Ϊk��������Ϊ0
    %imd = uint8(Sig1);

    Label = setLabel(Seg);                           %�õ����п�����

    S =unique(Label(find(Sig1 == k)));
    
    for i= 1:size(S)
        a = Sig1;
        a(find(Label ~= S(i))) = 0;
        a(find(Label == S(i))) = 1;
        for j = 1:3
            I(:,:,j) = uint8(a).*Ori(:,:,j);  
        end
        imwrite(I,['Data\',mat2str(k),'\',mat2str(i),'_',Images(m).name]);
    end
end
end
 

 
 
% for i = 1:Max
%     [x,y] = find(Label == i);
%     IR(:,:,1) = Sig(find(Label == i),1);
%     IR(:,:,2) = Sig(find(Label == i),2);
%     IR(:,:,3) = Sig(find(Label == i),3);
% end

% for i = 1:3   
%     I(:,:,i) = imd.*Ori(:,:,i);                              %��ȡͼ���б�עΪ1�Ŀ�����
% end
% I = uint8(I);
% 
% 
% BWI = im2bw(I);
% [L,num] = bwlabel(BWI);
% STATS = regionprops(BWI);
% 
% Ar = cat(1, STATS.Area);
% ind = find(Ar ==max(Ar));                             %�ҵ������ͨ����ı��
% BWI(find(L~=ind))=0;                                   %������������Ϊ0
% BWII = uint8(BWI);
% 
% for i = 1:3   
%     I(:,:,i) = BWII.*Ori(:,:,i);                              %��ȡͼ���б�עΪ1�Ŀ�����
% end
% 
% I = uint8(I);
% colorhist(I);


%%%%%%%�˶δ��������RGBֵΪ0����ֵ��ȡֵΪ���㴦���ص�ֵ��ƽ��ֵ%%%%%%%%%%%%%%%%
% BW =im2bw(I);
% 
% [x,y] = find(BW ~= 0);
% Rave = 0;
% Gave = 0;
% Bave = 0;
% 
% Idouble = double(I);
% 
% for i = 1:size(x,1)
%         Rave = Idouble(x(i),y(i),1)+Rave;
%         Gave = Idouble(x(i),y(i),2)+Gave;
%         Bave = Idouble(x(i),y(i),3)+Bave;
% end
% 
% Rave = uint8(Rave/size(x,1));
% Gave = uint8(Gave/size(x,1));
% Bave = uint8(Bave/size(x,1));
% 
% 
% [x1,y1] = find(BW == 0);
% for i = 1:size(x1,1)                                                                                                                  
%         I(x1(i),y1(i),1) = Rave;
%         I(x1(i),y1(i),2) = Gave;
%         I(x1(i),y1(i),3) = Bave;
%     
% end



% imshow(I);
% imwrite(I,'result.jpg');