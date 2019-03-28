function [T, Y] = ode_001_myown(fhandle_my_ode, tspan,  y)

t0 = tspan(1); tf = tspan(2);
delta_time = 1.0E-4;
number_of_steps =(tf - t0)/delta_time;
T = zeros( number_of_steps, 1 ); 
nd = size(y,1)/2;
Y = zeros(number_of_steps, 2*nd);
T(1) = t0;
Y(1,:) = y;
for i = 1 : number_of_steps
    
dy = fhandle_my_ode(0, y); % t=0，由于此问题的dy与时间无关，故可随便给t一个值
[ y_predict ] =  Euler_integration_predictor(delta_time, y, dy );

dy_pre = fhandle_my_ode(0, y_predict); % t=0，由于此问题的dy与时间无关，故可随便给t一个值
 
 [y_correct] =  Euler_integration_corrector(delta_time, y, dy_pre);
%
y = 1/2 * ( y_predict + y_correct);
 T(i) = i * delta_time;
 Y(i, :) = y;
end
end