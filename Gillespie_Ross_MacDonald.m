%University of Washington 
%AMATH 523: Mathematical Analysis in Biology and Medicine
%Term Paper
%Connor Rice, Vinsensius, Johan Guillen

%This script simulates the stochastic trajectory for the Ross-MacDonald
%model for vector-borne infections, by implementing the Gillespie algorithm

%Parameters Definition
alfa = 4;
beta = 1;
sigma = 6;
delta = 1;

%-----------------------------------------------------------------------------------
odes = [0,10]';        % Initial conditions [x(0),y(0)]
T = 10;                % Total execution time
tiempo_actual = 0;     % Current time

% Definition of possible events
eventos = [  1   0 ; ... % alfa*y
            -1   0 ; ... % beta*x*(1+y)
             0   1; ...  % sigma*x
             0  -1 ]';   % delta*y*(1+x)
 
% Matrix of results
resultados = [0; odes]; % [time,x(t), y(t)]
pt = 1;
tasas=[alfa*odes(2);beta*odes(1)*(1+odes(2));sigma*odes(1);delta*odes(2)*(1+odes(1))];
while(tiempo_actual < T) 
    disp(tiempo_actual)
    % Vector with transition weights
    tasas=[alfa*odes(2);beta*odes(1)*(1+odes(2));sigma*odes(1);delta*odes(2)*(1+odes(1))];
    % Compute delta_T (Exponential Distribution)
    deltaT = -log(rand(1))/sum(tasas);
    % Select event
    evento_ID = randsample(size(eventos,2),1,true,tasas);
    % Update time and new value of odes 
    tiempo_actual = tiempo_actual + deltaT;
    odes = odes + eventos(:,evento_ID);
    %If variables are negative make correction
    if odes(1)<0
        odes(1)=0;
    end
    if odes(2)<0
        odes(2)=0;
    end
    
    % Save time and value of odes
    
    pt = pt + 1;
    resultados(:,pt)   = [tiempo_actual; odes];
  
end
%--------------------------------------------------------------------------

% Graph
plot(resultados(1,:),resultados(2,:),'b')
hold on;
plot(resultados(1,:),resultados(3,:),'r')
xlabel('Time')
ylabel('Solution')
title('Stochastic Trajectory of the vector-borne infection model')
legend('x(t)','y(t)')