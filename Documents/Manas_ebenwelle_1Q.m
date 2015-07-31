%generation of model signals: 
%1 source
%plane wave after FFT

clear

dt=1/25000          %sampling interval

c=340;                  %Schallgeschwindigkeit
f=1500;                 % Frequency in HZ

%generation of M different plane waves with random DOA and power A
%DOA
M=31;
for m=1:M 
%theta1(m)=(pi/4);
theta1(m)=(-pi/4)+(m*0.01);
end

%Amplituden ###############################################
for m=1:M
A(m)=1;
end
%target data
ydata=[theta1;A];

%generation of line array with 21 sensor position xi and yi
[xii,yii]=meshgrid(-0.5:0.05:0.5,-0.0:0.05:0.0);
xi=xii(:);
yi=yii(:);
N=length(xi);


data(1:N,1:M)=0;


for m=1:M
lambda=c/f;             
K=2*pi/lambda;

%Signalvektor der N Mikrophone
rfak=0;          %additives Rauschen
for n = 1:N;
         z(n)=A(m)*exp(sqrt(-1)*(K*xi(n)*sin(theta1(m))))+rfak*randn;
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
%Testdaten
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
