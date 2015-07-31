%generation of model signals: 
%1 source
%plane wave after FFT

clear

dt=1/25000          %sampling interval

c=340;                  %Schallgeschwindigkeit
f=1500;                 % Frequency in HZ


M=21;
for m=1:M 
r(m)=sqrt((m^2)+5^2)
theta1(m)=atan(5/m)
end

%Amplituden ###############################################
for m=1:M
A(m)=1;
end%
%target data
ydata=[r;theta1];

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
rfak=1;          %additives Rauschen
for n = 1:N;
         z(n)=A(m)*exp(sqrt(-1)*(K*r(m)))+rfak*randn;
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
%theta=0.234;
%A1=1;
%ft=1500; 
%lambda=c/f;              
%K=2*pi/lambda;
 

%for n = 1:N;
         %z(n)=A1*exp(sqrt(-1)*(K*xi(n)*sin(theta )));
%end


%ctdata=z.';
%plot(real(tdata(:,:)))
save spherical_NNet_waves cxdata ydata f %ctdata f
