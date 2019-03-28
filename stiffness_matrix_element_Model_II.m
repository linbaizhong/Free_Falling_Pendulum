function [K_stiffness_matrix_of_element_L2_T1] = stiffness_matrix_element_Model_II(e_element, my_data, Kt_stiffness_matrix_of_element_for_model_T1)

ne_number_of_elements = my_data.ne_number_of_elements;
l_element_length_of_beam = my_data.l_element_length_of_beam;
E_modulus_of_elasticity = my_data.E_modulus_of_elasticity;
A_area_of_section = my_data.A_area_of_section;


I_22 = eye(2);
K_stiffness_matrix_of_element_L2_T1 = zeros(8,8,ne_number_of_elements);

for j = 1 : ne_number_of_elements
    e1_temp = e_element(1,j);
    e2_temp = e_element(2,j);
    e3_temp = e_element(3,j);
    e4_temp = e_element(4,j);
    e5_temp = e_element(5,j);
    e6_temp = e_element(6,j);
    e7_temp = e_element(7,j);
    e8_temp = e_element(8,j);
    
    dx_temp = e5_temp - e1_temp; dy_temp = e6_temp - e2_temp;
    d_temp = sqrt( ( e5_temp - e1_temp )^2 + ( e6_temp - e2_temp )^2 );
    ax_temp = l_element_length_of_beam * e3_temp; ay_temp = l_element_length_of_beam * e4_temp;
    a_temp = sqrt( ax_temp^2 + ay_temp^2 );
    bx_temp = l_element_length_of_beam * e7_temp; by_temp = l_element_length_of_beam * e8_temp;
    b_temp = sqrt( bx_temp^2 + by_temp^2 );
    
    ax_dx = ax_temp * dx_temp; ay_dy = ay_temp * dy_temp; ax_bx = ax_temp * bx_temp; ay_by = ay_temp * by_temp;
    bx_dx = bx_temp * dx_temp; by_dy = by_temp * dy_temp;
    
    AA_temp = 3/(70 * l_element_length_of_beam^2) * ( a_temp^2 + b_temp^2 - 14 * l_element_length_of_beam^2 - ...
                 6 * ax_dx - 6 * bx_dx - 6 * ay_dy - ...
                 6 * by_dy + 24 * d_temp^2); 
    BB_temp = 1/(280 * l_element_length_of_beam) * ( b_temp^2 - a_temp^2 + 2 * ax_bx + 2 * ay_by ...
                 - 14 * l_element_length_of_beam^2 - 24 * ax_dx - 24 * ay_dy ...
                 + 36 * d_temp^2);
    CC_temp = 1/(280*l_element_length_of_beam) * ( a_temp^2 - b_temp^2 + 2 * ax_bx + 2 * ay_by ...
                 - 14 * l_element_length_of_beam^2 - 24 * bx_dx - 24 * by_dy ...
                 + 36 * d_temp^2);   
    DD_temp = 1/420 * ( 12 * a_temp^2 + b_temp^2 - 3 * ax_bx - 3 * ay_by ...
                 - 28 * l_element_length_of_beam^2 + 3 * ax_dx - 3 * bx_dx ...
                 + 3 * ay_dy - 3 * by_dy + 18 * d_temp^2);  
    EE_temp = -1/840 * ( 3 * a_temp^2 + 3 * b_temp^2 - 4 * ax_bx - 4 * ay_by ...
               - 14 * l_element_length_of_beam^2 + 6 * ax_dx + 6 * bx_dx ...
               + 6 * ay_dy + 6 * by_dy); 
    FF_temp = 1/420 * ( a_temp^2 + 12 * b_temp^2 - 3 * ax_bx - 3 * ay_by ...
               - 28 * l_element_length_of_beam^2 - 3 * ax_dx + 3 * bx_dx ...
               - 3 * ay_dy + 3 * by_dy + 18 * d_temp^2);      
           
% Kl_stiffness_matrix_of_element_for_model_L2 = zeros( 8, 8 );
k_11_temp = AA_temp; k_12_temp = BB_temp; k_13_temp = - AA_temp; k_14_temp = CC_temp;
k_22_temp = DD_temp; k_23_temp = - BB_temp; k_24_temp = EE_temp;
k_33_temp = AA_temp; k_34_temp = - CC_temp;
k_44_temp = FF_temp;
Kl_stiffness_matrix_of_element_for_model_L2 = [ k_11_temp * I_22, k_12_temp * I_22, k_13_temp * I_22, k_14_temp * I_22;
                                   k_12_temp * I_22, k_22_temp * I_22, k_23_temp * I_22, k_24_temp * I_22;
                                   k_13_temp * I_22, k_23_temp * I_22, k_33_temp * I_22, k_34_temp * I_22;
                                   k_14_temp * I_22, k_24_temp * I_22, k_34_temp * I_22, k_44_temp * I_22];
c_temp = E_modulus_of_elasticity * A_area_of_section / l_element_length_of_beam;                            
Kl_stiffness_matrix_of_element_for_model_L2 = c_temp * Kl_stiffness_matrix_of_element_for_model_L2;
           
    K_stiffness_matrix_of_element_L2_T1(:, :, j) = Kl_stiffness_matrix_of_element_for_model_L2 ...
                                      + Kt_stiffness_matrix_of_element_for_model_T1;

end


end



