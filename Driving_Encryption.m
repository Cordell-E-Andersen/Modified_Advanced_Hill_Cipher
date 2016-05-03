%Authors: Cordell Andersen and Erica Wiens
%Sources: --- MATLAB documentation and website; Advanced Hill Cipher paper --- 
%Dates: February 23, 2016 - April 22, 2016
clear;clc;clf;

%Pictures that are on file for encryption-decryption sequence
%Car_Incription_MK_I.bmp            %DismissSoundSubClass.jpg   
%Hospitaller.jpg                    %catcryption.jpg  
%NoLightSubClass.jpg                %ConfrontationSubClass.jpg
                        %Sullivan.png
%https://www.pexels.com/photo/black-and-white-nature-flowers-close-up-view-57905/
%All images are from Google Images. All rights belong to their respective
%owners.

%Imports image
Im = imread('Sullivan.png');

%Creates RGB matrices for the image
[ImageMat,map] = imread('Sullivan.png');
ImageMat=im2double(ImageMat);

%Shows the original image
imshow(ImageMat)
figure;

%Allows for access to data 
Data=imfinfo('Sullivan.png');

%Generating Key Matrices for R-G-B levels
RKeyrypt = KeyMatrx1();
GKeyrypt = KeyMatrx1();
BKeyrypt = KeyMatrx1();


%Creating shifts to allow us to iterate through the whole image
XSHIFT = ceil((Data.Height)/4);
YSHIFT = ceil((Data.Width)/4);

XREM = rem(Data.Height,4);
YREM = rem(Data.Width,4);

XEXPAND=0;
YEXPAND=0;

%Determining if "black noise" needs to be added to expand the image to workable proportions 
if XREM ~= 0
    XEXPAND = 4-XREM;
end

if YREM ~= 0
    YEXPAND = 4-YREM;
end

%Reorganizing image to be compatible with our Key Matrix
newImageMat=zeros(Data.Height+XEXPAND,Data.Width+YEXPAND,3);
for z=1:1:3
    for n = 1:1:Data.Height
        for m = 1:1:Data.Width
            
            newImageMat(n,m,z)=ImageMat(n,m,z);
            
        end
    end
end
ImageMat=newImageMat;

%Encrypt the Red level
Rcryption = cell(4,4);
for n = 1:1:XSHIFT
    for m=1:1:YSHIFT  
        
        RValTemp = [ImageMat(n,m,1),             ImageMat(n+XSHIFT,m,1),              ImageMat(n+2*XSHIFT,m,1),                ImageMat(n+3*XSHIFT,m,1);
                                                                                                                                                         
                   ImageMat(n,m+YSHIFT,1),      ImageMat(n+XSHIFT,m+YSHIFT,1),       ImageMat(n+2*XSHIFT,m+YSHIFT,1),         ImageMat(n+3*XSHIFT,m+YSHIFT,1);
                         
                   ImageMat(n,m+2*YSHIFT,1),    ImageMat(n+XSHIFT,m+2*YSHIFT,1),     ImageMat(n+2*XSHIFT,m+2*YSHIFT,1),       ImageMat(n+3*XSHIFT,m+2*YSHIFT,1);
                                                                          
                   ImageMat(n,m+3*YSHIFT,1),    ImageMat(n+XSHIFT,m+3*YSHIFT,1),     ImageMat(n+2*XSHIFT,m+3*YSHIFT,1),       ImageMat(n+3*XSHIFT,m+3*YSHIFT,1);];

              Rcrypt1 = RKeyrypt.*RValTemp;
              Rcrypt2 = transpose(Rcrypt1);
              RcryptFinal = RKeyrypt.*Rcrypt2;
              Rcryption{n,m} = RcryptFinal;

    end
end
ImageMat(:,:,1)=cell2mat(Rcryption);

