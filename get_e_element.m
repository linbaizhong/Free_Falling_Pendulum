function [e_element, e_dt_element] = get_e_element(my_data, y)


ne_number_of_elements = my_data.ne_number_of_elements;
nd_number_of_independent_coordinates = my_data.nd_number_of_independent_coordinates;

nd = nd_number_of_independent_coordinates;
ed_total_independent_coordinates = y(1:nd);
ed_dt_total_independent_coordinates = y(nd+1:2*nd);

%
e_total_dependent_coordinates(1) = 0;
e_total_dependent_coordinates(2) = 0;
for id = 1 : nd_number_of_independent_coordinates
   e_total_dependent_coordinates( 2 + id ) =  ed_total_independent_coordinates(id);
end

e_dt_total_dependent_coordinates(1) = 0;
e_dt_total_dependent_coordinates(2) = 0;
for id = 1 : nd_number_of_independent_coordinates
   e_dt_total_dependent_coordinates( 2 + id ) =  ed_dt_total_independent_coordinates(id);
end

e_element = zeros(8,ne_number_of_elements);
e_dt_element = zeros(8,ne_number_of_elements);

for j = 1 : ne_number_of_elements
   for k = 1 : 8
      e_element(k,j) =  e_total_dependent_coordinates( 4 * ( j - 1) + k );
      e_dt_element(k,j) =  e_dt_total_dependent_coordinates( 4 * (  j - 1 ) + k );
   end
end


end