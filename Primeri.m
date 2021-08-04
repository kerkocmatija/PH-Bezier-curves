%Primeri za seminarsko: 

%Prvi primer - risanje in računanje točk na PH krivulji stopnje 3

t = linspace(0,1,100);
u0 = 2;
u1 = 3;
v0 = 2;
v1 = -1;
p0 = 0;
p1 = 0;

%Preverimo, če so izpoljeni pogoji: 
pogoj1 = u0*v1 - u1*v0
pogoj2 = (u1-u0)^2 + (v1-v0)^2

PH3(u0,u1,v0,v1,p0,p1,t);

%Drugi primer - risanje in računanje točk na PH krivulji stopnje 5
t = linspace(0,1,100);
u0 = 2;
u1 = 3;
u2 = 4;
v0 = 2;
v1 = -1;
v2 = -2;
p0 = 0;
p1 = 0;


%Preverimo, če je pogoj izpoljen
pogoj3 = u2*v0 - u0*v2 - 4*(u0*v1-u1*v0)*(u1*v2-u2*v1)

figure
PH5(u0,u1,u2,v0,v1,v2,p0,p1,t);