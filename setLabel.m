function Label=setLabel(segImage)
% number each region



imBW=im2bw(segImage);                          %
imBW = ~imBW;
Label=bwlabel(imBW);                            %  联通区域类别标签       
[H,W]=size(Label);                             % 
while 1                                        % 
    Label=fillAllZero(Label,H,W);
    if isempty(find(Label==0))==1;              %把0填成类别号
        break;
    end
end