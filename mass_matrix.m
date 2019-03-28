function [ M_mass_matrix_total_inverse ]= mass_matrix( my_data )

l_element_length_of_beam = my_data.l_element_length_of_beam;
rho_density_of_mass = my_data.rho_density_of_mass;
A_area_of_section = my_data.A_area_of_section;
ne_number_of_elements = my_data.ne_number_of_elements;
nd_number_of_independent_coordinates = my_data. nd_number_of_independent_coordinates;
lambda_element_location_vector = my_data.lambda_element_location_vector;
 

% get element mass matrix:
% M_mass_matrix_of_element = zeros( 8, 8 );
m_11_temp = 13/35; m_12_temp = 11/210 * l_element_length_of_beam; m_13_temp = 9/70; m_14_temp = -13/420 * l_element_length_of_beam;
m_22_temp = 1/105 * l_element_length_of_beam^2; m_23_temp = -m_14_temp; m_24_temp = -1/140 * l_element_length_of_beam^2;
m_33_temp = m_11_temp; m_34_temp = -m_12_temp;
m_44_temp = m_22_temp;
I_22 = eye(2);
M_mass_matrix_of_element = [ m_11_temp * I_22, m_12_temp * I_22, m_13_temp * I_22, m_14_temp * I_22;
                                   m_12_temp * I_22, m_22_temp * I_22, m_23_temp * I_22, m_24_temp * I_22;
                                   m_13_temp * I_22, m_23_temp * I_22, m_33_temp * I_22, m_34_temp * I_22;
                                   m_14_temp * I_22, m_24_temp * I_22, m_34_temp * I_22, m_44_temp * I_22];
c_temp = rho_density_of_mass * A_area_of_section * l_element_length_of_beam;
M_mass_matrix_of_element = c_temp * M_mass_matrix_of_element;

% get total mass matrix:
M_mass_matrix_total = zeros(nd_number_of_independent_coordinates, nd_number_of_independent_coordinates);
for j = 1 : ne_number_of_elements
   for k = 1:8
       for l = 1:8
        lambda_k_temp = lambda_element_location_vector(k ,j );   
        lambda_l_temp = lambda_element_location_vector(l ,j ); 
        if lambda_k_temp > 0 && lambda_l_temp > 0
            M_mass_matrix_total(lambda_k_temp, lambda_l_temp) = M_mass_matrix_total(lambda_k_temp, lambda_l_temp) ...
                + M_mass_matrix_of_element( k, l );
        else
            % do nothing
        end
       end
   end
end
M_mass_matrix_total_inverse = inv(M_mass_matrix_total);


end