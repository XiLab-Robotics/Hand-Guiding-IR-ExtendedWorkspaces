clear all
clc

%Import Experimental Data
Pos_Exp='LoadSensing\PositionData.r64';
Force_Exp='LoadSensing\ForceData.r64';


fid=fopen(Pos_Exp);                
data=fread(fid,[6,Inf],'double');   
fclose(fid);                       
data=data';

%Extract position data (robot tracing)
x_array=data(:,1)/1000; % Posx [m]
y_array=data(:,2)/1000; % Posy [m]
z_array=data(:,3)/1000; % Posz [m]
A_array=data(:,4)*180/pi; % Rotz [rad]
B_array=data(:,5)*180/pi; % Roty [rad]
C_array=data(:,6)*180/pi; %R otx [rad]

clear data

%Extract F/T sensor data
fid=fopen(Force_Exp);                 
data=fread(fid,[192,Inf],'double');   
fclose(fid);                          
data=Data_bi2real(data');

Fx_array=data(:,1); % [N]
Fy_array=data(:,2); % [N]
Fz_array=data(:,3); % [N]

clear data

time=0:0.012:(length(x_array)-1)*0.012;


%% Plot

Fx0=-179; % [N]
Fy0=202;  % [N]
Fz0=60;   % [N]

figure('Position', [100, 100, 800, 400])
plot(time,movmean(Fx_array-Fx0,5),'LineWidth', 1.5);
hold on
plot(time,movmean(Fy_array-Fy0,5),'LineWidth', 1.5);
plot(time,movmean(Fz_array-Fz0,5),'LineWidth', 1.5);

xlabel('Time [s]', 'FontSize', 12.5, 'FontWeight', 'bold')
ylabel('Force [N]', 'FontSize', 12.5, 'FontWeight', 'bold')
legend('F_x-F_{x0}', 'F_y-F_{y0}', 'F_z-F_{z0}');