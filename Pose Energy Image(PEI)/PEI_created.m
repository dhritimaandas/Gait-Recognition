folder='C:\Users\DHRITIMAAN DAS\Desktop\ABCD\';
save_folder='C:\Users\DHRITIMAAN DAS\Desktop\Final_Pose_Energy_Images';
mkdir(save_folder);
list=dir(folder);
pei_1=zeros(200,200);
pei_2=zeros(200,200);
pei_3=zeros(200,200);
pei_4=zeros(200,200);
fName={list.name};
for i=3:30
    file_path=char(strcat(folder,fName(i),'\'));
    list_img=dir(file_path);
    IName={list_img.name};
    for j=3:6
    if j==3
        iname=char(strcat(file_path,IName(j)));
        pei_1=pei_1+double(imread(iname));
    end
    if j==4
        iname=char(strcat(file_path,IName(j)));
        pei_2=pei_2+double(imread(iname));
    end
    if j==5
        iname=char(strcat(file_path,IName(j)));
        pei_3=pei_3+double(imread(iname));
    end
    if j==6
        iname=char(strcat(file_path,IName(j)));
        pei_4=pei_4+double(imread(iname));
    end
    end
end
pei_1=pei_1/(28*255);
pei_2=pei_2/(28*255);
pei_3=pei_3/(28*255);
pei_4=pei_4/(28*255);
figure,imshow(pei_1);
figure,imshow(pei_2);
figure,imshow(pei_3);
figure,imshow(pei_4);
imwrite(pei_1,char(strcat(save_folder,'\pei_1.png')));
imwrite(pei_2,char(strcat(save_folder,'\pei_2.png')));
imwrite(pei_3,char(strcat(save_folder,'\pei_3.png')));
imwrite(pei_4,char(strcat(save_folder,'\pei_4.png')));
    
    
    
