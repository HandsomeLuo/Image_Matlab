function Label=setLabel(segImage)
% number each region



imBW=im2bw(segImage);                          %
imBW = ~imBW;
Label=bwlabel(imBW);                            %  ��ͨ��������ǩ       
[H,W]=size(Label);                             % 
while 1                                        % 
    Label=fillAllZero(Label,H,W);
    if isempty(find(Label==0))==1;              %��0�������
        break;
    end
end