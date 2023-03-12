%University of Washington 
%AMATH 523: Mathematical Analysis in Biology and Medicine
%Term Paper
%Connor Rice, Vinsensius, Johan Guillen

%This script simulates the behavior of the ODEs for the Ross-MacDonald
%model for vector-borne infections

%Solve ODEs

[t,y] = ode23(@RM,[0 10],[0; 10]);

plot(t,y(:,1),'b',t,y(:,2),'r')
title('Deterministic solution of the vector-borne infection model');
xlabel('Time');
ylabel('Solution');
legend('x(t)','y(t)')

function dydt = RM(t,y)
%Parameters Definition
alfa = 4;
beta = 1;
sigma = 6;
delta = 1;
dydt = [alfa*y(2)-beta*y(1)*(1+y(2)); sigma*y(1)-delta*y(2)*(1+y(1))];
end