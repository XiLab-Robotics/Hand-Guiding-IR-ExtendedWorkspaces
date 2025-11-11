clear all
close all
clc

%Import Experimental Data
Pos_Exp='HandGuiding_Test2\PositionData.r64'; %Position Data
Force_Exp='HandGuiding_Test2\ForceData.r64'; %Force Data

start_delaytime=30; %[s]
extra_stoptime=10; %[s]
trigger=round(start_delaytime/0.012); %[n_cicli]
stopdelay=round(extra_stoptime/0.012); %[n_cicli]

%Extract position data (robot tracing)
fid=fopen(Pos_Exp);                
data=fread(fid,[6,Inf],'double');   
fclose(fid);                        
data=data';

x_tracing=data(trigger:end-stopdelay,1)/1000; % Posx [m]
y_tracing=data(trigger:end-stopdelay,2)/1000; % Posy [m]
z_tracing=data(trigger:end-stopdelay,3)/1000; % Posz [m]
A_tracing=data(trigger:end-stopdelay,4); % Rotz [rad]
B_tracing=data(trigger:end-stopdelay,5); % Roty [rad]
C_tracing=data(trigger:end-stopdelay,6); % Rotx [rad]

time=0:0.012:(length(x_tracing)-1)*0.012;
vel_x=diff(x_tracing)./diff(time');
vel_y=diff(y_tracing)./diff(time');
vel_z=diff(z_tracing)./diff(time');

clear data

%Extract F/T sensor data
fid=fopen(Force_Exp);                
data=fread(fid,[192,Inf],'double');   
fclose(fid);                          
data=Data_bi2real(data');

Fx=data(trigger:end-stopdelay,1); % [N]
Fy=data(trigger:end-stopdelay,2); % [N]
Fz=data(trigger:end-stopdelay,3); % [N]
Tx=data(trigger:end-stopdelay,4); % [Nm]
Ty=data(trigger:end-stopdelay,5); % [Nm]
Tz=data(trigger:end-stopdelay,6); % [Nm]

clear data

%% Elaborate Guiding Forces
%from load sensing procedure (see related file and experiment)
Tool_weight= 143.2;   %[N]
xg=-0.00099;   % [m]
yg=-0.00884;   % [m]
zg=0.00891;    % [m]

Fx0=-179.2;   % [N]
Fy0=202.6;    % [N]
Fz0=59.5;     % [N]
Tx0=25.6;     % [Nm]
Ty0=16.4;     % [Nm]
Tz0=3.6;      % [Nm]

%Initial joint config {0,-90,90,0,90,0}
A0=-pi/2;
B0=0;
C0=pi;

R0=RotMat(A0,B0,C0);


for i=1:length(time)

R=RotMat(A_tracing(i),B_tracing(i),C_tracing(i));
R_T=transpose(R0*R);

F_HG=[Fx(i);Fy(i);Fz(i)]-[Fx0;Fy0;Fz0]-R_T*[0;0;-Tool_weight];

T_HG=[Tx(i);Ty(i);Tz(i)]-[Tx0;Ty0;Tz0]-[0 -zg yg; zg 0 -xg; -yg xg 0]*R_T*[0;0;-Tool_weight];

FT_HG(i,:)=[F_HG',T_HG'];

end


%% Plot
figure('Position', [100, 100, 800, 400])
subplot(2,1,1)
plot(time(1:end-1),vel_x*1000, 'LineWidth',1.5);
hold on
plot(time(1:end-1),vel_y*1000, 'LineWidth',1.5);
plot(time(1:end-1),vel_z*1000, 'LineWidth',1.5);
legend('v_{g,X}','v_{g,Y}','v_{g,Z}')
xlabel('Time [s]', 'FontSize', 12.5, 'FontWeight', 'bold');
ylabel('Velocity [mm/s]', 'FontSize', 12.5, 'FontWeight', 'bold');

subplot(2,1,2)
plot(time,FT_HG(:,1),'LineWidth',1.5);
hold on
plot(time,FT_HG(:,2),'LineWidth',1.5);
plot(time,FT_HG(:,3),'LineWidth',1.5);
legend('F_{g,X}','F_{g,Y}','F_{g,Z}')
xlabel('Time [s]', 'FontSize', 12.5, 'FontWeight', 'bold');
ylabel('Force [N]', 'FontSize', 12.5, 'FontWeight', 'bold');


view1=-35;
view2=15;
AspectRatio=[1 1 2];

FigPos=[200 200 400 400];

fig1=figure('position', FigPos);
axes1 = axes('Parent',fig1);
hold(axes1,'on');
view(axes1,[view1 view2]);
box(axes1,'on');
grid(axes1,'on');
set(axes1,'FontSize',15,'GridAlpha',0.2,'GridLineStyle','--');

plot3(x_tracing,y_tracing,-z_tracing,'-k','LineWidth',1.5);

ax = gca;
ax.FontSize = 15;

xlabel('X[m]','FontSize',18,'FontWeight','bold');
ylabel('Y[m]','FontSize',18,'FontWeight','bold');
zlabel('Z[m]','FontSize',18,'FontWeight','bold');


