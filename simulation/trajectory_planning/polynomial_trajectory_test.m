% SIMPLE TEST OF plan_polynomial_trajectory function

t = [0 5 10]'; % Waypoints times
tt = (-2:.01:12)'; % Sample times

% Waypoints positions
pos = [3 0;
       0 3;
       2 1];

vel = zeros(size(pos));

accel = vel;

% LINEAR
x_d = pos;
sample_fun = plan_polynomial_trajectory(t, x_d, 2, 3);

qqd = sample_fun(tt);

figure;
plot(tt,qqd);
legend('pos1', 'pos2', 'vel1', 'vel2', 'acc1', 'acc2');

% CUBIC
x_d = [pos vel];
sample_fun = plan_polynomial_trajectory(t, x_d, 2, 2);

qqd = sample_fun(tt);

figure;
plot(tt,qqd);
legend('pos1', 'pos2', 'vel1', 'vel2');

% QUINTIC
x_d = [pos vel accel];
sample_fun = plan_polynomial_trajectory(t, x_d, 2, 1);

qqd = sample_fun(tt);

figure;
plot(tt,qqd);
legend('pos1', 'pos2');