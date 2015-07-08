
clear

dt=1/25000;          %sampling interval

c=340;                  %velocity of sound
f=1500;                 % Frequency in HZ
lambda=c/f;

a=[-20:2:20;zeros(1,21)]; %Creating sensor arrays on x-axis
ax=a(1,:); % all the x-position of the sensor arrays
ay=a(2,:); %all the y-positions of the sensor arrays

%M=31;% 31 sources
M=1;
N=length(ax); %21 Sensors

%sx=-30+2*(1:M); %source x-position
%sx=320-rand(1,M)*100; %randomly generated x position for different sources
%sy=555000000+rand(1,M)*100;
%sy=320;%+zeros(1,M)*100; %randomly generated y position for different sources
%sy=-1*sx+320;
sx=0;
sy=555000000000; %randomly generated y position for different sources
%sy=sqrt((320.^2)-(sx.^2))

%freq=1500+rand(1,M)*100; %Varying frequency

data(1:N,1:M)=0; %creating an empty sensor vs. signal array

Amp=1+0.5*(1:M);

for m=1:M
%A(m)=1; %Amplitude
A(m)=Amp(m);
theta1(m)=atan2(sy(m),sx(m));
%f(m)=freq(m);
%lambda(m)=c./f(m);
%k(m)=(2*pi)./lambda(m);
end

for m=1:M;
    for n=1:N; %randomly generated y position for different sources

        r1(n,m)=sqrt((sx(m)-ax(n)).^2+(sy(m)-ay(n)).^2); %distance from the source to the array
    end
end
yData=[theta1;A]; %known distance

for m=1:M;
    lambda=10; %wavelength from each source
    k=(2*pi)/lambda;
    noise=randn*0;
    for n=1:N;
        sig(n)=A(m)*(1./r1(n,m).^2).*exp(1i*k*r1(n,m))+noise; %signal to each array.
        data(n,m)=sig(n);
    end
end
inData=data; %input data

%plot(sx,sy,'o')
%phase=atan2(imag(sig),real(sig));
%plot(phase);
for m=1:21;
    hold on
    %plot(real(inData(:,m)))
    %plot(sx(m),sy(m),'ko')
    xlabel('Sources')
    ylabel('Position')
    %title('Phase difference in different sensors from one source')
    plot(angle(inData(:,m)))
    %plot(angle(exp(i*k*r1(:,m))));
    hold off
end

%Testdaten
%theta=0.234;
x=15.5;
y=555000000;
r=sqrt(x^2+y^2);
theta=atan2(y,x);
A1=1.23;
testData=[theta;A1];
ft=1500; 
lambda=c/ft;              
K=2*pi/lambda;
 

for n = 1:N;
         z(n)=A1*(1/r^2)*exp(1i*K*r);
end


ctdata=z.';

save signal_generation_NNet_1Q inData yData testData ctdata