%Encrypt the Green level
Gcryption = cell(4,4);
for n = 1:1:XSHIFT
    for m=1:1:YSHIFT
        
        GValTemp = [ImageMat(n,m,2),             ImageMat(n+XSHIFT,m,2),              ImageMat(n+2*XSHIFT,m,2),                ImageMat(n+3*XSHIFT,m,2);
     
                   ImageMat(n,m+YSHIFT,2),      ImageMat(n+XSHIFT,m+YSHIFT,2),       ImageMat(n+2*XSHIFT,m+YSHIFT,2),         ImageMat(n+3*XSHIFT,m+YSHIFT,2);
     
                   ImageMat(n,m+2*YSHIFT,2),    ImageMat(n+XSHIFT,m+2*YSHIFT,2),     ImageMat(n+2*XSHIFT,m+2*YSHIFT,2),       ImageMat(n+3*XSHIFT,m+2*YSHIFT,2);
            
                   ImageMat(n,m+3*YSHIFT,2),    ImageMat(n+XSHIFT,m+3*YSHIFT,2),     ImageMat(n+2*XSHIFT,m+3*YSHIFT,2),       ImageMat(n+3*XSHIFT,m+3*YSHIFT,2);];
               
              Gcrypt1 = GKeyrypt.*GValTemp; 
              Gcrypt2 = transpose(Gcrypt1);
              GcryptFinal = GKeyrypt.*Gcrypt2;
              Gcryption{n,m} = GcryptFinal;
               
    end
end
ImageMat(:,:,2)=cell2mat(Gcryption);

%Encrypt the Blue level
Bcryption = cell(4,4);
for n = 1:1:XSHIFT
    for m=1:1:YSHIFT
        
        BValTemp = [ImageMat(n,m,3),             ImageMat(n+XSHIFT,m,3),              ImageMat(n+2*XSHIFT,m,3),                ImageMat(n+3*XSHIFT,m,3);
     
                   ImageMat(n,m+YSHIFT,3),      ImageMat(n+XSHIFT,m+YSHIFT,3),       ImageMat(n+2*XSHIFT,m+YSHIFT,3),         ImageMat(n+3*XSHIFT,m+YSHIFT,3);
     
                   ImageMat(n,m+2*YSHIFT,3),    ImageMat(n+XSHIFT,m+2*YSHIFT,3),     ImageMat(n+2*XSHIFT,m+2*YSHIFT,3),       ImageMat(n+3*XSHIFT,m+2*YSHIFT,3);
            
                   ImageMat(n,m+3*YSHIFT,3),    ImageMat(n+XSHIFT,m+3*YSHIFT,3),     ImageMat(n+2*XSHIFT,m+3*YSHIFT,3),       ImageMat(n+3*XSHIFT,m+3*YSHIFT,3);];
               
       
              Bcrypt1 = BKeyrypt.*BValTemp; 
              Bcrypt2 = transpose(Bcrypt1);
              BcryptFinal = BKeyrypt.*Bcrypt2;
              Bcryption{n,m} = BcryptFinal;
              
    end
end
ImageMat(:,:,3)=cell2mat(Bcryption);

%Shows encrpyted image per R-G-B level before displaying the end result
%%label 'Red Level'
imshow(ImageMat(:,:,1))
figure;
%label 'Green Level'
imshow(ImageMat(:,:,2))
figure;
%lable 'Blue Level'
imshow(ImageMat(:,:,3))
figure;
%label 'Composite Level'
imshow(ImageMat)
figure;

%Now, the program will decrypt the image

%This variable allows for correction where R-G-B values exceed 1
LightCorr = 0.653;%256;%

%Decrypting the Blue level
Bdecryption = cell(XSHIFT,YSHIFT);
BXStart=1;
BXEnd=4;

for i=1:1:XSHIFT
    BYStart=1;
    BYEnd=4;
    for j=1:1:YSHIFT
        Bdecryption{i,j}=ImageMat(BXStart:BXEnd,BYStart:BYEnd,3);
        BYStart=BYStart+4;
        BYEnd=BYEnd+4;
    end
    BXStart=BXStart+4;
    BXEnd=BXEnd+4;
end

BRestore=zeros(Data.Height,Data.Width);

