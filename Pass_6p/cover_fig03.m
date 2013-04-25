function cover_fig03
p = fileparts(mfilename('fullpath'));
f = fullfile(p, 'cache_klein.mat');
if exist(f, 'file')==2
  load(f);
else
  atlas = coco_bd_read('klein', 'atlas');
  [tri X C] = get_charts(atlas, 1, 2, 3);
  save(f, 'tri', 'X', 'C');
end

% N = 12000;
% M = max(C);
% I = N+find(rand(1,M-N)<=(1-linspace(0,nthroot(0.95,3),M-N).^3));
% r = arrayfun(@(x) (x<N) || any(x==I), C);
% save(f, 'tri', 'X', 'C', 'r');

db = plotdb(1);
db.plot_create('cover_fig03', mfilename('fullpath'));
db.paper_size([10 11]);

cmap = autumn(256);
db.colormap(cmap(32:end,:));
db.trisurf(tri(r,:), -X(:,1), X(:,3), X(:,2), X(:,2), 'LineStyle', 'none');
db.axis('off', 'equal');
db.view([-175 50]);

db.camproj('perspective');
db.campos([-2.8029   33.5060   35.8342]);
db.camva(7.5);
db.camtarget([0.0919   -0.7667   -0.2964]);

db.lighting('flat', 0.75*[1 1 1]);
db.material('dull');

db.light([ 2  2 4], 0.15*[1 1 1]);
db.light([ 1  2 4], 0.25*[1 1 1]);
db.light([ 0  2 4], 0.33*[1 1 1]);
db.light([-1  2 4], 0.33*[1 1 1]);
db.light([-2  2 4], 0.25*[1 1 1]);
db.light([-2  2 2], 0.15*[1 1 1]);
db.light([-2  0 2], 0.10*[1 1 1]);
db.light([-2 -2 2], 0.07*[1 1 1]);

db.plot_margin([-0.04 -0.04 -0.045 -0.06]);

db.plot_close();

end

function [tri X C] = get_charts(charts, ix, iy, iz)
if nargin>=4
  f = @(x) x([ix iy iz])';
else
  f = @(x) x';
end
tri = [];
X   = [];
C   = [];
N   = numel(charts);
for k=1:N
  chart = charts{k};
  xx = chart.x;
  x  = f(xx);
  X  = [ X ; x ];
  xo = size(X,1);
  NN = size(chart.s,2);
  if isfield(chart, 'v')
    chart.v = chart.v;
  else
    chart.v = chart.R*ones(size(chart.s,2),1);
  end
  for l=1:NN-1;
    x   = f(xx+min(chart.R,chart.v(l))*(chart.TS*chart.s(:,l)));
    X   = [ X ; x ];
    tri = [tri ; xo xo+l xo+l+1];
    if chart.ep_flag<=1
      C = [ C ; k   ];
    else
      C = [ C ; 0 ];
    end
  end
  x   = f(xx+min(chart.R,chart.v(NN))*(chart.TS*chart.s(:,NN)));
  X   = [ X ; x ];
  tri = [tri ; xo xo+NN xo+1];
  if chart.ep_flag<=1
    C = [ C ; k   ];
  else
    C = [ C ; 0 ];
  end
end
end
