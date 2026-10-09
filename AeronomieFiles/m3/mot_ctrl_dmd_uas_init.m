% File description
% Name : mot_ctrl_dmd_fixedpitch_fixedwing_init			
% Author : Luke Heyerdahl - ANL		                          				
% Description : Sets PID values for the propeller motor controller

% Proprietary : public
% Protected: false

% Models :  mot_ctrl_dmd_uas -- (parent)
%           powerplant_quadcopter_init

% Vehicle Type : rotorcraft

aeronomie.m3.mot.ctrl.init.P = aeronomie.m3.powerplant.mot.ctrl.init.P;
aeronomie.m3.mot.ctrl.init.I = aeronomie.m3.powerplant.mot.ctrl.init.I;
aeronomie.m3.mot.ctrl.init.D = aeronomie.m3.powerplant.mot.ctrl.init.D;

aeronomie.m3.mot.propel.plant.init.Pmax          = aeronomie.m3.powerplant.propel.plant.init.Pmax;
% aeronomie.m3.mot.propel.plant.init.CP_CT_map     = aeronomie.m3.powerplant.propel.plant.init.CP_CT_map;
aeronomie.m3.mot.propel.init.CPpoly              = aeronomie.m3.powerplant.propel.init.CPpoly;
aeronomie.m3.mot.propel.plant.init.propD         = aeronomie.m3.powerplant.propel.plant.init.propD;

aeronomie.m3.mot.tc.plant.init.ratio = aeronomie.m3.powerplant.tc.plant.init.ratio;

aeronomie.m3.mot.propel.init.disableEffMap = 1; %1 sets eff to 1  |  0 sets eff to map value 