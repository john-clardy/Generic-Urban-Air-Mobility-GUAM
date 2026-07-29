
% powerplant.propel.plant.init.Pmax;

%%  Electric motor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% preliminary data and calculations to upload the maps and make the motor
% similar to the ones used by the Joby S4.

power_TO =  1.0549e+05; % Maximum output power of propeller
power_MC = 1.0549e+05/1.25; % max continuous pwoer
speed_base = 77.8947; % base speed of EM rad/s
speed_max = 2000*pi/30; % max speed of EM (speculated)
torque_TO = power_TO/speed_base; % takeoff torque
voltage = 600; % hyphotesis on electric motor voltage
eta_EM_max = 0.94; % max efficiency of the EM+INV system

% mass of the electric motor regression (NASA NDARC)
massEM = @(Q) (0.3928)*(Q*0.7375621492772656)^(0.8587)*.454;
massEM = massEM(torque_TO);
% mass of the inverter regression (Duffy model, NASA NDARC)
massInv = @(P) 0.125*(P/1000)^(0.96);  
massInv = massInv(power_TO);

%  Efficiency map
% using the McDonald - Electric Propulsion Modeling for Conceptual Aircraft Design method
k0 = 0.5;
eta_hat = eta_EM_max;
omega_hat = speed_base;
Q_hat = power_TO/speed_base/2;

C0 = k0*omega_hat*Q_hat/6*(1-eta_hat)/eta_hat;
C1 = -3*C0/(2*omega_hat) + Q_hat*(1-eta_hat)/(4*eta_hat);
C2 = C0/(2*omega_hat^3) + Q_hat*(1-eta_hat)/(4*eta_hat*omega_hat^2);
C3 = omega_hat*(1-eta_hat)/(2*Q_hat*eta_hat);
% array of omega and Q to evaluate the effiency
omega_array = linspace(-speed_max,speed_max,50);
Q_array = linspace(-power_TO/speed_base,power_TO/speed_base,50);
% create the grid of values for the efficiency map
[omega_grid, Q_grid] = meshgrid(omega_array, Q_array);
% power loss
P_L = C0 + C1.*omega_grid + C2.*omega_grid.^3 + C3.*Q_grid.^2;
% efficiency map 
etaEM = omega_grid.*Q_grid./(omega_grid.*Q_grid + abs(P_L));
etaEM = min(eta_hat, abs(etaEM));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Electric motors -------------------------------------------------------
% Mass properties of the electric motor
mot.plant.init.mass.motor = massEM;
mot.plant.init.mass.controller = massInv;
mot.plant.init.mass.total = massEM + massInv;

mot.plant.init.pwr_density = power_TO/(massEM+massInv);
mot.plant.init.curr_max = power_TO/voltage;
mot.plant.init.spd_base = speed_base;

mot.plant.init.inertia = 0.009; % this value is probably wrong
mot.plant.init.coeff_regen = 1;
mot.plant.init.volt_min = voltage;
mot.plant.init.time_response = 0*0.05;
mot.plant.init.t_max_trq = 60*10;

% array of speeds, necessary to build the torque/omega curve
speed_array = linspace(speed_base,speed_max,20);

mot.plant.init.cont_to_peak_ratio = power_TO/power_MC;


mot.plant.init.trq_cont.idx1_spd = [0 speed_array speed_max];
mot.plant.init.trq_cont.map = [power_MC/speed_base power_MC./speed_array 0];

mot.plant.init.trq_max.idx1_spd = mot.plant.init.trq_cont.idx1_spd; % rad/s
mot.plant.init.trq_max.map = mot.plant.init.cont_to_peak_ratio.* mot.plant.init.trq_cont.map;
mot.plant.init.trq_max.points.trq = max(mot.plant.init.trq_max.map);


mot.plant.init.trq_min.idx1_spd = mot.plant.init.trq_max.idx1_spd; % rad/s
mot.plant.init.trq_min.map = -mot.plant.init.trq_max.map;
                          

mot.plant.init.trq_pos_cont.idx1_spd = [-fliplr(mot.plant.init.trq_cont.idx1_spd(2:end)) -eps 0 eps mot.plant.init.trq_cont.idx1_spd(2:end)];
mot.plant.init.trq_pos_cont.map   = [-fliplr(mot.plant.init.trq_cont.map(2:end))  -mot.plant.init.trq_cont.map(2) mot.plant.init.trq_cont.map(2) mot.plant.init.trq_cont.map(2) mot.plant.init.trq_cont.map(2:end)];
mot.plant.init.pwr_pos_cont.map = mot.plant.init.trq_pos_cont.idx1_spd.*mot.plant.init.trq_pos_cont.map;

mot.plant.init.trq_pos_max.idx1_spd  = [-fliplr(mot.plant.init.trq_max.idx1_spd(2:end)) -eps 0 eps mot.plant.init.trq_max.idx1_spd(2:end)];
mot.plant.init.trq_pos_max.map    = [-fliplr(mot.plant.init.trq_max.map(2:end))   -mot.plant.init.trq_max.map(2) mot.plant.init.trq_max.map(2) mot.plant.init.trq_max.map(2) mot.plant.init.trq_max.map(2:end)];
mot.plant.init.pwr_pos_max.map    =  mot.plant.init.trq_pos_max.idx1_spd.*mot.plant.init.trq_pos_max.map;

mot.plant.init.trq_neg_cont.idx1_spd  = [-fliplr(mot.plant.init.trq_cont.idx1_spd(2:end)) -eps 0 eps mot.plant.init.trq_cont.idx1_spd(2:end)];
mot.plant.init.trq_neg_cont.map    = [fliplr(mot.plant.init.trq_cont.map(2:end))  mot.plant.init.trq_cont.map(2) -mot.plant.init.trq_cont.map(2) -mot.plant.init.trq_cont.map(2)  -mot.plant.init.trq_cont.map(2:end)];
mot.plant.init.pwr_neg_cont.map = mot.plant.init.trq_neg_cont.idx1_spd.*mot.plant.init.trq_neg_cont.map;

mot.plant.init.trq_neg_max.idx1_spd   = [-fliplr(mot.plant.init.trq_max.idx1_spd(2:end)) -eps 0 eps mot.plant.init.trq_max.idx1_spd(2:end)];
mot.plant.init.trq_neg_max.map     = [fliplr(mot.plant.init.trq_max.map(2:end))    mot.plant.init.trq_max.map(2) -mot.plant.init.trq_max.map(2) -mot.plant.init.trq_max.map(2) -mot.plant.init.trq_max.map(2:end)];
mot.plant.init.pwr_neg_max.map     = mot.plant.init.trq_neg_max.idx1_spd.*mot.plant.init.trq_neg_max.map;



mot.plant.init.eff_trq.idx1_spd = omega_array;
mot.plant.init.eff_trq.idx2_trq = Q_array;
mot.plant.init.eff_trq.map = etaEM;
mot.plant.calc.eff_trq.max = eta_hat;

mot.plant.calc.pwr_elec.idx1_spd = omega_array;
mot.plant.calc.pwr_elec.idx2_trq = Q_array;
mot.plant.calc.pwr_elec.map = (omega_grid.*Q_grid./(etaEM));



% clear all the clutter
clear power_TO speed_base massEM massInv power_MC speed_max 
clear torque_TO  torque_MC voltage eta_EM_max k0 eta_hat omega_hat Q_hat
clear P_hat C0 C1 C2 C3 omega_array Q_array  omega_grid Q_grid
clear P_L etaEM speed_array