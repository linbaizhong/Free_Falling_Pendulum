function [K_stiffness_matrix_total] = stiffness_matrix_total( my_data, K_stiffness_matrix_of_element_Lx_Ty )% Lx = L1,L2,L3; Ty = T1,T2;



ne_number_of_elements = my_data.ne_number_of_elements;
nd_number_of_independent_coordinates = my_data.nd_number_of_independent_coordinates;
lambda_element_location_vector = my_data.lambda_element_location_vector;

%
K_stiffness_matrix_total = zeros(nd_number_of_independent_coordinates, nd_number_of_independent_coordinates);
for j = 1 : ne_number_of_elements
   for k = 1:8
       for l = 1:8
        lambda_k_temp = lambda_element_location_vector(k ,j );   
        lambda_l_temp = lambda_element_location_vector(l ,j ); 
        if lambda_k_temp > 0 && lambda_l_temp > 0
            K_stiffness_matrix_total(lambda_k_temp, lambda_l_temp) = K_stiffness_matrix_total(lambda_k_temp, lambda_l_temp) ...
                + K_stiffness_matrix_of_element_Lx_Ty( k, l ,j);
        else
            % do nothing
        end
       end
   end
end


end