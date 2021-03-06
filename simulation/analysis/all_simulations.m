startup;

[physics_p, control_p_smc, traj_p_smc, sim_p] = smc3d_slung_config();
[~, control_p_flat, traj_p_flat] = flat_smc3d_slung_config();
[~, control_p_shaped_smc, traj_p_shaped_smc] = shaped_smc3d_slung_config();
[~, control_p_shaped_flat, traj_p_shaped_flat] = shaped_flat_smc3d_slung_config();
dict = plot_dictionary('pt');

% Plot desired path
fig = figure('units','normalized','outerposition',[0.25,0.2,0.46,0.56]);
set(fig,'Renderer','painters');
grid on;
view(3);

offset_xy = .9*physics_p.l;
offset_z = 2*physics_p.r;
xlim_values = [min(traj_p_flat.rd(:,1))-offset_xy, max(traj_p_flat.rd(:,1))+offset_xy];
ylim_values = [min(traj_p_flat.rd(:,2))-offset_xy, max(traj_p_flat.rd(:,2))+offset_xy];
zlim_values = [min(traj_p_flat.rLd(:,3))-offset_z,  max(traj_p_flat.rd(:,3))+offset_z];

axis equal;
xlim(xlim_values);
ylim(ylim_values);
zlim(zlim_values);

h1 = line(traj_p_flat.rd(:,1),traj_p_flat.rd(:,2),traj_p_flat.rd(:,3),'Color','g');
h2 = line(traj_p_flat.rLd(:,1),traj_p_flat.rLd(:,2),traj_p_flat.rLd(:,3),'Color','r');

qd = traj_p_flat.sample_fun(0);
qd_load = traj_p_flat.rL_fun(0);
plot_quadrotor3d(qd(1:3),qd(4:6),qd_load(1:3),physics_p.r,physics_p.rotor_r,physics_p.load_radius);

xlabel('$x$ [m]','FontSize',14);
ylabel('$y$ [m]','FontSize',14);
zlabel('$z$ [m]','FontSize',14);

leg = legend([h1,h2],strcat(dict.quad_trajectory_leg,' (I, II)'), strcat(dict.load_trajectory_leg, " (III)"),"tex","FontSize",11);
% set(leg,'FontSize',14);

disp('smc');
tic;
[t,x_smc,qd_smc,u_smc,metrics_smc] = run_simulation(physics_p, control_p_smc, traj_p_smc, sim_p);
toc;
% disp('flat');
% tic;
% [~,x_flat,qd_flat,u_flat,metrics_flat] = run_simulation(physics_p, control_p_flat, traj_p_flat, sim_p);
% toc;

disp('shaped smc');
tic;
[~,x_shaped_smc,qd_shaped_smc,u_shaped_smc,metrics_shaped_smc] = run_simulation(physics_p, control_p_shaped_smc, traj_p_shaped_smc, sim_p);
toc;

disp('shaped flat');
tic;
[~,x_shaped_flat,qd_shaped_flat,u_shaped_flat,metrics_shaped_flat] = run_simulation(physics_p, control_p_shaped_flat, traj_p_shaped_flat, sim_p);
toc;

% metrics = [metrics_smc; metrics_flat; metrics_shaped_smc; metrics_shaped_flat];
metrics = [metrics_smc; metrics_shaped_smc; metrics_shaped_flat];

figure;
bar([metrics_shaped_smc', metrics_shaped_flat']);
legend(strcat(dict.configuration_leg, " II"), strcat(dict.configuration_leg, " III"));
set(gca,'xticklabel',{'$r_{RMS}$','$\beta_{RMS}$','$\alpha_{RMS}$','$\bar{f}_\omega$'});

figure;
bar([metrics_smc', metrics_shaped_smc', metrics_shaped_flat']);
legend("(I)", "(II)", "(III)");
set(gca,'xticklabel',{'$r_{RMS}$','$\beta_{RMS}$','$\alpha_{RMS}$','$\bar{f}_\omega$'});

drone_times = traj_p_smc.wait_time + (traj_p_smc.Tf-traj_p_smc.wait_time-traj_p_smc.setling_time)*[0.1, 0.6, 0.85];
[~,drone_times] = min(abs(t-drone_times));

plot_drone_load_path(x_smc,traj_p_smc.rd,physics_p, '(I)', drone_times, dict);
plot_drone_load_path(x_shaped_smc,traj_p_shaped_smc.rd,physics_p, '(II)', drone_times, dict);
plot_drone_load_path(x_shaped_flat,traj_p_shaped_flat.rd,physics_p, '(III)', drone_times, dict);

