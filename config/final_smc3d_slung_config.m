function [physics_p, control_p, traj_p, sim_p, plot_p] = final_smc3d_slung_config()

    % Physical parameters
    physics_p = quadrotor3d_slung_physics();
    
    % Control parameters
    cparam = [10 1 10 1 7.536613519	1.88634197	17.94128065	0.547326511	9.247371112 7.536613519	1.88634197	17.94128065	0.547326511	9.247371112];
    % cparam = [1 1 1 1 7.096489323	20.95267537	15.55696503	1.302720091	10.0564969 7.096489323	20.95267537	15.55696503	1.302720091	10.0564969];
    
    control_p.lambda_zpsi = [cparam(1); cparam(2)];
    control_p.kappa_zpsi = [cparam(3); cparam(4)];
    control_p.eta_zpsi = zeros(2,1);
    
    control_p.lambda_xtheta = [cparam(5); cparam(6)];
    control_p.lambda_xtheta_dot = [cparam(7); cparam(8)];
    control_p.kappa_xtheta = cparam(9);
    control_p.eta_xtheta = 0;
    
    control_p.lambda_yphi = [-cparam(10); cparam(11)];
    control_p.lambda_yphi_dot = [-cparam(12); cparam(13)];
    control_p.kappa_yphi = cparam(14);
    control_p.eta_yphi = 0;
    
    control_p.control_fun = @final_smc3d_slung_controller;
    
    control_p.n_inputs = 4;

    % Trajectory and simulation parameters
    l = physics_p.l;
    xLd = [ 0  0 2 2 0 0 0]';
    yLd = [ 0  0 0 1 1 0 0]';
    zLd = [-l -l 1 1 1 -l -l]';
    rLd= [xLd yLd zLd];
    
    psid = [0 0 0 pi/2 pi/2 0 0]';
    
    Tf = 12;
    td = linspace(0,Tf,length(xLd))';
    
    sim_p.x0 = zeros(16, 1);
    sim_p.dyn_fun = @quadrotor_slung_load_3d;
    sim_p.t = 0:.02:Tf;

    traj_p.sample_fun = waypoint_flat_trajectory(td, rLd, psid, physics_p);
    
    % Plot parameters
    plot_p.plot_state = @plot_quadrotor3d_slung_state;
    plot_p.plot_animation = @plot_quadrotor3d_slung_animation;
    
    end