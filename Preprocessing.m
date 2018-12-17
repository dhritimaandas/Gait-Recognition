path1='C:\Users\DHRITIMAAN DAS\Desktop\New folder (2)\00_1';
path12='C:\Users\DHRITIMAAN DAS\Desktop\New folder (2)\00_3';
dest='C:\Users\DHRITIMAAN DAS\Desktop\New folder (2)\New folder\';
dataset1=dir(fullfile(path1,'*.png'));
dataset2=dir(fullfile(path1,'*.png'));
norm_ht=200;
norm_w=120;
for k=1:26
    img=fullfile(dataset1(k).folder,dataset1(k).name);
    %reading the image
    
    I=imread(img);
    %figure,imshow(I);
    %%Find Largest Blob and Remove Noise
    
    outim = bwlargestblob(I,8);
    %figure,imshow(outim*255);
    %Find "bounding Box" around the largest blob and normalise the image
    
    s=regionprops(outim,'BoundingBox');
    x1=max(1,ceil(s.BoundingBox(1)));
    y1=max(1,ceil(s.BoundingBox(2)));
    x2=min(size(I,2),floor(s.BoundingBox(1)+s.BoundingBox(3)));
    y2=min(size(I,1),floor(s.BoundingBox(2)+s.BoundingBox(4)));
    img_=outim(y1:y2,x1:x2);
    %figure,imshow(img_*255);
    %%resize the image
    
    img_resized=imresize(img_,[norm_ht norm_w]);
    %figure,imshow(img_resized*255);
    %writing the preprocessed image to the desination folder.
    
    imwrite(img_resized*255,strcat(dest,num2str(k),'.png'));
end
img_path='C:\Users\DHRITIMAAN DAS\Desktop\New folder (2)\New folder\';
img1=zeros(200,120,'uint8');

% Calculating the Gait Energy Image for a selcted Gait cycle of any subject
for i=1:26
    img__=imread(strcat(img_path,num2str(i),'.png'));
    %%figure,imshow(img);
    img1=imadd(img1,img__);
end
im=(img1)/28;
imshow(im*200);