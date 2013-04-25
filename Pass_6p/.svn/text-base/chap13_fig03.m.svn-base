function chap13_fig03
oldpath = path;
try
  compute_run_data();
  db = plotdb(1);
  plot_first(db);
  % plot_second(db);
  path(oldpath)
  coco_clear_cache('reset');
catch e
  path(oldpath)
  coco_clear_cache('reset');
  rethrow(e);
end
end

function compute_run_data()
% run demo
if ~coco_exist('pillow', 'run')
  oldpath = path;
  run demo
  path(oldpath);
end
if ~coco_exist({'frank' 'run1'}, 'run')
  prob = coco_prob();
  prob = coco_set(prob, 'cont', 'atlas', @atlas_2d_min.create);
  prob = coco_set(prob, 'cont', 'PtMX', 3);
  prob = coco_set(prob, 'cont', 'almax', 30);
  prob = coco_set(prob, 'cont', 'h', 0.15);
  prob = coco_set(prob, 'cont', 'NPR', 100);
  prob = coco_add_func(prob, 'pillow', @pillow, [], 'zero', ...
    'u0', [1; 0; 0]);
  prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
  coco(prob, {'frank' 'run1'}, [], 2, {'x' 'y' 'z'});
end
if ~coco_exist({'frank' 'run2'}, 'run')
  prob = coco_prob();
  prob = coco_set(prob, 'cont', 'atlas', @atlas_2d_min.create);
  prob = coco_set(prob, 'cont', 'PtMX', 20);
  prob = coco_set(prob, 'cont', 'almax', 30);
  prob = coco_set(prob, 'cont', 'h', 0.15);
  prob = coco_set(prob, 'cont', 'NPR', 100);
  prob = coco_add_func(prob, 'pillow', @pillow, [], 'zero', ...
    'u0', [1; 0; 0]);
  prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
  coco(prob, {'frank' 'run2'}, [], 2, {'x' 'y' 'z'});
end
end

function plot_first(db)

db.plot_create('chap13_fig03a', mfilename('fullpath'));
db.view([90 0]);
db.axis([0 2 -0.22 0.17 -0.2 0.2]);
atlas = coco_bd_read({'frank' 'run1'}, 'atlas');
plot_charts(db, atlas.charts, true);
db.yaxis(-0.2:0.1:0.1,2, [2  0.13 -0.235], 'y');
db.zaxis(-0.2:0.1:0.2,2, [2  -0.255 0.15], 'z');
db.plot_margin([0.03 0.03 0.0 0.0]);
db.plot_close();

db.plot_create('chap13_fig03b', mfilename('fullpath'));
db.view([90 0]);
db.axis([0 2 -0.4 0.4 -0.4 0.4]);
atlas = coco_bd_read({'frank' 'run2'}, 'atlas');
plot_charts(db, atlas.charts, true);
db.yaxis(-0.4:0.2:0.4,2, [2  0.32 -0.47], 'y');
db.zaxis(-0.4:0.2:0.4,2, [2  -0.475 0.3], 'z');
db.plot_close();

% align plots
plots = {
  'chap13_fig03a' 'chap13_fig03b'
  };

db.plot_align_all_axes(plots);

end

function plot_second(db)

db.plot_create('chap13_fig04a', mfilename('fullpath'));
% atlas = coco_bd_read('pillow', 'atlas');
% plot_charts(db, atlas.charts, false);
% db.plot_create_template('pillow', mfilename('fullpath'));

db.plot_use_template('pillow');
db.camproj('perspective');
db.paper_size([6 6]);
db.view([50 24]);
db.box('off');
db.axis([0 1.25 -1.25 1.25 -1.25 1.25], 'equal');
db.xaxis(    0:0.25:1.25,  0:0.5:1, [0  -1.5 -1.8], 'x');
db.yaxis(-1.25:0.25:1.25, -1:0.5:1, [1.5  0.75 -1.7], 'y');
db.zaxis(-1.25:0.25:1.25, -1:0.5:1, [-0.35  -1.5 0.75], 'z');
% db.plot_margin([0.03 0.03 0.0 0.0]);

db.plot_close();

db.plot_create('chap13_fig04b', mfilename('fullpath'));
db.plot_use_template('pillow');
db.camproj('perspective');
db.paper_size([10 6]);
db.box('off');
db.axis([0 1.25 -1.25 1.25 -1.25 1.25], 'equal');
% db.yaxis(-0.2:0.1:0.1,2, [2  0.05 -0.235], 'y');
% db.zaxis(-0.2:0.1:0.2,2, [2  -0.255 0.15], 'z');
% db.plot_margin([0.03 0.03 0.0 0.0]);
db.campos([10 -15 5]);
db.camva(2.5);
db.camtarget([0.4 0.15 0.8]);
db.plot_close();

% align plots' vertical axis
plots = {
  'chap13_fig04a' 'chap13_fig04b'
  };

db.plot_align_axes(plots);

end

function plot_charts(db, charts, id_flag)
f   = @(x) x([1 2 3])';
is_boundary = @(x) any(x.nb==0);
scale = 1;
boundary = [];
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
    chart.v = scale*chart.v;
  else
    chart.v = (scale*chart.R)*ones(size(chart.s,2),1);
  end
  nb = circshift(chart.nb,[0 -1]);
  for l=1:NN-1;
    x   = f(xx+min(chart.R,chart.v(l))*(chart.TS*chart.s(:,l)));
    X   = [ X ; x ];
    tri = [tri ; xo xo+l xo+l+1];
    C   = [ C ; is_boundary(chart)+1 ];
    if nb(l)==0
      boundary = [boundary ; [xo+l xo+l+1]];
    end
  end
  x   = f(xx+min(chart.R,chart.v(NN))*(chart.TS*chart.s(:,NN)));
  X   = [ X ; x ];
  tri = [tri ; xo xo+NN xo+1];
  C   = [ C ; is_boundary(chart)+1 ];
  if nb(NN)==0
    boundary = [boundary ; [xo+NN xo+1]];
  end
end

cmap = [0.9 0.9 0.9 ; 0.8 0.8 0.8];
db.colormap(cmap);
db.trisurf(tri, X(:,1), X(:,2), X(:,3), C, 'EdgeColor', 0.6*[1 1 1], 'LineWidth', 0.5);
if id_flag
  xoff = 0.005;
  for k=1:size(boundary,1)
    x = X(boundary(k,:),1);
    y = X(boundary(k,:),2);
    z = X(boundary(k,:),3);
    db.plot(x+xoff,y,z);
  end
  for k=1:numel(charts)
    db.text(charts{k}.x(1)+xoff, charts{k}.x(2), charts{k}.x(3), ...
      sprintf('%d', charts{k}.id), 'c', 'text2b', ...
      'BackgroundColor', cmap(is_boundary(charts{k})+1,:));
  end
end

end
