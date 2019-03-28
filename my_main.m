% This is the main function.
function [M] = my_main()
% 
[ my_data ] = preset();
[ Q_total_general_force_of_gravity ]=generalized_force_for_gravity( my_data );
[ M_mass_matrix_total_inverse ]= mass_matrix( my_data );
% 
[Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, Kt_stiffness_matrix_of_element_for_model_T1] ...
                                       = constant_stiffness_matrix_of_element( my_data );
                                   
[y] = e_element_to_e_total( my_data ); % y = [ed_total_independent_coordinates; ed_dt_total_independent_coordinates]
nd = my_data.nd_number_of_independent_coordinates;
 switch my_data.ode_method
    case 1 % my own method
[T, Y] = ode_001_myown(@my_ode,[0, my_data.time_simulation],y);
    case 2 % matlab method
 [T,Y] = ode45(@my_ode,[0, my_data.time_simulation],y);
    otherwise
        'No such a case.';
 end
 
  [M] = post_processing(T, Y, my_data);

% nested function:
    function dy = my_ode(t, y)
        dy = zeros(2 * nd, 1);% Ϊ\dot y ���ô洢�ռ�
        dy(1 : nd) =  y( nd + 1: 2 * nd );
 [b_matrix] = get_acceleration(M_mass_matrix_total_inverse, Q_total_general_force_of_gravity, ...
       Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, Kt_stiffness_matrix_of_element_for_model_T1, ...
       my_data, y ); 
 
dy( nd  + 1 : 2 * nd ) = b_matrix;

    end
% 


end

% ��� % ��������                               % ������������     % �����������
% 1      my_main()                               ������
% 2      preset()                                Ϊ��֪������ֵ         1
% 3      generalized_force_for_gravity()         ��������������         1
% 4      mass_matrix()                           ����������             1 
% 5      constant_stiffness_matrix_of_element()  ����ն���ֵ����     1
% 6      e_element_to_e_total()                  �ɵ�Ԫ�ڵ������ʼֵ�����ܶ����ڵ����������ʼֵ  1
% 7      ode_001_myown()                         ���øĽ���ŷ�������ODE��ֵ���� 1
% 8      ode45()                                 matlab�ṩ��ODE��ֵ������⺯�� 1
% 9      my_ode()                                һ�׳�΢�ַ������Ҷ������ 7,8
% 10     location_vector()                       ���õ�Ԫ��λ����          2
% 11     Euler_integration_predictor()           ŷ������Ԥ������   7
% 12     Euler_integration_corrector()           ŷ������У������   7
% 13     get_acceleration()                      ��������ܽڵ����������ʱ��Ķ��׵���  9
% 14     stiffness_matrix_element_Model_I()      I��ģ�͵�Ԫ�ն������   13
% 15     stiffness_matrix_total()                �ܸն������     13
% 16     stiffness_matrix_element_Model_II()     II��ģ�͵�Ԫ�ն������  13
% 17     get_e_element()                         �ɶ����ܽڵ���������������Ԫ�ڵ���������  13 


















