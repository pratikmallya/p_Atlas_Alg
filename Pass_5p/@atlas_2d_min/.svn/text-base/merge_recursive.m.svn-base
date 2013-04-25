function [atlas chart1 checked] = ...
  merge_recursive(atlas, chart1, k, checked)

checked(end+1) = k;
chartk = atlas.charts{k};
if atlas.isneighbor(chart1, chartk)
  R               = atlas.cont.h;
  h               = atlas.cont.Rmarg*R;
  v               = @(i,ch) ch.x+h*(ch.TS*ch.s(:,i));
  v1  = arrayfun(@(i) v(i,chart1), chart1.bv, 'UniformOutput', false);
  idx = cellfun(@(x) (norm(chartk.TS'*(x-chartk.x))<R), v1);
  chart1.bv(idx)   = [];
  chart1.nb        = [chart1.nb, chartk.id];
  vk  = arrayfun(@(i) v(i,chartk), chartk.bv, 'UniformOutput', false);
  idx = cellfun(@(x) (norm(chart1.TS'*(x-chart1.x))<R), vk);
  chartk.bv(idx)  = [];
  chartk.nb       = [chartk.nb, chart1.id];
  atlas.charts{k} = chartk;
  check = setdiff(chartk.nb, checked);
  while ~isempty(check)
    [atlas chart1 checked] = ...
      atlas.merge_recursive(chart1, check(1), checked);
    check = setdiff(chartk.nb, checked);
  end
end

end