function [ my_data ] = location_vector( my_data  )
%
ne_number_of_elements = my_data.ne_number_of_elements;
lambda_element_location_vector = zeros(8,ne_number_of_elements);

lambda_element_location_vector(1,1) = 0;
lambda_element_location_vector(2,1) = 0;
lambda_element_location_vector(3,1) = 1;
lambda_element_location_vector(4,1) = 2;
lambda_element_location_vector(5,1) = 3;
lambda_element_location_vector(6,1) = 4;
lambda_element_location_vector(7,1) = 5;
lambda_element_location_vector(8,1) = 6;

for j =2:ne_number_of_elements
   first_number = 3 + 4 * ( j - 2 );
   lambda_element_location_vector(1 ,j ) = first_number;
   lambda_element_location_vector(2 ,j ) = first_number + 1;
   lambda_element_location_vector(3 ,j ) = first_number + 2;
   lambda_element_location_vector(4 ,j ) = first_number + 3;
   lambda_element_location_vector(5 ,j ) = first_number + 4;
   lambda_element_location_vector(6 ,j ) = first_number + 5;
   lambda_element_location_vector(7 ,j ) = first_number + 6;
   lambda_element_location_vector(8 ,j ) = first_number + 7;
end

my_data.lambda_element_location_vector = lambda_element_location_vector;

end