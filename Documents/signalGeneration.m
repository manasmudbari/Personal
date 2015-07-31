%generation of model signals: 
%1 source
%plane wave after FFT

clear

dt=1/25000;          %sampling interval

c=340;                  %speed of sound in air
f=1500;                 % Frequency in HZ

%generation of M different plane waves with random DOA and power A
%DOA

%Single source
x=(-20:2:20);
y=330+zeros(1,21);

r=sqrt(x.^2+y.^2);

theta=atan2(y,x);

N=length(x)
M=1;
%for m=1:M
%theta1(m)=pi/4*(rand-0.5);
%end2

%Amplituden ###############################################
for m=1:M
A(m)=1;
end%

%target data
ydata=[theta;A];

%generation of line array with 21 sensor position xi and yi
[xii,yii]=meshgrid(-0.5:0.05:0.5,-0.0:0.05:0.0);
%xi=xii(:);
%yi=yii(:);
%N=length(xi);


data(1:N,1:M)=0;



for m=1:M
    lambda=c/f;             
    K=2*pi/lambda;
    %Signal generation
    fak=0.00;          %noise
    for n = 1:N;
        z(n)=(A(m,n)./r).*exp(sqrt(-1).*(K.*r)); %+rfak*randn;
        data(n,m)=z(n);  
    end
end
%trainingsdata
cxdata=data;

hold on
for m=1:M
  
plot(real(cxdata(:,m)))
%r=input('')
end
hold off

%Test data
theta=0.234;
A1=1;
ft=1500; 
lambda=c/f;              
K=2*pi/lambda;
 

for n = 1:N;
         z(n)=A1*exp(sqrt(-1)*(K*xi(n)*sin(theta )));
end


ctdata=z.';
%plot(real(tdata(:,:)))
save ebenewelle_NNet_1Q cxdata ydata ctdata f
