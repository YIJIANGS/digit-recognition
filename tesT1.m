clear;clc;close;
%loadMNISTImages returns a 28x28x[number of MNIST images] matrix containing
%the raw MNIST images
filename='train-images.idx3-ubyte';

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2051, ['Bad magic number in ', filename, '']);

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);

fclose(fp);
%%
img_label=loadMNISTLabels('train-labels.idx1-ubyte');
%%
im_label=zeros(10,60000);
indx=img_label'+1+(0:59999)*10;
im_label(indx)=1;
%%
img_data=double(images)/255;
train_set = reshape(img_data, size(images, 1) * size(images, 2), size(images, 3));
%%
load('net.mat')
% for i=55:70
%     imshow(img_data(:,:,i))
%     [~,id]=max(sim(net,train_set(:,i)));
%     title(id-1)
%     pause(.3)
% end
%%
[~,id]=max(sim(net,train_set(:,1:2000)));
C = confusionmat(img_label(1:2000),id-1);
%%
c2=kron(C,ones(100));
%%
for i=1:36
    subplot(6,6,i)
    imshow(img_data(:,:,i))
    [~,id]=max(sim(net,train_set(:,i)));
    title(['predicted:',num2str(id-1)])
end
%%