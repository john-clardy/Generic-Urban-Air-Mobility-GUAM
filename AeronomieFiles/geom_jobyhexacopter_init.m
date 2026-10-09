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

aircrafttype = 'rotorcraft';
aircraftconfig = 'hexacopter';
aeronomie.geom.init.sw = (SimIn.Model.WingProp.Wing.b/2)*(SimIn.Model.WingProp.Wing.c_root+SimIn.Model.WingProp.Wing.c_tip); %ft^2 *S=(b/2)*(c_r+c_t)
aeronomie.geom.init.l = sqrt(aeronomie.geom.init.sw);%ft
aeronomie.geom.init.b = SimIn.Model.WingProp.Wing.b; %ft
aeronomie.geom.init.lambda = SimIn.Model.WingProp.Wing.c_tip+SimIn.Model.WingProp.Wing.c_root;
aeronomie.geom.init.cbar = (2/3)*(SimIn.Model.WingProp.Wing.c_root)*((1+aeronomie.geom.init.lambda+aeronomie.geom.init.lambda^2)/(1+aeronomie.geom.init.lambda));
aeronomie.geom.init.totalmass = SimIn.Model.mass;     % slug
aeronomie.geom.init.totalweight = aeronomie.geom.init.totalmass*SimIn.Environment.Earth.Gravity.g0; %lbf

aeronomie.geom.init.CG = [0 0 0]; % ft     % Center of Gravity location - 
aeronomie.geom.init.aerocenter = aeronomie.geom.init.CG; % m     % Aerodynamic Center location

aeronomie.geom.eng.init.Neng = 9;     %       % Number of engines

% the engines are numbered as follows (top view)
% 5   1      2     6
%_________|_________
%         |
%         |
%     __________
%     4       3

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% propellers are number from left to right, then front to back
% 
%                 
%                          / \
%                  (1) (2) | | (3) (4)
%                 ,-------------------,
%                 '-------------------'
%                  (5) (6) | | (7) (8)
%                          | |
%                       ,-------,
%                       '-------'
%                          (9)
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The origin of the openVSP is 1.5 feet below the nose tip
%find cg
pos_CG_openVSP = [11.1 0 2.1]; % ft position of the CG used within opneVSP
Prop_location = ...
          [ -5.07,  -4.63, -4.63, -5.07,  -19.2,  -18.76,-18.76,-19.2,  -31.94;
           -18.750, -8.45,  8.45, 18.750, -18.750, -8.45,  8.45, 18.750,  0.000;
            -6.73,  -7.04, -7.04, -6.73,   -9.01,  -9.3,  -9.3,  -9.01,  -7.79];

aeronomie.geom.eng.init.pos.eng1 = [-1 1 -1].*(Prop_location(:,1)'-pos_CG_openVSP); 	  % ft    % Engine 1 position
aeronomie.geom.eng.init.pos.eng2 = [-1 1 -1].*(Prop_location(:,2)'-pos_CG_openVSP); 	  % ft    % Engine 2 position
aeronomie.geom.eng.init.pos.eng3 = [-1 1 -1].*(Prop_location(:,3)'-pos_CG_openVSP);    % ft    % Engine 3 position
aeronomie.geom.eng.init.pos.eng4 = [-1 1 -1].*(Prop_location(:,4)'-pos_CG_openVSP);   % ft    % Engine 4 position
aeronomie.geom.eng.init.pos.eng5 = [-1 1 -1].*(Prop_location(:,5)'-pos_CG_openVSP); % ft    % Engine 5 position
aeronomie.geom.eng.init.pos.eng6 = [-1 1 -1].*(Prop_location(:,6)'-pos_CG_openVSP);  % ft    % Engine 6 position
aeronomie.geom.eng.init.pos.eng7 = [-1 1 -1].*(Prop_location(:,7)'-pos_CG_openVSP);
aeronomie.geom.eng.init.pos.eng8 = [-1 1 -1].*(Prop_location(:,8)'-pos_CG_openVSP);
aeronomie.geom.eng.init.pos.eng9 = [-1 1 -1].*(Prop_location(:,9)'-pos_CG_openVSP);


aeronomie.geom.eng.init.posMAT = [...            % ft     % Matrix of engine positions
    aeronomie.geom.eng.init.pos.eng1;
    aeronomie.geom.eng.init.pos.eng2;
    aeronomie.geom.eng.init.pos.eng3;
    aeronomie.geom.eng.init.pos.eng4;
    aeronomie.geom.eng.init.pos.eng5;
    aeronomie.geom.eng.init.pos.eng6;
    aeronomie.geom.eng.init.pos.eng7;
    aeronomie.geom.eng.init.pos.eng8;
    aeronomie.geom.eng.init.pos.eng9];

aeronomie.geom.init.payloadmass = 0*SimIn.Units.kg;              % lbm    
aeronomie.geom.init.payloadcg = [0; 0; 0.1*SimIn.Units.m];      % ft     % Payload Center of Gravity location
aeronomie.geom.init.payloaddim = 0*SimIn.Units.m;               % ft     % Payload Reference Length

%check inertias 
aeronomie.geom.init.Jx = [329962 161340]*SimIn.Units.lbm*SimIn.Units.ft2;   % slug-ft^2 % Inertia in x-axis
aeronomie.geom.init.Jy = [161340 16  1340]*SimIn.Units.lbm*SimIn.Units.ft2;   % slug-ft^2 % Inertia in y-axis
aeronomie.geom.init.Jz = [457382 457382]*SimIn.Units.lbm*SimIn.Units.ft2;   % slug-ft^2 % Inertia in z-axis
aeronomie.geom.init.Jxz = 7461*SimIn.Units.lbm*SimIn.Units.ft2;    % slug-ft^2 % Product of Inertia in y-axis


%% Saturations
aeronomie.geom.init.airspeedsathigh = Inf;    % ft/s
aeronomie.geom.init.airspeedsatlow = -Inf;    % ft/s

aeronomie.geom.init.betasathigh = 0;      % rad
aeronomie.geom.init.betasatlow = 0;       % rad

aeronomie.geom.init.alphasathigh = deg2rad(20);     % rad
aeronomie.geom.init.alphasatlow = -deg2rad(20);      % rad

aeronomie.geom.init.phigh = Inf;          % rad/s
aeronomie.geom.init.plow = -Inf;          % rad/s

aeronomie.geom.init.qhigh = Inf;          % rad/s
aeronomie.geom.init.qlow = -Inf;          % rad/s

aeronomie.geom.init.rhigh = Inf;          % rad/s
aeronomie.geom.init.rlow = -Inf;          % rad/s

aeronomie.geom.init.pitchhigh = pi/3;     % rad
aeronomie.geom.init.pitchlow = -pi/3;     % rad

aeronomie.geom.init.bankhigh = pi/3;      % rad
aeronomie.geom.init.banklow = -pi/3;      % rad

%% Clear Unused Variables
clear aircraftconfig aircrafttype pos_CG_openVSP Prop_location;