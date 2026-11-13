function Pbat = computeEstPower(rho, fpa, phi, m, g, V, S, eta, Kelec)
    AR = 10.1657; %(2*SimIn.Model.WingProp.Left.b)^2/(2*sum(SimIn.Model.WingProp.Left.Si)) //11.2
    e = 0.8; % Oswald’s efficiency factor
    CD0 = 0.0151;
    % Kelec = 0;
    
    W = m*g;
    K = 1/(pi*AR*e);
    
    D0 = 0.5*rho*V^2*S*CD0;
    Di = 2*K*W^2/(rho*V^2*S);
    D = D0 + Di*(cos(fpa)/cos(phi))^2;
    
    Treq = D + W*sin(fpa);
    
    Pprop = Treq * V;
    
    Pbat = Pprop/eta + Kelec*(Pprop)^2; % [ft*lbf/s]
end
 