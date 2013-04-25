function [prob atlas cseg flush] = init_atlas(atlas, prob, cseg)

chart         = cseg.curr_chart;
chart.pt      = atlas.next_pt;
atlas.next_pt = atlas.next_pt+1;
chart.R       = atlas.cont.h;
chart.s       = atlas.cont.s0;
chart.pt_type = 'EP';
chart.ep_flag = 1;
[prob cseg]   = cseg.add_chart(prob, chart);
flush         = true;

end