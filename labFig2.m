function M=labFig2
%Function to run 2000 simulations for each q from 0 to 1 in increments of
%0.01 and measure the proportion of lanternfly eaters (p) at the end of each
%and create Figure 2.

T=2000; %Number of runs for each q
N=50; %Number of birds
NN=500; %Number of lanternfly
p=0.001; %Probability of undecided bird to spontaneously try to eat encountered lanternfly
t=80000; %Simulation run time
q=0:0.01:1; %proportion of toxic lanternfly (q) values
sq=size(q,2);

M=zeros(T,sq); %Initiate matrix to collect long term p for each q.

for i=1:sq %Loop over all q
    parfor k=1:T
        X = SLFB2np(N,NN,p,q(1,i),t); %Run main simulator function
        M(k,i) = X(1,size(X,2)); %Record last entry
       % [i,k]
    end
end

Cpvq=M;

save Cpvq Cpvq

%Create Figure 2A 
figure;
load Cpvq 
C=Cpvq;
q=0:0.01:1;
X=C;
Y=mean(C);
E=std(X,1).*ones(1,size(X,2));
errorbar(q,Y,E,'-r');
hold on
plot(q,smooth(Y,3),'-k','LineWidth',3);
hold on
ro=0.45;
p=1-((ro+1)*q)/ro;
plot(q,p,'--b','LineWidth',3);
ylabel('Proportion SLF eaters (p)')
xlabel('Proportion toxic SLF (q)')
ylim([0 1])