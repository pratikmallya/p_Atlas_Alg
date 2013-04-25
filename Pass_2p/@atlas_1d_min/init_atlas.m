function [prob atlas cseg flush] = init_atlas(atlas, prob, cseg)

chart           = cseg.curr_chart;
chart.pt        = 0;
chart.R         = atlas.cont.h;
chart.s         = sign(atlas.cont.PtMX);
atlas.cont.PtMX = abs(atlas.cont.PtMX);
chart.pt_type   = 'EP';
chart.ep_flag   = 1;
[prob cseg]     = cseg.add_chart(prob, chart);
flush           = true;

end