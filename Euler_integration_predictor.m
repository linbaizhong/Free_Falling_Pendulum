function [y_predict] = Euler_integration_predictor(delta_time, y, dy )
%
y_predict = y + delta_time * dy;

end