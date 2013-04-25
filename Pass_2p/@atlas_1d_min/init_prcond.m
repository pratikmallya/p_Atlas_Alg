function [prob atlas cseg correct] = init_prcond(atlas, prob, chart)

chart.R       = 0;
chart.pt      = -1;
chart.pt_type = 'IP';
chart.ep_flag = 1;
[prob cseg]   = CurveSegment.create_initial(prob, chart);
if labindex == 1
    correct       = cseg.correct;
else
    correct = false;
end
end
