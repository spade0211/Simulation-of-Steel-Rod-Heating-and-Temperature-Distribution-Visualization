# Simulation-of-Steel-Rod-Heating-and-Temperature-Distribution-Visualization
## Problem Statement
In a power plant, heat exchangers are used to transfer heat from the steam produced by the boiler to the water in the condenser. The steel tubes that make up the heat exchanger can be subject to high temperatures at one end and low temperatures at the other end, leading to thermal stresses that can cause deformation or failure of the tubes. 
By performing a thermal analysis using numerical methods (finite difference; such as the one that will be shown in this code), engineers can predict the temperature distribution and thermal stresses in the tubes and optimize their design for improved performance and reliability.
## Simulation
Consider a one-dimensional heat pipe of length 10m which is initially at a uniform temperature 20°C. The rod is placed in a furnace at one end, and the temperature of the furnace is held at a constant value of 1000°C. The other end of the rod is maintained at a constant temperature of 0°C. The rod loses heat to the environment by convection, with a heat transfer coefficient of k = 45 J/kg*K
## Method of solving
Solve the time-dependent 1D heat equation, using the finite difference method (FDM) in space, and a backward Euler method in time.
```
d2U/dx2 ≈ (U(i-1,j) - 2U(i,j) + U(i+1,j))/dx2
dU/dt ≈ (U(i,j) - U(i,j-1))/dt
dUdT - kd2UdX2 = 0
```
over the interval [A B] with boundary conditions
U(A, T) = UA(T),
U(B, T) = UB(T),
over the time interval [T0,T1] with initial conditions
U(X, TO) = U0(X)

A second order finite difference is used to approximate the second derivative in space.
The solver applies an implicit backward Euler approximation to the first derivative in time.
The resulting finite difference form can be written as
```
   U(X, T+dt) - U(X, T)  =  F(X, T+dt) + k * ( U(X-dx, +dtT) - 2 U(X, +dtT) + U(X+dx, +dtT)
   --------------------     ---------------------------------------------------------------
           dt                                           dx * dx

=> U(X, T+dt) = dt * F(X, T+dt) + U(X, T)
```
which can be written as AX=B, where A is a tridiagonal matrix whose entries are the same for every time step.

## Results
CFL coefficient = 1.91625
A CFL number of 1.91625 suggests that the time step used in the numerical scheme is close to the upper limit of stability. 
In other words, the numerical solution may be unstable and the results obtained may be inaccurate. 
Therefore, it may be necessary to reduce the time step used in the numerical scheme to achieve a lower CFL number and ensure numerical stability.
![Temperature Distribution of Pipe over Time](/imgs/simul.pmg)
