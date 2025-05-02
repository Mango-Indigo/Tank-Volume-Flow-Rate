% Volume Flow Rates in a Tank
clc
clear all

%given parameters
V1_start = 0.5; %L/s
V2_steady = 0.1; %L/s
C1_start = 6; %mol/L
C_target = 4; %mol/L
K = 1.5*10^(-4); %1/s
V_tank = 1; %m3

%assumed parameters
t_max = 2; %hrs
dt = 1; %s

%conversion of units to perform calculations
V1_start = V1_start/1000; %L/s to m3/s
V2_steady = V2_steady/1000; %L/s to m3/s
C1_start = C1_start*1000; %mol/L to mol/m3
C_target = C_target*1000; %mol/L to mol/m3
t_max = t_max*3600; %hrs to s

%defining the parameters for the for loop
i_max = ceil(t_max/dt)+1; 
t= 0:dt:(i_max*dt);

%the main calculations
n(1)=0; %initially filled with water
for i=1:dt:i_max-1
    n(i+1) = n(i)+ ((V1_start*C1_start)-(n(i)/V_tank)*(V1_start+ V2_steady)-K*n(i))*dt;   
    n1(i) = C1_start*V1_start;
    C_tank(i)=C_target;
    n_out(i) = (n(i)/1000)*(V1_start + V2_steady); 
    n_lost(i) = n(i)*K;
end

%reaching 90 percent of target concentration 
C_qn4 = 0.90*C_target;
reached = 0;
for i=1:dt:i_max
   if abs((n(i)-C_qn4)/C_qn4)<0.0001 && reached ==0
   fprintf('time to reach 90 percent of target concentration: %f min.\n',(i)*dt/60)
   reached=1;    
   end   
end

%conversion back to original units
t=t/3600; %s to hrs
C_tank = C_tank/1000; % mol/m3 to mol/L
n=n/1000; %mol to mol/L
n_out = n_out*1000; %m3 to L
t_max = t_max/3600; %s to hrs

%the graphs
subplot(3,1,1)
plot(t(1:i_max-1),n1(1:i_max-1))
xlabel('t / hr')
ylabel('Inlet n_{H_{2}O_{2}} / mol/s')

subplot(3,1,2)
plot(t(1:i_max-1),C_tank(1:i_max-1)); hold on
plot(t(1:i_max-1), n(1:i_max-1)); hold on
xlabel('t / hr')
ylabel('Conc_{out} / mol/L')
hold off
legend('Target H_{2}O_{2} Conc','Actual H_{2}O_{2} Conc')
axis([0 t_max 0 5])

subplot(3,1,3)
plot(t(1:i_max-1),n_out(1:i_max-1)); hold on
plot(t(1:i_max-1),n_lost(1:i_max-1)); hold on
xlabel('t / hr')
ylabel(' Outlet n_{H_{2}O_{2}} / mol/s')
hold off
legend('Outlet flowrate H_{2}O_{2}','Decomposed H_{2}O_{2}')
axis([0 t_max 0 3])
