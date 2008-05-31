import graph;

usepackage("palatino");
usepackage("mathpazo");

size(7inches,3inches);
scale(true);

real f(real x) { return sin(x); }
pair F(real x) { return (x, f(x)); }

xaxis("$x$");
yaxis("$y$");

draw(graph(f,-10.,10,operator ..), red);

