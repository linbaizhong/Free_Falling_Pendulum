function [y] = e_element_to_e_total( my_data )

       e_element = my_data.e0_element;
       e_dt_element = my_data.e0_dt_element;
ne_number_of_elements = my_data.ne_number_of_elements;
nd_number_of_independent_coordinates = my_data.nd_number_of_independent_coordinates;

e_total_dependent_coordinnates = zeros(4 * (ne_number_of_elements + 1), 1);
e_dt_total_dependent_coordinnates = zeros(4 * (ne_number_of_elements + 1), 1);


for j = 1 : ne_number_of_elements
    if j == 1
        for k = 1 : 8
            e_total_dependent_coordinnates(  k ) = e_element( k, j );
            e_dt_total_dependent_coordinnates( k ) = e_dt_element( k, j );
        end
    else 
        for k = 1 : 4
              e_total_dependent_coordinnates( 4 * j + k ) = e_element( 4 + k, j );
              e_dt_total_dependent_coordinnates( 4 * j + k ) = e_dt_element( 4 + k, j );
        end
    end
end

ed_total_independent_coordinates = zeros(nd_number_of_independent_coordinates, 1);
ed_dt_total_independent_coordinates = zeros(nd_number_of_independent_coordinates, 1);
for id = 1 : nd_number_of_independent_coordinates
    ed_total_independent_coordinates(id) = e_total_dependent_coordinnates(2 + id);
    ed_dt_total_independent_coordinates(id) = e_dt_total_dependent_coordinnates(2 + id);
end

y = [ed_total_independent_coordinates; ed_dt_total_independent_coordinates];
end





