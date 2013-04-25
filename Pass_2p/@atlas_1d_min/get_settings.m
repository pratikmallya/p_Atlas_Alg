function cont = get_settings(cont)

defaults.h     = 0.1;
defaults.PtMX  = 50;
defaults.theta = 0.5;
defaults.hmax  = 0.1;
defaults.hmin  = 0.01;
defaults.hfinc = 1.1;
defaults.hfred = 0.5;
defaults.almax = 10;
cont           = coco_merge(defaults, cont);
cont.almax     = cont.almax*pi/180;

end