% Define problem parameters
k = 45;           % Heat coefficient for steel (W/m*K)
L = 10;           % Length of rod (m)
d = 0.05;         % Diameter of rod (m)
A = pi * d^2 / 4; % Cross-sectional area of rod (m^2)
rho = 7800;       % Density of steel (kg/m^3)
Cp = 460;         % Specific heat capacity of steel (J/kg*K)
T0 = 20;          % Initial temperature of rod (C)
Tfurnace = 1000;  % Temperature of furnace (C)
Twater = 0;       % Temperature of water (C)

% Compute equally spaced spatial nodes X
x_num = 101;
x_min = 0;
x_max = L;
dx = (x_max - x_min) / (x_num - 1);
x = linspace(x_min, x_max, x_num);

% Compute equally spaced time nodes T
t_num = 201;
t_min = 0;
t_max = 600;
dt = (t_max - t_min) / (t_num - 1);
t = linspace(t_min, t_max, t_num);

% Get the CFL coefficient
cfl = k * dt / (rho * Cp * A * dx^2);
fprintf ( 1, '  CFL coefficient = %g\n', cfl );

% Get the system matrix
a = sparse([], [], [], x_num, x_num);
a(1,1) = 1;
a(x_num,x_num) = 1;
for i = 2 : x_num - 1
    a(i,i-1) = -cfl;
    a(i,i  ) = 1 + 2*cfl;
    a(i,i+1) = -cfl;
end

% Repeatedly solve the linear system
h = zeros(x_num, 1);
hmat = zeros(x_num, t_num);
h(1) = Tfurnace;
for i = 2 : x_num - 1
    h(i) = T0;
end
h(x_num) = Twater;
for j = 1 : t_num
    h = a \ h;
    hmat(1:x_num,j) = h(1:x_num);
end

% Plot the data
  figure ( 1 )
  [ xmat, tmat ] = ndgrid ( x, t );
  mesh ( xmat, tmat, hmat );
  title ( 'H(X,T): temperature distribution' );
  xlabel ( '<-- X -->' );
  ylabel ( '<-- T -->' );
  zlabel ( '<--  H(X,T) -->' );
  filename = 'assign.png';
  print ( '-dpng', filename );
  fprintf ( 1, '  Graphics saved as "%s"\n', filename );

  return


