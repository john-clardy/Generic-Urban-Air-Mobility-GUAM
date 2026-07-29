% File description
% Name : quadcopter_init				
% Author : Francesco Salucci - ANL		                          				
% Description : Initialize the parameters used in the quadcopter propeller

% Proprietary : public
% Protected: false

% Models :  propel_plant_uas -- (parent)

propel.plant.init.Pmax      = powerplant.propel.plant.init.Pmax;        % HorsePower --> Watt

propel.plant.init.Iprop         = powerplant.propel.plant.init.Iprop;           % kgm^2 % Axial Inertia of propeller
propel.plant.init.propD         = powerplant.propel.plant.init.propD;           % m     % Diameter of propeller
propel.plant.init.pos           = geom.eng.init.pos.eng1;                       % m     % Propeller position
propel.plant.init.rotationdir   = powerplant.propel.plant.init.rotationdir1;   	%       % Propeller rotation direction (-1 is CW)   
propel.plant.init.thrustdir     = powerplant.propel.plant.init.thrustdir;       %       % Propeller thrust direction
propel.plant.init.CP_CT_map     = powerplant.propel.plant.init.CP_CT_map;       %       % Map of CP, CT, and efficiency values for a propeller at various angular speeds

propel.ctrl.init.rps            = powerplant.propel.ctrl.init.rps(1);              % rev/s % Initial angular speed of propeller