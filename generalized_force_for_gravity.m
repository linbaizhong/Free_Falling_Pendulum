function [ Q_total_general_force_of_gravity ]=generalized_force_for_gravity( my_data )

m_mass_of_element = my_data.m_mass_of_element;
g_acceleration_of_gravity = my_data.g_acceleration_of_gravity;
l_element_length_of_beam = my_data.l_element_length_of_beam;
ne_number_of_elements = my_data.ne_number_of_elements;
nd_number_of_independent_coordinates = my_data.nd_number_of_independent_coordinates;
lambda_element_location_vector = my_data.lambda_element_location_vector;
%

I_22 = eye(2);
Q_temp_1 = [1/2 * I_22; 1/12 * l_element_length_of_beam * I_22; 1/2 * I_22; -1/12 * l_element_length_of_beam * I_22];
Q_temp_2 = [0; -m_mass_of_element * g_acceleration_of_gravity]; 
Q_element_general_force_of_gravity = Q_temp_1 * Q_temp_2;

Q_total_general_force_of_gravity = zeros(nd_number_of_independent_coordinates, 1);

for j = 1 : ne_number_of_elements
   for k = 1:8
      lambda_temp = lambda_element_location_vector(k ,j ); 
      if lambda_temp > 0
          Q_total_general_force_of_gravity(lambda_temp) = Q_total_general_force_of_gravity(lambda_temp) + Q_element_general_force_of_gravity(k);
      else
          % do nothing
      end
   end
end

end