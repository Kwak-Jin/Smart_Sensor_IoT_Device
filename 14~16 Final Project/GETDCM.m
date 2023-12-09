%===========================================%
% Smart Sensors and IoT devices
% Creator : Jin Kwak
% Created : 2023.06.14
% Modified: 2023.06.19
% This is 2D- plane Rotation Matrix
% For Vehicle Path Making Algorithm
%===========================================%
function R = GetDCM(psi)
    R = [cos(psi)  sin(psi);
        -sin(psi)  cos(psi) ];
end