for Bhomeposx=1:1:XSHIFT
    for Bhomeposy=1:1:YSHIFT
        
        BtempRestore=Bdecryption{Bhomeposx,Bhomeposy};
        Bdecrypyt2 = BtempRestore.*inv(BKeyrypt);
        Bdecrypt3 = transpose(Bdecrypyt2);
        BValDecrypt = Bdecrypt3.*inv(BKeyrypt);
        
        BRestore(Bhomeposx,Bhomeposy) = BValDecrypt(1,1);
        BRestore(Bhomeposx+XSHIFT,Bhomeposy) = BValDecrypt(1,2);
        BRestore(Bhomeposx+2*XSHIFT,Bhomeposy) = (LightCorr/256)*BValDecrypt(1,3);
        BRestore(Bhomeposx+3*XSHIFT,Bhomeposy) = BValDecrypt(1,4);

        BRestore(Bhomeposx,Bhomeposy+YSHIFT) = BValDecrypt(2,1);
        BRestore(Bhomeposx+XSHIFT,Bhomeposy+YSHIFT) = BValDecrypt(2,2);
        BRestore(Bhomeposx+2*XSHIFT,Bhomeposy+YSHIFT) = BValDecrypt(2,3);
        BRestore(Bhomeposx+3*XSHIFT,Bhomeposy+YSHIFT) = (LightCorr/256)*BValDecrypt(2,4);

        BRestore(Bhomeposx,Bhomeposy+2*YSHIFT) = (LightCorr/256)*BValDecrypt(3,1);
        BRestore(Bhomeposx+XSHIFT,Bhomeposy+2*YSHIFT) = BValDecrypt(3,2);
        BRestore(Bhomeposx+2*XSHIFT,Bhomeposy+2*YSHIFT) = BValDecrypt(3,3);
        BRestore(Bhomeposx+3*XSHIFT,Bhomeposy+2*YSHIFT) = BValDecrypt(3,4);

        BRestore(Bhomeposx,Bhomeposy+3*YSHIFT) = BValDecrypt(4,1);
        BRestore(Bhomeposx+XSHIFT,Bhomeposy+3*YSHIFT) = (LightCorr/256)*BValDecrypt(4,2);
        BRestore(Bhomeposx+2*XSHIFT,Bhomeposy+3*YSHIFT) = BValDecrypt(4,3);
        BRestore(Bhomeposx+3*XSHIFT,Bhomeposy+3*YSHIFT) = BValDecrypt(4,4);
        
    end
end
ImageMat(:,:,3)=BRestore;

%Decrypting the Green level
Gdecryption = cell(XSHIFT,YSHIFT);
GXStart=1;
GXEnd=4;

for i=1:1:XSHIFT
    GYStart=1;
    GYEnd=4;
    for j=1:1:YSHIFT
        Gdecryption{i,j}=ImageMat(GXStart:GXEnd,GYStart:GYEnd,2);
        GYStart=GYStart+4;
        GYEnd=GYEnd+4;
    end
    GXStart=GXStart+4;
    GXEnd=GXEnd+4;
end

GRestore=zeros(Data.Height,Data.Width);

for Ghomeposx=1:1:XSHIFT
    for Ghomeposy=1:1:YSHIFT
        
        GtempRestore=Gdecryption{Ghomeposx,Ghomeposy};
        Gdecrypyt2 = GtempRestore.*inv(GKeyrypt);
        Gdecrypt3 = transpose(Gdecrypyt2);
        GValDecrypt = Gdecrypt3.*inv(GKeyrypt);
        
        GRestore(Ghomeposx,Ghomeposy) = GValDecrypt(1,1);
        GRestore(Ghomeposx+XSHIFT,Ghomeposy) = GValDecrypt(1,2);
        GRestore(Ghomeposx+2*XSHIFT,Ghomeposy) = (LightCorr/256)*GValDecrypt(1,3);
        GRestore(Ghomeposx+3*XSHIFT,Ghomeposy) = GValDecrypt(1,4);

        GRestore(Ghomeposx,Ghomeposy+YSHIFT) = GValDecrypt(2,1);
        GRestore(Ghomeposx+XSHIFT,Ghomeposy+YSHIFT) = GValDecrypt(2,2);
        GRestore(Ghomeposx+2*XSHIFT,Ghomeposy+YSHIFT) = GValDecrypt(2,3);
        GRestore(Ghomeposx+3*XSHIFT,Ghomeposy+YSHIFT) = (LightCorr/256)*GValDecrypt(2,4);

        GRestore(Ghomeposx,Ghomeposy+2*YSHIFT) = (LightCorr/256)*GValDecrypt(3,1);
        GRestore(Ghomeposx+XSHIFT,Ghomeposy+2*YSHIFT) = GValDecrypt(3,2);
        GRestore(Ghomeposx+2*XSHIFT,Ghomeposy+2*YSHIFT) = GValDecrypt(3,3);
        GRestore(Ghomeposx+3*XSHIFT,Ghomeposy+2*YSHIFT) = GValDecrypt(3,4);

        GRestore(Ghomeposx,Ghomeposy+3*YSHIFT) = GValDecrypt(4,1);
        GRestore(Ghomeposx+XSHIFT,Ghomeposy+3*YSHIFT) = (LightCorr/256)*GValDecrypt(4,2);
        GRestore(Ghomeposx+2*XSHIFT,Ghomeposy+3*YSHIFT) = GValDecrypt(4,3);
        GRestore(Ghomeposx+3*XSHIFT,Ghomeposy+3*YSHIFT) = GValDecrypt(4,4);
        
    end
