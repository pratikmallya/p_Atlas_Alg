function [atlas chart1 checked] = ...
  merge_recursive(atlas, chart1, k, checked)

checked(end+1) = k;
chartk = atlas.charts{k};
if atlas.isclose(chart1, chartk)
  dx     = chartk.x-chart1.x;
  phi1   = chart1.TS'*dx;
  phik   = chartk.TS'*(-dx);
  test1  = chart1.v.*(chart1.s'*phi1)-norm(phi1)^2/2;
  testk  = chartk.v.*(chartk.s'*phik)-norm(phik)^2/2;
  flag1  = (test1>0);
  flagk  = (testk>0);
  chart1 = ...
    atlas.subtract_half_space(chart1, test1, phi1, flag1, chartk.id);
  chartk = ...
    atlas.subtract_half_space(chartk, testk, phik, flagk, chart1.id);
  atlas.charts{k} = chartk;
  check = setdiff(chartk.nb, checked);
  while ~isempty(check)
    [atlas chart1 checked] = ...
      atlas.merge_recursive(chart1, check(1), checked);
    check = setdiff(chartk.nb, checked);
  end
end

end