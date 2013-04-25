function [atlas cseg] = merge(atlas, cseg)

chart        = cseg.ptlist{end};
nbfunc       = @(x) atlas.isneighbor(chart, x);
close_charts = find(cellfun(nbfunc, atlas.charts));
checked      = chart.id;
while ~isempty(close_charts)
  [atlas chart checked] = ...
    atlas.merge_recursive(chart, close_charts(1), checked);
  close_charts = setdiff(close_charts, checked);
end
atlas.charts   = [atlas.charts, {chart}];
atlas.boundary = [chart.id, atlas.boundary];
atlas.bound_flag = [chart.id, atlas.bound_flag];
bd_charts      = atlas.charts(atlas.boundary);
idx            = cellfun(@(x) ~isempty(x.bv), bd_charts);
atlas.boundary = atlas.boundary(idx);
atlas.bound_flag = atlas.bound_flag(idx);
if isempty(atlas.boundary)
  chart.pt_type    = 'EP';
  chart.ep_flag    = 1;
  cseg.ptlist{end} = chart;
end

end
