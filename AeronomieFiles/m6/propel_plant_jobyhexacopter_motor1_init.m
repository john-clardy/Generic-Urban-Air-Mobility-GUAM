% File description
% Name : quadcopter_init				
% Author : Francesco Salucci - ANL		                          				
% Description : Initialize the parameters used in the quadcopter propeller

% Proprietary : public
% Protected: false

% Models :  propel_plant_uas -- (parent)

aeronomie.m6.propel.plant.init.Pmax      = aeronomie.m6.powerplant.propel.plant.init.Pmax;        % ft-lbf/s

aeronomie.m6.propel.plant.init.Iprop         = aeronomie.m6.powerplant.propel.plant.init.Iprop;  % slug-ft^2 % Axial Inertia of propeller
aeronomie.m6.propel.plant.init.propD         = SimIn.Model.Prop{6, 1}.Dp;                    % ft     % Diameter of propeller
aeronomie.m6.propel.plant.init.pos           = SimIn.Model.Prop{6, 1}.cm_b;                  % ft     % Propeller position
aeronomie.m6.propel.plant.init.rotationdir   = SimIn.Model.Prop{6, 1}.spin;   	%       % Propeller rotation direction (-1 is CW)   
aeronomie.m6.propel.plant.init.thrustdir     = SimIn.Model.Prop{6, 1}.e_b;       %       % Propeller thrust direction
% aeronomie.m6.propel.plant.init.CP_CT_map     = powerplant.aeronomie.m6.propel.plant.init.CP_CT_map;       %       % Map of CP, CT, and efficiency values for a propeller at various angular speeds

aeronomie.m6.propel.ctrl.init.rps            = aeronomie.m6.powerplant.propel.ctrl.init.rps(1);              % rev/s % Initial angular speed of propeller