end
ImageMat(:,:,2)=GRestore;

%Decrypting the Red level
Rdecryption = cell(XSHIFT,YSHIFT);
RXStart=1;
RXEnd=4;

for i=1:1:XSHIFT
    RYStart=1;
    RYEnd=4;
    for j=1:1:YSHIFT
        Rdecryption{i,j}=ImageMat(RXStart:RXEnd,RYStart:RYEnd,1);
        RYStart=RYStart+4;
        RYEnd=RYEnd+4;
    end
    RXStart=RXStart+4;
    RXEnd=RXEnd+4;
end

RRestore=zeros(Data.Height,Data.Width);

for Rhomeposx=1:1:XSHIFT
    for Rhomeposy=1:1:YSHIFT
        
        RtempRestore=Rdecryption{Rhomeposx,Rhomeposy};
        Rdecrypyt2 = RtempRestore.*inv(RKeyrypt);
        Rdecrypt3 = transpose(Rdecrypyt2);
        RValDecrypt = Rdecrypt3.*inv(RKeyrypt);
        
        RRestore(Rhomeposx,Rhomeposy) = RValDecrypt(1,1);
        RRestore(Rhomeposx+XSHIFT,Rhomeposy) = RValDecrypt(1,2);
        RRestore(Rhomeposx+2*XSHIFT,Rhomeposy) = (LightCorr/256)*RValDecrypt(1,3);
        RRestore(Rhomeposx+3*XSHIFT,Rhomeposy) = RValDecrypt(1,4);

        RRestore(Rhomeposx,Rhomeposy+YSHIFT) = RValDecrypt(2,1);
        RRestore(Rhomeposx+XSHIFT,Rhomeposy+YSHIFT) = RValDecrypt(2,2);
        RRestore(Rhomeposx+2*XSHIFT,Rhomeposy+YSHIFT) = RValDecrypt(2,3);
        RRestore(Rhomeposx+3*XSHIFT,Rhomeposy+YSHIFT) = (LightCorr/256)*RValDecrypt(2,4);

        RRestore(Rhomeposx,Rhomeposy+2*YSHIFT) = (LightCorr/256)*RValDecrypt(3,1);
        RRestore(Rhomeposx+XSHIFT,Rhomeposy+2*YSHIFT) = RValDecrypt(3,2);
        RRestore(Rhomeposx+2*XSHIFT,Rhomeposy+2*YSHIFT) = RValDecrypt(3,3);
        RRestore(Rhomeposx+3*XSHIFT,Rhomeposy+2*YSHIFT) = RValDecrypt(3,4);

        RRestore(Rhomeposx,Rhomeposy+3*YSHIFT) = RValDecrypt(4,1);
        RRestore(Rhomeposx+XSHIFT,Rhomeposy+3*YSHIFT) = (LightCorr/256)*RValDecrypt(4,2);
        RRestore(Rhomeposx+2*XSHIFT,Rhomeposy+3*YSHIFT) = RValDecrypt(4,3);
        RRestore(Rhomeposx+3*XSHIFT,Rhomeposy+3*YSHIFT) = RValDecrypt(4,4);
        
    end
end
ImageMat(:,:,1)=RRestore;

%Restoring image to its previous size
ResImageMat=zeros(Data.Height,Data.Width,3);
for z=1:1:3
    for n = 1:1:Data.Height
        for m = 1:1:Data.Width
            
            ResImageMat(n,m,z)=ImageMat(n,m,z);
            
        end
    end
end
ImageMat=ResImageMat;

%Shows decrpyted image per R-G-B level before displaying the end result
%label 'Red Level'
imshow(ImageMat(:,:,1))
figure;
%label 'Green Level'
imshow(ImageMat(:,:,2))
figure;
%lable 'Blue Level'
imshow(ImageMat(:,:,3))
figure;
%label 'Composite Level'
imshow(ImageMat) 
%14,441