import graph3;

size(0,200);

usepackage("palatino");
usepackage("mathpazo");

currentprojection=orthographic(4,6,3);

real x(real t) {return cos(2pi*t);}
real y(real t) {return sin(2pi*t);}
real z(real t) {return t;}

defaultpen(overwrite(SuppressQuiet));

path3 p=graph(x,y,z,0,2.7,operator ..);
bbox3 b=autolimits(min(p),max(p));
aspect(b,1,1,1);

xaxis(rotate(X)*"$x$",all=true,b,red,RightTicks(rotate(X)*Label,2,2));
yaxis(rotate(Y)*"$y$",all=true,b,red,RightTicks(rotate(Y)*Label,2,2));
zaxis("$z$",all=true,b,red,RightTicks);

draw(p,Arrow);

