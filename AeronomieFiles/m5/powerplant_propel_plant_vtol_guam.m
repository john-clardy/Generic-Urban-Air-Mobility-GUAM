% File description
% Name : quadcopter_init (ADAPTED for NASA L+C Lift Rotor)
% Description : Initialize parameters for ONE Lift Rotor of the NASA L+C
% Note: This file replaces the pointers with hardcoded NASA values.

%% Geometry & Mass
aeronomie.m5.powerplant.propel.plant.init.rotorcorediam = 0.30*SimIn.Units.m;      % ft     % Hub diameter (approx 30cm)
aeronomie.m5.powerplant.propel.plant.init.Wprop = 2.0*SimIn.Units.kg*SimIn.Environment.Earth.Gravity.g0;              % lbf     % Propeller weight (approx 2kg)
aeronomie.m5.powerplant.propel.plant.init.Iprop = 0.025*SimIn.Units.kg*SimIn.Units.m2;             % slug-ft^2 % Propeller Inertia (Bulk of the 0.028 total)
aeronomie.m5.powerplant.propel.plant.init.propD = SimIn.Model.Prop{5, 1}.Dp;              % ft     % Diameter (9 ft)

%% Rotation Direction (CRITICAL: NASA L+C alternates)
% You must manually assign this for each of the 8 rotors. 
% Standard L+C Pattern: Front-Right CCW, Front-Left CW, etc.
% Setting generic defaults here, but OVERWRITE these in your vehicle setup.
% aeronomie.m5.powerplant.propel.plant.init.rotationdir1 = [0; 0; 1];  % CCW
% aeronomie.m5.powerplant.propel.plant.init.rotationdir2 = [0; 0; -1]; % CW
% aeronomie.m5.powerplant.propel.plant.init.rotationdir3 = [0; 0; 1];
% aeronomie.m5.powerplant.propel.plant.init.rotationdir4 = [0; 0; -1]; % (Add 5-8 if your struct supports it)

% aeronomie.m5.powerplant.propel.plant.init.thrustdir = [0; 0; -1];    % Thrust direction (Upwards force, -Z in NED)

aeronomie.m5.powerplant.propel.plant.init.thrustdir = SimIn.Model.Prop{5, 1}.e_b;    % Thrust direction (Upwards force, -Z in NED)

%% Performance Limits
% aeronomie.m5.powerplant.propel.plant.init.Pmax = 100100 ;%* 5.25;              % ft-lbf/s     % Max Power (90 kW)(250kw)
aeronomie.m5.powerplant.propel.plant.init.Pmax = 530*550; %530hp

%% Aerodynamic Maps (CP / CT)
load('vehicles/Lift+Cruise/AeroProp/SFunction/PropCoef/APCSF_10x4p7_coef.mat')
aeronomie.m5.powerplant.propel.init.CTpoly = APCSF_10x4p7_coef(:,1);
aeronomie.m5.powerplant.propel.init.CPpoly = APCSF_10x4p7_coef(:,2);
aeronomie.m5.powerplant.propel.init.effpoly = [0 0.75];

%% Controller Initial Conditions (Trim State)
% These set the starting point for the simulation so it doesn't crash on start.
% Calculated for NASA L+C Hover:
aeronomie.m5.powerplant.propel.ctrl.init.rps = 17.5;         % rev/s % (1050 RPM)
aeronomie.m5.powerplant.propel.ctrl.init.trq_trim = 628.0*SimIn.Units.N*SimIn.Units.m;   % N-m   % Torque required to hover
aeronomie.m5.powerplant.propel.ctrl.init.hover_dt = [0.7 0.7]; % Estimated Duty Cycle (0.0-1.0) for hover

clear APCSF_10x4p7_coef
