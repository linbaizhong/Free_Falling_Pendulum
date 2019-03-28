function [M] = post_processing(T, Y, my_data)
%
ne = my_data.ne_number_of_elements;
nd = my_data.nd_number_of_independent_coordinates;

r1 = zeros(size(T, 1), ne+1 );
r2 = zeros(size(T, 1), ne+1 );
 for i = 1: size(T,1)
     [e_element,~] = get_e_element(my_data, (Y(i,:))');
     for j = 1:ne
         switch j
             case 1
                 r1(i,j) = e_element(1,j);
                 r2(i,j) = e_element(2,j);
                 r1(i,j+1) = e_element(5,j);
                 r2(i,j+1) = e_element(6,j);
             otherwise
                 r1(i,j+1) = e_element(5,j);
                 r2(i,j+1) = e_element(6,j);
         end
     end
 end

figure (1)
plot(T, Y(:, nd - 2)) % Y(:, nd - 2)代表单摆右端的纵坐标
figure (2)

writerObj = VideoWriter('Free_Falling_Pendulum.avi');
open(writerObj);

c = my_data.movie.step; im = 1;
for i = 1:c:size(T,1)
    switch i
        case 1
            plot(r1(i,:), r2(i,:))
        otherwise
            plot(r1(i,:), r2(i,:))
    end
    axis([-1.5 1.5 -1.5 0.5])
    grid on
    M(im)=getframe; 
    writeVideo(writerObj, M(im));
    im = im + 1;
end
 title('Trajectory of Free Falling Pendulum')
 xlabel('x(m)')
 ylabel('y(m)')

 close(writerObj);


end