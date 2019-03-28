function [b_matrix] = get_acceleration(M_mass_matrix_total_inverse, Q_total_general_force_of_gravity, ...
       Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, Kt_stiffness_matrix_of_element_for_model_T1, ...
       my_data, y )

  [e_element, ~] = get_e_element(my_data, y);
nd = my_data.nd_number_of_independent_coordinates;
ed_total_independent_coordinates = y(1:nd);

M_inverse_Q = M_mass_matrix_total_inverse * Q_total_general_force_of_gravity;

% model_type = 1;
switch my_data.model_type
    case 1

[K_stiffness_matrix_of_element_L1_T1] = stiffness_matrix_element_Model_I(e_element, my_data, ...
               Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, ...
               Kt_stiffness_matrix_of_element_for_model_T1);
[K_stiffness_matrix_total] = stiffness_matrix_total( my_data, K_stiffness_matrix_of_element_L1_T1 ); % Lx = L1,L2,L3; Ty = T1,T2;


    case 2
 [K_stiffness_matrix_of_element_L2_T1] = stiffness_matrix_element_Model_II(e_element, my_data, Kt_stiffness_matrix_of_element_for_model_T1);
  [K_stiffness_matrix_total] = stiffness_matrix_total( my_data, K_stiffness_matrix_of_element_L2_T1 ); % Lx = L1,L2,L3; Ty = T1,T2;

     
end

b_matrix = M_inverse_Q - M_mass_matrix_total_inverse * K_stiffness_matrix_total * ed_total_independent_coordinates;



end