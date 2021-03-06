function plot_quadrotor_posvel(t,xyz, xyz_d, xyz_dot, xyz_dot_d, dict)

x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

xd = xyz_d(:,1);
yd = xyz_d(:,2);
zd = xyz_d(:,3);

xdot = xyz_dot(:,1);
ydot = xyz_dot(:,2);
zdot = xyz_dot(:,3);

xdot_d = xyz_dot_d(:,1);
ydot_d = xyz_dot_d(:,2);
zdot_d = xyz_dot_d(:,3);


%% Plot Robot Position
ylim_pos = calc_ylim([xyz;xyz_d],.1);
ylim_vel = calc_ylim([xyz_dot;xyz_dot_d],.1);

figure;
set(gcf, 'OuterPosition', [300, 150, 940, 770]);
subplot(3,2,1);
plot(t,xd,'--', t, x);
ylabel('$x$ [m]');
legend(dict.desired_leg, dict.actual_leg);
th = title(dict.quad_position_title, 'Interpreter','tex','FontSize',12,'FontAngle','Italic','FontWeight','normal');
set(th,'Unit','normalized','Position',[.5, 1.1, 0]);
ylim(ylim_pos);
xlim([t(1) t(end)]);

subplot(3,2,2);
plot(t,xdot_d,'--', t, xdot);
ylabel('$\dot{x}$ [m/s]');
legend(dict.desired_leg, dict.actual_leg);
th = title(dict.quad_linear_velocity_title, 'Interpreter','tex','FontSize',12,'FontAngle','Italic','FontWeight','normal');
set(th,'Unit','normalized','Position',[.5, 1.1, 0]);
ylim(ylim_vel);
xlim([t(1) t(end)]);

subplot(3,2,3);
plot(t,yd,'--', t, y);
ylabel('$$y$$ [m]');
legend(dict.desired_leg, dict.actual_leg);
ylim(ylim_pos);
xlim([t(1) t(end)]);

subplot(3,2,4);
plot(t,ydot_d,'--', t, ydot);
ylabel('$$\dot{y}$$ [m/s]');
legend(dict.desired_leg, dict.actual_leg);
ylim(ylim_vel);
xlim([t(1) t(end)]);

subplot(3,2,5);
plot(t,zd,'--', t, z);
ylabel('$$z$$ [m]');
legend(dict.desired_leg, dict.actual_leg);
xlabel(dict.time_label,'Interpreter','tex','FontSize',12);
ylim(ylim_pos);
xlim([t(1) t(end)]);

subplot(3,2,6);
plot(t,zdot_d,'--', t, zdot);
ylabel('$$\dot{z}$$ [m/s]');
legend(dict.desired_leg, dict.actual_leg);
xlabel(dict.time_label,'Interpreter','tex','FontSize',12);
ylim(ylim_vel);
xlim([t(1) t(end)]);

end

