nodes = 7;
C = zeros(nodes,2*nodes-3);
[joints, members] = size(C);

C(1,1) = 1; C(2,1) = 1;  
C(1,2) = 1; C(3,2) = 1;  
C(2,3) = 1; C(3,3) = 1;  
C(2,4) = 1; C(4,4) = 1;  
C(3,5) = 1; C(4,5) = 1;  
C(3,6) = 1; C(5,6) = 1;  
C(4,7) = 1; C(5,7) = 1;  
C(4,8) = 1; C(6,8) = 1;  
C(5,9) = 1; C(6,9) = 1;  
C(5,10) = 1;C(7,10) = 1; 
C(6,11) = 1;C(7,11) = 1; 


Sx1 = zeros(joints,1); 
Sy1 = zeros(joints,1); 
Sy2 = zeros(joints,1);

Sx = [Sx1 Sy1 Sy2]; Sy = [Sx1 Sy1 Sy2];

Sx(1,1) = 1; Sy(1,2) = 1; Sy(7,3) = 1;

L = zeros(2*joints,1);
L(10) = 32;


X= [0, 6.25, 12.5, 17.125, 21.75, 26.375, 31];

Y= [0, 10, 0, 10, 0, 10, 0];

TrussCalc(C,Sx,Sy,X,Y,L);
