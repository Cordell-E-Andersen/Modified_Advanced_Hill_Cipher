%Authors: Cordell Andersen and Erica Wiens
%Sources: --- MATLAB documentation and website; Advanced Hill Cipher paper --- 
%Dates: February 23, 2016 - April 22, 2016

function [A] = KeyMatrx1() 
mods=256;
n=2;
 
%Submatrices (lower right and upper left)    
A_22=[2,2;2,2];
A_11=mod(-A_22,mods);

%Arbitrary scalar constant
K=10;

%Submatricies (lower left and upper right)
A_12=mod(K*(eye(n)-A_11),mods);  
A_21=mod((1/K)*(eye(n)+A_11),mods);

%Involutory Key Matrix
A=[A_11,A_12;
   A_21,A_22];