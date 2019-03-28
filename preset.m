function [ my_data ] = preset()

my_data.movie.step = 50;

 my_data.g_acceleration_of_gravity_1 = 9.81; % m/s^2
 my_data.g_acceleration_of_gravity_2 = 50; % m/s^2

my_data.rho_density_of_mass = 5540; % kg/m^3
my_data.A_area_of_section = 0.0018; % m^2
my_data.l_total_lenth_of_beam = 1.2 ; % m
my_data.I_second_moment_of_area = 1.215e-08; % m^4
my_data.E_modulus_of_elasticity = 0.700E+06; %  Pa

my_data.ode_method = 2;
switch my_data.ode_method
    case 1
my_data.time_simulation = 1.1; % s for my own Euler method
    case 2
my_data.time_simulation = 1.1; % s  for matlab ode method
    otherwise
        'No such a case';
end

% choose case:
my_data.model_type = 2; 
switch my_data.model_type
    case 1    %  L1 + T1
   %     my_data.ne_number_of_elements = 40;
   my_data.ne_number_of_elements = 1;
        my_data.n_number_of_steps = 2.5E4;
      %  my_data.constant_mod = 100;

    case 2     % L2 + T1
         my_data.ne_number_of_elements = 12;
       % my_data.ne_number_of_elements = 1;

        my_data.n_number_of_steps = 2.0E4;
     %   my_data.constant_mod = 100;

end
 my_data.delta_time = my_data.time_simulation/my_data.n_number_of_steps; % s
       
my_data.nd_number_of_independent_coordinates = 4 * (my_data.ne_number_of_elements + 1) - 2;
my_data.l_element_length_of_beam = my_data.l_total_lenth_of_beam /my_data.ne_number_of_elements; % 0.1m
my_data.m_mass_of_element = my_data.rho_density_of_mass * my_data.A_area_of_section * my_data.l_element_length_of_beam;

my_data.g_acceleration_of_gravity = my_data.g_acceleration_of_gravity_1;
%%%%


% I_22 = eye(2);


my_data.e0_element = zeros(8, my_data.ne_number_of_elements);
my_data.e0_dt_element = zeros(8, my_data.ne_number_of_elements);
for j = 1 : my_data.ne_number_of_elements
   my_data.e0_element(1, j) = (j - 1) * my_data.l_element_length_of_beam;
   my_data.e0_element(3, j) = 1;
   my_data.e0_element(5, j) = j  * my_data.l_element_length_of_beam;
   my_data.e0_element(7, j) = 1;
end

[ my_data ] = location_vector( my_data );


end