function [K_stiffness_matrix_of_element_L1_T1] = stiffness_matrix_element_Model_I(e_element, my_data, ...
               Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, ...
               Kt_stiffness_matrix_of_element_for_model_T1)

ne_number_of_elements = my_data.ne_number_of_elements;
 l_element_length_of_beam = my_data. l_element_length_of_beam;
 

%
K_stiffness_matrix_of_element_L1_T1 = zeros(8,8,ne_number_of_elements);
epsilon_l_average_longitudinal_strain = zeros(ne_number_of_elements, 1);
d_distance_between_the_two_nodes_of_element =  zeros(ne_number_of_elements, 1);
for j = 1 : ne_number_of_elements
    e1_temp = e_element(1,j);
    e2_temp = e_element(2,j);
    e5_temp = e_element(5,j);
    e6_temp = e_element(6,j);
    d_distance_between_the_two_nodes_of_element(j) = sqrt( ( e5_temp - e1_temp )^2 + ( e6_temp - e2_temp )^2 );
    epsilon_l_average_longitudinal_strain(j) =  ( d_distance_between_the_two_nodes_of_element(j) - l_element_length_of_beam )/l_element_length_of_beam;
    K_stiffness_matrix_of_element_L1_T1(:, :, j) = epsilon_l_average_longitudinal_strain(j) * ...
                                      Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1 ...
                                      + Kt_stiffness_matrix_of_element_for_model_T1;

end


end




