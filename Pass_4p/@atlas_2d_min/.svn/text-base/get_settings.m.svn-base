function cont = get_settings(cont)

defaults.h     = 0.1;
defaults.PtMX  = 50;
defaults.theta = 0.5;
defaults.almax = 10;
defaults.Rmarg = 0.95;
defaults.Ndirs = 6;
cont           = coco_merge(defaults, cont);
cont.almax     = cont.almax*pi/180;
al             = (0:cont.Ndirs-1)*(2*pi/cont.Ndirs);
cont.s0        = [cos(al); sin(al)];

end