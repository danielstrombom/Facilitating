function X=nh2DGRSLFB(i,P,Q,R,Rr,b,p)
%Function for calculating the neighbourhood of particle i, the direction of
%the local center of mass and repulsive force.

ba=b/2; %Half the blind angle
N=size(P,1); %Number of particles
NN=zeros(N,3); %To collect nearest neighbors within the attraction radius
NR=zeros(N,3); %To collect nearest neighbours within repulsion radius
count=0;
count2=0;
v=[-P(i,3),-P(i,4)]; %opposite to particle i:s direction of travel

for j=1:size(P,1) %For every
    if j~=i %non-self particle
        if (P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2<R^2 %If particle j within distance R from particle i
            u=[P(j,1)-P(i,1),P(j,2)-P(i,2)];
            theta=acos((v(1)*u(1)+v(2)*u(2))/(sqrt(u(1)^2+u(2)^2))); %Angle between opposite i-direction and direction from i toward j.
            if abs(theta)>ba %If particle j not in i:s blind angle add as neighbor
                count=count+1;
                NN(count,:)=[P(j,1),P(j,2),j];
            end
            if (P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2<Rr^2
                count2=count2+1;
                NR(count2,:)=[P(j,1),P(j,2),j];
            end
        end
    end
end

NN=NN(1:count,:);
NR=NR(1:count2,:);

sNN=size(NN,1);
sNR=size(NR,1);

%IF BIRD ENCOUNTERED LANTERNFLY DETERMINE WHAT HAPPENED
w=1; %set running index
S=0; %Abort loop variable 
RE=0;
while w<=size(Q,1) && S==0 %If lanternfly to check, if bird undecided or eater, and none eaten this far
    if (P(i,1)-Q(w,1))^2+(P(i,2)-Q(w,2))^2<(R/2)^2 %dist to lanternfly w
        if P(i,5)==0 %If bird i undecided
            if rand<p %and eats lanternfly
                if Q(w,3)==0 %which is non-toxic
                    P(i,5)=1; %set status to eater
                    RE=1; %set reaction to eat positive
                else %which is toxic
                    P(i,5)=-1; %set status to non-eater
                    RE=-1; %set reaction to eat negative
                end
                Q=[Q(1:w-1,:);Q(w+1:size(Q,1),:)]; %remove lanternfly w from SLF pop
                S=1; %Set that lanternfly eaten and signal to stop loop
            end
        elseif P(i,5)==1 %If bird i is eater and eats
            if Q(w,3)==0 %non-toxic
                    P(i,5)=1; %set/keep status to eater
                    RE=1; %set reaction to eat positive
                else %which is toxic
                    P(i,5)=-1; %set status to non-eater
                    RE=-1; %set reaction to eat negative
                end
                Q=[Q(1:w-1,:);Q(w+1:size(Q,1),:)]; %remove lanternfly w from SLF pop
                S=1; %Set that lanternfly eaten and signal to stop loop
        elseif P(i,5)==-1 %If bird i is non-eater
            %Nothing happens
        end
    end
    w=w+1; %update running index
end
                
            



if sNR>0 %If have neighbours within repulsion radius
    VV=[0,0];
    for j=1:sNR %For each neighbour
        V=[P(i,1)-NR(j,1),P(i,2)-NR(j,2)];
        d=sqrt(V(1,1)^2+V(1,2)^2);
        VN=(1/d^3)*V; %Relative strength is inversly proportional to distance.
        VV=VV+VN; %Add upp all repulsion vectors
        %Set lanternfly eat pref based on observed interaction
        if RE==1
            P(NR(j,3),5)=1; %If observed positive eating become eater
        elseif RE==-1
            P(NR(j,3),5)=-1; %If observed bad eating become non-eater
        end
    end
    REPn=VV;
    %REPn=(1/sqrt(VV(1,1)^2+VV(1,2)^2))*VV;
else
    REPn=[0,0]; %if no neighbour no new direction.
end

if sNN>0    
 
    CMx=mean(NN(:,1));
    CMy=mean(NN(:,2));
    
    CM=[CMx-P(i,1),CMy-P(i,2)]; %Direction toward center of mass of neighbors
    CM=(1/((CM(1,1)^2+CM(1,2)^2)^(1/2)))*CM; %Normalizes direction toward center of mass   
else
    CM=[0,0];
end

    CMAL=[CM;REPn];
    
    X={CMAL,P,Q};
