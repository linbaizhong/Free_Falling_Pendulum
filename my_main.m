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
        dy = zeros(2 * nd, 1);% 为\dot y 设置存储空间
        dy(1 : nd) =  y( nd + 1: 2 * nd );
 [b_matrix] = get_acceleration(M_mass_matrix_total_inverse, Q_total_general_force_of_gravity, ...
       Kl_stiffness_matrix_of_element_without_epsilon_l_for_model_L1, Kt_stiffness_matrix_of_element_for_model_T1, ...
       my_data, y ); 
 
dy( nd  + 1 : 2 * nd ) = b_matrix;

    end
% 


end

% 序号 % 被调函数                               % 被调函数功能     % 主调函数序号
% 1      my_main()                               主函数
% 2      preset()                                为已知参数赋值         1
% 3      generalized_force_for_gravity()         计算重力广义力         1
% 4      mass_matrix()                           计算质量阵             1 
% 5      constant_stiffness_matrix_of_element()  计算刚度阵常值部分     1
% 6      e_element_to_e_total()                  由单元节点坐标初始值计算总独立节点坐标列阵初始值  1
% 7      ode_001_myown()                         利用改进的欧拉法求解ODE初值问题 1
% 8      ode45()                                 matlab提供的ODE初值问题求解函数 1
% 9      my_ode()                                一阶常微分方程组右端项计算 7,8
% 10     location_vector()                       设置单元定位向量          2
% 11     Euler_integration_predictor()           欧拉积分预估计算   7
% 12     Euler_integration_corrector()           欧拉积分校正计算   7
% 13     get_acceleration()                      计算独立总节点坐标列阵对时间的二阶导数  9
% 14     stiffness_matrix_element_Model_I()      I号模型单元刚度阵计算   13
% 15     stiffness_matrix_total()                总刚度阵计算     13
% 16     stiffness_matrix_element_Model_II()     II号模型单元刚度阵计算  13
% 17     get_e_element()                         由独立总节点坐标列阵计算各单元节点坐标列阵  13 


















