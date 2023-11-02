function M=labFig3
%Function to run 5000 simulations for each q from 0 to 1 in increments of
%0.1 and collect the proportion of lanternfly eaters (p) present at each
%timestep of the 80000 timestep long simulation and create Figure 3.

T=2000; %Number of runs for each q
N=50; %Number of birds
NN=500; %Number of lanternfly
p=0.001; %Probability of undecided bird to spontaneously try to eat encountered lanternfly
t=80000; %Simulation run time 

%q=0 simulations
q=0;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M00=M;
save M00 M00

%q=0.1 simulations
q=0.1;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M01=M;
save M01 M01

%q=0.2 simulations
q=0.2;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M02=M;
save M02 M02

%q=0.3 simulations
q=0.3;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M03=M;
save M03 M03

%q=0.4 simulations
q=0.4;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M04=M;
save M04 M04

%q=0.5 simulations
q=0.5;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M05=M;
save M05 M05

%q=0.6 simulations
q=0.6;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M06=M;
save M06 M06

%q=0.7 simulations
q=0.7;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M07=M;
save M07 M07

%q=0.8 simulations
q=0.8;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M08=M;
save M08 M08

%q=0.9 simulations
q=0.9;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M09=M;
save M09 M09

%q=1 simulations
q=1;
M=[];
    parfor k=1:T
        X = SLFB2np(N,NN,p,q,t);
        M=[M;X];
        [q,k]
    end
M10=M;
save M10 M10



%Create Figure 2B
figure;
t=80000;
load M00
load M01
load M02
load M03
load M04
load M05
load M06
load M07
load M08
load M09
load M10

N=50;
ro=0.45;
ri=0.01;
e=1/N;
t0=80000;
t=0:0.1:80000;

plot(1:t0,mean(M00),'-g','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M01),2000),'-b','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M02),2000),'-r','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M03),2000),'-c','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M04),2000),'-m','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M05),1),'--g','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M06),1),'--b','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M07),1),'--r','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M08),1),'--c','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M09),1),'--m','LineWidth',2);
hold on
plot(1:t0,smooth(mean(M10),1),'--y','LineWidth',2);
hold on

%Plot mathematical solutions
q=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
sq=size(q,2);
for k=1:sq
    a=ro-ro*q(1,k)-q(1,k);
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
end
ylabel('Propotion SLF eaters (p)')
xlabel('Time (t)')
ylim([0 1])


%CREATE FIGURE S1 
figure;

subplot(4,3,1)
q=0;
X=M00;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
ylabel('Propotion SLF eaters (p)')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0')


subplot(4,3,2)
q=0.1;
X=M01;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.1')


subplot(4,3,3)
q=0.2;
X=M02;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.2')


subplot(4,3,4)
q=0.3;
X=M03;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
ylabel('Propotion SLF eaters (p)')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.3')

subplot(4,3,5)
q=0.4;
X=M04;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.4')


subplot(4,3,6)
q=0.5;
X=M05;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.5')


subplot(4,3,7)
q=0.6;
X=M06;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
ylabel('Propotion SLF eaters (p)')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.6')


subplot(4,3,8)
q=0.7;
X=M07;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
%xlabel('time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.7')


subplot(4,3,9)
q=0.8;
X=M08;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
xlabel('Time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.9')


subplot(4,3,10)
q=0.9;
X=M09;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
ylabel('Propotion SLF eaters (p)')
xlabel('Time (t)')
xlim([0 80000])
ylim([0 1])
title('q=0.9')


subplot(4,3,11)
q=1;
X=M10;
Y=mean(X);
E=std(X,1).*ones(1,size(X,2));
errorbar(1:t0,Y,E,'-r');
hold on
plot(1:t0,Y,'--b','LineWidth',1);
a=ro-ro*q-q;
    K=(a/e-ro)/a;
    pt=a./(K*a*exp(-ri*a*t)+ro);
    plot(t,pt,'-k','LineWidth',1);
    hold on
%ylabel('propotion SLF eaters')
xlabel('Time (t)')
xlim([0 80000])
ylim([0 1])
title('q=1')

