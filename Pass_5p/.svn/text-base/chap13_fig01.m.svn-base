function chap13_fig01
oldpath = path;
try
  compute_run_data();
  db = plotdb(1);
  plot_data(db);
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
if ~coco_exist('sphere1', 'run') || ~coco_exist('sphere2', 'run')
  oldpath = path;
  run demo
  path(oldpath);
end
end

function plot_data(db)

d = cd('..');
N = 16;
M = 5;
[X Y Z]=sphere(N*M);
idx = [1 (1:N)*M+1];
cd(d);

db.plot_create('chap13_fig01a', mfilename('fullpath'));
db.paper_size([8 8]);
db.axis([0 2 -1 1 -1 1], 'equal');
db.view([60 30]);
db.box('off');

bd = coco_bd_read('sphere1');
x  = coco_bd_col(bd, {'x' 'y' 'z'});
db.plot(x(1,:), x(2,:), x(3,:), 'none1', 'marker2l');
db.surf(0.981*X(idx,:)+1,0.981*Y(idx,:),0.981*Z(idx,:), 'FaceColor', 'none', ...
  'EdgeColor', 0.5*[1 1 1], 'MeshStyle', 'row', 'LineWidth', 1);
db.surf(0.981*X(:,idx)+1,0.981*Y(:,idx),0.981*Z(:,idx), 'FaceColor', 'none', ...
  'EdgeColor', 0.5*[1 1 1], 'MeshStyle', 'column', 'LineWidth', 1);
db.surf(0.98*X+1,0.98*Y,0.98*Z, 'EdgeColor', 'none', ...
  'FaceColor', 0.8*[1 1 1], 'FaceAlpha', 0.999);

db.xaxis( 0:2,2, [0.5 -1.25 -1.25], 'x');
db.yaxis(-1:1,2, [2.5  0.3 -1.0], 'y');
db.zaxis(-1:1,2, [-0.2 -1.2 0.5], 'z');
db.plot_margin([0.0 0.0 0.0 0.01]);
db.plot_close();

db.plot_create('chap13_fig01b', mfilename('fullpath'));
db.paper_size([8 8]);
db.axis([0 2 -1 1 -1 1], 'equal');
db.view([60 30]);
db.box('off');

bd = coco_bd_read('sphere2');
x  = coco_bd_col(bd, {'x' 'y' 'z'});
db.plot(x(1,:), x(2,:), x(3,:), 'none1', 'marker2l');
db.surf(0.981*X(idx,:)+1,0.981*Y(idx,:),0.981*Z(idx,:), 'FaceColor', 'none', ...
  'EdgeColor', 0.5*[1 1 1], 'MeshStyle', 'row', 'LineWidth', 1);
db.surf(0.981*X(:,idx)+1,0.981*Y(:,idx),0.981*Z(:,idx), 'FaceColor', 'none', ...
  'EdgeColor', 0.5*[1 1 1], 'MeshStyle', 'column', 'LineWidth', 1);
db.surf(0.98*X+1,0.98*Y,0.98*Z, 'EdgeColor', 'none', ...
  'FaceColor', 0.8*[1 1 1], 'FaceAlpha', 0.999);

db.xaxis( 0:2,2, [0.5 -1.25 -1.25], 'x');
db.yaxis(-1:1,2, [2.5  0.3 -1.0], 'y');
db.zaxis(-1:1,2, [-0.2 -1.2 0.5], 'z');
db.plot_margin([0.0 0.0 0.0 0.01]);
db.plot_close();

% align plots
plots = {
  'chap13_fig01a' 'chap13_fig01b'
  };

db.plot_align_all_axes(plots);

end
