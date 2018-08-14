
global nmat click 
nmat=zeros(40);
click=0;

rectangle('Position',[0 0 40 40])
hold on
set (gcf, 'WindowButtonDownFcn', @mouseClick);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
set (gcf, 'WindowButtonUpFcn', @mouseRelease);




function mouseClick (~,~)
global nmat click
C = get (gca, 'CurrentPoint');
m=floor(C(1,1));
n=floor(C(1,2));
nmat(m,n)=1;
plot(m,n,'.','color',[0 0 0],'markerSize',30)
click=1;
end

function mouseMove (~,~)
global nmat click
if click==1
    C = get (gca, 'CurrentPoint');
    m=floor(C(1,1));
    n=floor(C(1,2));
    nmat(m,n)=1;
    plot(m,n,'.','color',[0 0 0],'markerSize',30)
end
end

function mouseRelease (~,~)
global click nmat
click=0;
load('net.mat')
% [row,col]=find(nmat);
% minr=min(row); maxr=max(row); minc=min(col); maxc=max(col);
% n2=nmat(minr:maxr,minc:maxc);
% n3=zeros(size(n2)+10);
% size(n2)
% size(n3)
% n3(6:end-5,6:end-5)=n2;
num=imresize(nmat,[28,28]);
num(num<0)=0;
% PS.ymin=0;
% num=mapminmax(num,PS);
num=flipud(num');
figure
[m,n]=find(num);
digit=num(min(m):max(m),min(n):max(n));
% ratio=(max(m)-min(m))/(max(n)-min(n));
input=imresize(digit,[28,28]);
imshow(input)
assignin('base','input',input)
input=reshape(input,28*28,1);
PS.ymin=0;
input=mapminmax(input,PS);
% input
[~,id]=max(sim(net,input));
title(['predicted number: ',num2str(id-1)])
end