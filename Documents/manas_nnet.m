
clear all



c=340;
%input:
%training data = cxdata; complex signals from the N sensors
%target data = ydata; real; DOA and power of the sources
%test data = ctdata; complex test signal

%PR = range of the 21 complex input  signals
PR(1:21*2,1)=-1;
PR(1:21*2,2)=1;
%1 source
net = newff(PR,[15,2],{'tansig','purelin'},'trainlm');        % 15 Neuronen im 1. Layer, 2 Neuron im 2. Layer=Output f�r Lage und Amplitude
%net=newcf(PR, [15,2],{'tansig','purelin'},'trainlm');
%net=newelm(PR, [15,2],{'tansig','purelin'},'trainlm');

%load ebenewelle_NNet_1Q;            %load Trainingsdata for far field
load signal_generation_NNet_1Q;     % load training data for near field

%rxdata=real(cxdata);%far field
rxdata=real(inData);% near field
%ixdata=imag(cxdata); %far field
ixdata=imag(inData);% near field

xdata=[rxdata ;ixdata];

%parameters for training the NN 
net.trainParam.epochs = 2000;
net.trainParam.lr=1;
net.trainParam.mu=0.1;
net.trainParam.goal = 1e-8; %neural net never meets the tolerance goal at 14275 at 1e-12 tolerance but it does at 1e-11
net.trainParam.min_grad = 1.0000e-015;
net.trainParam.show = 10;
%[net,tr,Y,e] =train(net,xdata,ydata)      %Batch Training for far field
[net,tr,Y,e] =train(net,xdata,yData)     %Batch training for near field


%result after training
y_dach=sim(net,xdata)               %Test

%Verifikation with test data
rtdata=real(ctdata);
itdata=imag(ctdata);
tdata=[rtdata;itdata];
y_test=sim(net,tdata)



%### ende NNet





save nnetoutput y_test y_dach