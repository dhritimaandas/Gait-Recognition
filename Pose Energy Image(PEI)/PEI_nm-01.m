path='C:\Users\DHRITIMAAN DAS\Desktop\Dataset Final\Casia_B_Croped_Image\';
list=dir(path);
fName={list.name};
%reading all the PEI created

pei_1=imread('C:\Users\DHRITIMAAN DAS\Desktop\Final_Pose_Energy_Images\pei_1.png');
pei_2=imread('C:\Users\DHRITIMAAN DAS\Desktop\Final_Pose_Energy_Images\pei_2.png');
pei_3=imread('C:\Users\DHRITIMAAN DAS\Desktop\Final_Pose_Energy_Images\pei_3.png');
pei_4=imread('C:\Users\DHRITIMAAN DAS\Desktop\Final_Pose_Energy_Images\pei_4.png');
a=1;
L=1;

for i=3:length(fName)
    c=0;
    e=0;
    f=0;
    J=0;
    img_pei1=double(zeros(200,200));
    img_pei2=double(zeros(200,200));
    img_pei3=double(zeros(200,200));
    img_pei4=double(zeros(200,200));
    w=[];
weights=[];
    list1=dir(char(strcat(path,fName(i),'\')));
    fName1={list1.name};
    ilist=dir(char(strcat(path,fName(i),'\',fName1(7),'\')));
    iname={ilist.name};
    for j=3:length(iname)
        %image path
        ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(j)));
         I=double(imread(ipath));
         %figure,imshow(I);
         %FINDING CORRELATION BETWEEN PEI-1 adn all images of th subject for Weights of the graph.
         c=corr2(pei_1,I);
         w=[w,c];
    end
    for j=3:length(iname)
        ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(j)));
         I=double(imread(ipath));
         %figure,imshow(I);
         %FINDING CORRELATION BETWEEN PEI-2 adn all images of th subject.
         c=corr2(pei_2,I);
         w=[w,c];
    end
    for j=3:length(iname)
        ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(j)));
         I=double(imread(ipath));
         %figure,imshow(I);
         %FINDING CORRELATION BETWEEN PEI-3 adn all images of th subject.
         c=corr2(pei_3,I);
         w=[w,c];
    end
    for j=3:length(iname)
        ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(j)));
         I=double(imread(ipath));
         %figure,imshow(I);
         %FINDING CORRELATION BETWEEN PEI-4 adn all images of th subject.
         c=corr2(pei_4,I);
         w=[w,c];
    end
    s=[];
    t=[];
    p=0;
    q=length(iname)-2;
    l=length(iname)-2;
    %Creating the Graph
    for k=1:(4*(length(iname)-2))
             if mod(k,length(iname)-2)~=0
                s=[s,k,k];
                if k<3*(length(iname)-2)
                    t=[t,k+1,k+(length(iname)-2)+1];
                else
                    t=[t,k+1,k-3*(length(iname)-2)+1];
                end
             end
    end
    for m=1:4
        s=[s,4*(length(iname)-2)+1];
        t=[t,1+p];
        p=p+(length(iname)-2);
    end
    %adding weights to the graph
    for h=1:length(t)
        k=t(h);
        weights=[weights,1-w(k)];
    end
    for l=1:4
            s=[s,q];
            t=[t,4*(length(iname)-2)+2];
            q=(length(iname)-2)+q;
    end
    weights=[weights,0.6,0.6,0.6,0.6];
    G=digraph(s,t,weights);
    %plot(G,'EdgeLabel',G.Edges.Weight);
    %Using Dikstras Shortest Path Algorithm to classify the registered
    %frames to the corresponding PEIs
   [P,d]=shortestpath(G,4*(length(iname)-2)+1,4*(length(iname)-2)+2);
   u=0;
   %Finally Averaging all the Frames mapped to same PEI.
        for g=1:length(P)
            if P(g)<=length(iname)-2
                ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(P(g)+2)));
                img=double(imread(ipath));
                img_pei1=img_pei1+img;
                c=c+1;
            end
            if P(g)>length(iname)-2 && P(g)<=2*(length(iname)-2)
                ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(P(g)-(length(iname)-2)+2)));
                img=double(imread(ipath));
                img_pei2=img_pei2+img;
                u=u+1;
            end
            if P(g)>2*(length(iname)-2) && P(g)<=3*(length(iname)-2)
                ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(P(g)-2*(length(iname)-2)+2)));
                img=double(imread(ipath));
                img_pei3=img_pei3+img;
                e=e+1;
            end
            if P(g)>3*(length(iname)-2) && P(g)<=4*(length(iname)-2)
                ipath=char(strcat(path,fName(i),'\',fName1(7),'\',iname(P(g)-3*(length(iname)-2)+2)));
                img=double(imread(ipath));
                img_pei4=img_pei4+img;
                f=f+1;
            end
        end
   img_pei1=img_pei1/(255*c);
   img_pei2=img_pei2/(255*u);
   img_pei3=img_pei3/(255*e);
   img_pei4=img_pei4/(255*f);
   
%    figure,imshow(img_pei1/(255*c));
%    figure,imshow(img_pei2/(255*u));
%    figure,imshow(img_pei3/(255*e));
%    figure,imshow(img_pei4/(255*f));
    save_folder_= char(strcat('C:\Users\DHRITIMAAN DAS\Desktop\Mapped_PEI\',num2str(L),'\'));
    mkdir(save_folder_);
        L=L+1;
        imwrite(img_pei1,char(strcat(save_folder_,num2str(J),'.png')));
        J=J+1;
        imwrite(img_pei2,char(strcat(save_folder_,num2str(J),'.png')));
        J=J+1;
        imwrite(img_pei3,char(strcat(save_folder_,num2str(J),'.png')));
        J=J+1;
        imwrite(img_pei4,char(strcat(save_folder_,num2str(J),'.png')));
end