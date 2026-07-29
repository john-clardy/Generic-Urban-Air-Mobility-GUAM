% File description
% Name : geom_fixedwing_RyanNavion_init			
% Author : Francesco Salucci - ANL		                          				
% Description : Initialize the global parameters used in the fixed wing
% powerplant & dynamics calculations

% Proprietary : public
% Protected: false

% Models :  env_plant_nowind -- (parent)

% Vehicle Type : rotorcraft

%%
% the implemented rotorcraft model uses body axes (x-forward, y-right,
% z-down)
% the CG has to be in [0,0,0] for how the controller is designed
g0 = 9.81;
ft2m = .3048;
lb2kg = .454;
lbft2tokgm2 = lb2kg*ft2m^2;

aircrafttype = 'rotorcraft';
aircraftconfig = 'hexacopter';
geom.init.sw = 160.48*(ft2m^2); 
geom.init.l = sqrt(geom.init.sw);
geom.init.b = 38.35*(ft2m); 
geom.init.cbar = 4.25*(ft2m);
geom.init.totalmass = 4800*lb2kg;     % kg
geom.init.totalweight = geom.init.totalmass*g0; %N

geom.init.CG = [0 0 0]; % m     % Center of Gravity location - 
geom.init.aerocenter = geom.init.CG; % m     % Aerodynamic Center location

geom.eng.init.Neng = 6;     %       % Number of engines

% the engines are numbered as follows (top view)
% 5   1      2     6
%_________|_________
%         |
%         |
%     __________
%     4       3

% The origin of the openVSP is 1.5 feet below the nose tip
pos_CG_openVSP = [11.1 0 2.1]; % ft position of the CG used within opneVSP

geom.eng.init.pos.eng1 = [-1 1 -1].*([2.3 -8.5 5.8]-pos_CG_openVSP)*ft2m; 	% m     % Engine 1 position
geom.eng.init.pos.eng2 = [-1 1 -1].*([2.3  8.5 5.8]-pos_CG_openVSP)*ft2m; 	% m     % Engine 2 position
geom.eng.init.pos.eng3 = [-1 1 -1].*([18.8 8.3 9.730]-pos_CG_openVSP)*ft2m; % m     % Engine 3 position
geom.eng.init.pos.eng4 = [-1 1 -1].*([18.8 -8.3 9.730]-pos_CG_openVSP)*ft2m; %m      % Engine 4 position
geom.eng.init.pos.eng5 = [-1 1 -1].*([9.5 -20.175 8.050]-pos_CG_openVSP)*ft2m;      % Engine 5 position
geom.eng.init.pos.eng6 = [-1 1 -1].*([9.5 20.175 8.050]-pos_CG_openVSP)*ft2m;     % m    % Engine 6 position


geom.eng.init.posMAT = [...            % m     % Matrix of engine positions
    geom.eng.init.pos.eng1;
    geom.eng.init.pos.eng2;
    geom.eng.init.pos.eng3;
    geom.eng.init.pos.eng4;
    geom.eng.init.pos.eng5;
    geom.eng.init.pos.eng6];

geom.init.payloadmass = 0;              % kg    
geom.init.payloadcg = [0; 0; 0.1];      % m     % Payload Center of Gravity location
geom.init.payloaddim = 0;               % m     % Payload Reference Length

geom.init.Jx = [329962 161340]*lbft2tokgm2;   % kgm^2 % Inertia in x-axis
geom.init.Jy = [161340 161340]*lbft2tokgm2;   % kgm^2 % Inertia in y-axis
geom.init.Jz = [457382 457382]*lbft2tokgm2;   % kgm^2 % Inertia in z-axis
geom.init.Jxz = 7461*lbft2tokgm2;    % kgm^2 % Product of Inertia in y-axis


%% Saturations
geom.init.airspeedsathigh = Inf;    % m/s
geom.init.airspeedsatlow = -Inf;    % m/s

geom.init.betasathigh = 0;      % rad
geom.init.betasatlow = 0;       % rad

geom.init.alphasathigh = deg2rad(20);     % rad
geom.init.alphasatlow = -deg2rad(20);      % rad

geom.init.phigh = Inf;          % rad/s
geom.init.plow = -Inf;          % rad/s

geom.init.qhigh = Inf;          % rad/s
geom.init.qlow = -Inf;          % rad/s

geom.init.rhigh = Inf;          % rad/s
geom.init.rlow = -Inf;          % rad/s

geom.init.pitchhigh = pi/3;     % rad
geom.init.pitchlow = -pi/3;     % rad

geom.init.bankhigh = pi/3;      % rad
geom.init.banklow = -pi/3;      % rad

clear g0 ft2m lb2kg lbft2tokgm2