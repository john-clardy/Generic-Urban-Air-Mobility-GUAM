% File description
% Name : mot_ctrl_dmd_fixedpitch_fixedwing_init			
% Author : Luke Heyerdahl - ANL		                          				
% Description : Sets PID values for the propeller motor controller

% Proprietary : public
% Protected: false

% Models :  mot_ctrl_dmd_uas -- (parent)
%           powerplant_quadcopter_init

% Vehicle Type : rotorcraft

aeronomie.m1.mot.ctrl.init.P = aeronomie.m1.powerplant.mot.ctrl.init.P;
aeronomie.m1.mot.ctrl.init.I = aeronomie.m1.powerplant.mot.ctrl.init.I;
aeronomie.m1.mot.ctrl.init.D = aeronomie.m1.powerplant.mot.ctrl.init.D;

aeronomie.m1.mot.propel.plant.init.Pmax          = aeronomie.m1.powerplant.propel.plant.init.Pmax;
% aeronomie.m1.mot.propel.plant.init.CP_CT_map     = aeronomie.m1.powerplant.propel.plant.init.CP_CT_map;
aeronomie.m1.mot.propel.init.CPpoly              = aeronomie.m1.powerplant.propel.init.CPpoly;
aeronomie.m1.mot.propel.plant.init.propD         = aeronomie.m1.powerplant.propel.plant.init.propD;

aeronomie.m1.mot.tc.plant.init.ratio = aeronomie.m1.powerplant.tc.plant.init.ratio;

aeronomie.m1.mot.propel.init.disableEffMap = 1; %1 sets eff to 1  |  0 sets eff to map value 