function [atlas cseg] = merge(atlas, cseg)

chart        = cseg.ptlist{end};
nbfunc       = @(x) atlas.isclose(chart, x);
bd_charts    = atlas.charts(atlas.boundary);
idx          = cellfun(nbfunc, bd_charts);
close_charts = atlas.boundary(idx);
checked      = [0, chart.id];
while ~isempty(close_charts)
  [atlas chart checked] = ...
    atlas.merge_recursive(chart, close_charts(1), checked);
  close_charts = setdiff(close_charts, checked);
end
atlas.charts   = [atlas.charts, {chart}];
atlas.boundary = [atlas.boundary, chart.id];
bd_charts      = atlas.charts(atlas.boundary);
idx            = cellfun(@(x) ~isempty(x.bv), bd_charts);
atlas.boundary = atlas.boundary(idx);
if isempty(atlas.boundary)
  chart.pt_type    = 'EP';
  chart.ep_flag    = 1;
  cseg.ptlist{end} = chart;
end

end