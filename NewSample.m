 %https://www.mathworks.com/matlabcentral/fileexchange/44821-matlab-code-for-fsk-modulation-and-demodulation?focused=3805505&tab=function

clc;
clear all;
close all;
flag=[0 1 1 1 1 1 1 0];
address=[1 1];
control=[0 0 1 1 1 1 1 0];
PID=[1 1 1 1 0 0 0];
FCS=[1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1];
x=[flag, address, control, PID, FCS, flag];%>>>>>>>>> MATLAB code for binary FSK modulation and de-modulation >>>>>>>%
                                    % Binary Information
bp=.000001;                                                    % bit period
disp(' Binary information at Trans mitter :');
disp(x);
%XX representation of transmitting binary information as digital signal XXX
bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Input signal');

%XXXXXXXXXXXXXXXXXXXXXXX NRZI XXXXXXXXXXXXXXXXXXXXXXXXXXX%
ibs_nrzm(1)=x(1);
for i=2:length(x)
    if x(i)==1
        ibs_nrzm(i)=~ibs_nrzm(i-1);
    else
        ibs_nrzm(i)=ibs_nrzm(i-1);
    end
end
x=ibs_nrzm;
disp(x);
bit1=[];
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit1=[bit1 se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,2);
plot(t1,bit1,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Input signal after NRZI line encoding');

%XXXXXXXXXXXXXXXXXXXXXXX Binary-FSK modulation XXXXXXXXXXXXXXXXXXXXXXXXXXX%
A=5;                                          % Amplitude of carrier signal
br=1/bp;                                                         % bit rate
f1=br*8;                           % carrier frequency for information as 1
f2=br;                           % carrier frequency for information as 0
t2=bp/99:bp/99:bp;                 
ss=length(t2);
m=[];
for i=1:1:length(x)
    if (x(i)==1)
        y=A*cos(2*pi*f1*t2);
    else
        y=A*cos(2*pi*f2*t2);
    end
    m=[m y];
end
t3=bp/99:bp/99:bp*length(x);
subplot(3,1,3);
plot(t3,m);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Signal after FSK');

%XXXXXXXXXXXXXXXXXXXXXXX AWGN Simulation XXXXXXXXXXXXXXXXXXXXXXXXXXX%
[y]=addnoise(m);
figure;
subplot(211);
plot(t3,m);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title("Signal before Gaussian noise");
subplot(212)
plot(t3,y,'-black');
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title("Signal after Gaussian noise");

function awgnsig = addnoise(m)
awgnsig = zeros(1,length(m));
for i = 1:length(m)
    awgnsig(i) = m(i) + randn;
end
end



