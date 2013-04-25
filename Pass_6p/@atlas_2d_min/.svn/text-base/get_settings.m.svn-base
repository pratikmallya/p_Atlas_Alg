function cont = get_settings(cont)

defaults.h     = 0.1;
defaults.PtMX  = 50;
defaults.theta = 0.5;
defaults.almax = 10;
defaults.Rmarg = 0.95;
defaults.Ndirs = 6;
cont           = coco_merge(defaults, cont);
cont.almax     = cont.almax*pi/180;
cont.Ndirs     = max(3, ceil(cont.Ndirs));
al             = (0:cont.Ndirs-1)*(2*pi/cont.Ndirs);
cont.s0        = [cos(al); sin(al)];
cont.bv0       = 1:cont.Ndirs;
cont.nb0       = zeros(1,cont.Ndirs);
r1             = cont.h/cos(pi/cont.Ndirs);
cont.v0        = r1*ones(cont.Ndirs,1);

end