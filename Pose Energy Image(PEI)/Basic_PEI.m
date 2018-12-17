path='C:\Users\DHRITIMAAN DAS\Desktop\Dataset Final\Manual Selection\';
list=dir(path);
img=[];
fName={list.name};
p=1;
save_folder = 'C:\Users\DHRITIMAAN DAS\Desktop\ABCD\';
for i=3:length(fName)
    path1=char(strcat(path,fName(i),'\'));
    list1=dir(path1);
    fName1={list1.name};
    path2=char(strcat(path1,fName1(3),'\'));
    list3=dir(path2);
    fName2={list3.name};
    save_folder_= char(strcat('C:\Users\DHRITIMAAN DAS\Desktop\ABCD\',num2str(p)));
           mkdir(save_folder_);
           p=p+1;
           save_folder__=char(strcat(save_folder_,'\'));
        for J=3:6
        path3=char(strcat(path2,fName2(J),'\'));
        listf=dir(path3);
        IName={listf.name};
        x=double(zeros(200,200));
            for k=3:length(IName)
                fpath=char(strcat(path3,IName(k)));
                I=double(imread(fpath));
                %figure,imshow(I);
                x=x+I;
            end
           x=x/((length(IName)-3)*255);
           %figure,imshow(x);
           imwrite(x,char(strcat(save_folder__,num2str(J),'.png')));
        end
end