function pE = SLFB2np(N,NN,p,q,t)

%Plot process over time

%Function to simulate a flock of birds learning to eat lanternfly.
%A number N birds are moving around in their home range that contains
%lanternfly. The bird flocking is modelled by the roosting site model in
%Strömbom et al. 2022 with sequential update (so first to move when close to lanternfly eat it). 
%Each bird is either undecided (and will eat a lanternfly with 
%probability p), or a lanternfly eater (from either trying a lanternfly and 
%had a good experience, or observed another bird eating one and had a good 
%experience) or a lanternfly non-eater (from either trying one and had a
%bad experience, or observed another bird eat one and had a bad
%experience). At the start of the simulation all birds are undecided.
%When a bird is within X units from a lanternfly it will eat it with prob p
%if undecided, prob 1 if eater, prob 0 if non eater. And any other bird that is
%also within X units from the lanternfly being eaten will observe the
%interaction and depending on if good or bad reaction become or unbecome a
%lanternfly eater itself.
%  

rng('shuffle') %generate new random initial configuration for each simulation

%PARAMETERS
%N=number of birds
%NN=number of lanternfly
%p=probability that undecided bird will eat lanternfly it encounters
%q=probability that each lanternfly is toxic
ts=1/75; %Timestep
delta=10*ts; %displacement per time step 
%t=100000; %simulation length
c=1; %relative strength of local attraction
d=1; %relative tendency to proceed in previous direction
rr=1; %relative strength of local repulsion %rr=1.5 too stable
ah=0.0025; %Linear attraction to roosting site at origin.
ba=3.14; %blind angle
e=0.2; %noise intensity
R=6; %interaction radius  

kk=1; %animation index
k=1;

pE=[]; %collect proportion eaters
pNE=0; %0 non eaters initially

%Initiate position/direction/speed collection matrices
X=zeros(N,t); Y=zeros(N,t); Vx=zeros(N,t); Vy=zeros(N,t);

%Initiate particle population
P=zeros(N,5); 
for i=1:N 
    P(i,1)=105*(0.5-rand); % Initiates x-coordinate.
    P(i,2)=50*(0.5-rand); % Initiates y-coordinate.
    P3=0.5-rand; P4=0.5-rand;
    Pdir=(1/sqrt(P3^2+P4^2))*[P3 P4];
    P(i,3)=Pdir(1,1); % Initiates x-dir.
    P(i,4)=Pdir(1,2); % Initiates y-dir.
    P(i,5)=0; %Lanternfly eater status. 0=undecided, 1=eater, -1=non-eater
end

%Initiate lanternfly population (does not move)
Q=zeros(NN,3); 
for i=1:NN 
    Q(i,1)=300*(0.5-rand); % Initiates x-coordinate.
    Q(i,2)=300*(0.5-rand); % Initiates y-coordinate.
    Q(i,3)=(rand<q); %Initiate whether lanternfly is toxic or not.
end

while k<=t && size(Q,1)>0 && pNE<N %Simulate for t time steps (or until no lanternfly left, or ALL are non-eaters, cannot recover from this)
        GCM=[mean(P(:,1)),mean(P(:,2))]; %Global center of mass
      %  PP=zeros(N,4); %Initiate population matrix for synchronous update
        
        for i=1:N % Go through every particle.
            
            X=nh2DGRSLFB(i,P,Q,R,R,ba,p); %Call neighborhood and interaction calculator function
            CMAL=X{1,1};
            C=CMAL(1,:); %Local attraction force
            F=CMAL(2,:); %Local repulsive force  
            P=X{1,2}; %Updated P vector, specifically SLF eat status of neighbors
            Q=X{1,3}; %Updated Q vector, specifically SLF eaten removed.
            
            E=[randn,randn]; %Directional error 
            E=(1/sqrt(E(1,1)^2+E(1,2)^2))*E; %Normalized directional error vector
            
            D=[P(i,3),P(i,4)]; %Current heading
            
            H=[-P(i,1),-P(i,2)]; %Direction to center of home range (Origin)

            Dir=d*D+c*C+rr*F+ah*H+e*E; %Heading update formula

            NH=(1/sqrt(Dir(1,1)^2+Dir(1,2)^2))*Dir; %New normalized Heading                       
            
            %New heading
            P(i,3)=NH(1,1);
            P(i,4)=NH(1,2);
            
            %Update position   
            P(i,1)=P(i,1)+delta*NH(1,1); %New x-coordinate
            P(i,2)=P(i,2)+delta*NH(1,2); %New y-coordinate    
            
            
      
        end
    
      %-----------Plotting-------------------      
%        
% if mod(k,10)==0
%         hold off
%         %PLOT BIRDS (green dot=lanternfly eater, red dot=not lanternfly
%         %eater, blue dot=undecided)
%         for r=1:size(P,1)
%             if P(r,5)==1 %if lanternfly eater
%                 plot(P(r,1),P(r,2),'g.','markersize',10);
%             elseif P(r,5)==-1 %if not lanternfly eater
%                 plot(P(r,1),P(r,2),'r.','markersize',10);
%             else %if undecided
%                 plot(P(r,1),P(r,2),'b.','markersize',10);
%             end
%             hold on
%         end
%         hold on
%         %PLOT LANTERNFLY (red asterisk=toxic lanternfly, green asterisk=not
%         %toxic lanternfly
%         for r=1:size(Q,1)
%             if Q(r,3)==1 %if toxic lanternfly
%                 plot(Q(r,1),Q(r,2),'r*','markersize',10);
%             else %if non-toxic lanternfly
%                 plot(Q(r,1),Q(r,2),'g*','markersize',10);
%             end
%             hold on
%         end
%         plot(0,0,'*m','markersize',10);
% %         hold on
% %         for r=1:N
% %             plot([P(r,1),P(r,1)+P(r,3)],[P(r,2),P(r,2)+P(r,4)],'r-');
% %         end    
%         
%         xlabel('X position')
%         ylabel('Y position')
%         axis manual
%        % axis([min(P(:,1))-50 max(P(:,1))+50 min(P(:,2))-50 max(P(:,2))+50]);    
%         axis([min(Q(:,1))-50 max(Q(:,1))+50 min(Q(:,2))-50 max(Q(:,2))+50]);
%        U(kk)=getframe;
%        
%        kk=kk+1;
%        
% end
%        
%if mod(k,100)==0
%     size(Q,1)
% end

pE=[pE,sum(P(:,5)==1)/N];

pNE=sum(P(:,5)==-1);

        k=k+1;
       % P=PP; %Update particle positions and velocities
end

if size(Q,1)==0 && k<t %If no lanternfly left fill up pE with same as last entry
    for i=k:t
        pE=[pE,pE(1,k)];
    end
end
    
if pNE==N && k<t %If all non eaters fill up pE with zeroes
    for i=k:t
        pE=[pE,0];
    end
end


%sum(P(:,5)==1)/N
%M={X,Y,Vx,Vy};
%plot(1:k-1,pE)
