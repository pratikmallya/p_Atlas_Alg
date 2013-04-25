function [prob atlas cseg predict] = refine_step(atlas, prob, cseg)

predict = false;
chart   = cseg.ptlist{1};
R       = chart.R;
if R > atlas.cont.hmin
  chart.R = max(atlas.cont.hfred*R, atlas.cont.hmin);
  atlas.base_chart = chart;
  predict = true;
end

end