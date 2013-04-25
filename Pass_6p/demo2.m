%% klein
prob = coco_prob();
prob = coco_set(prob, 'cont', 'atlas', @atlas2_x.create);
prob = coco_set(prob, 'cont', 'PtMX', 20000);
prob = coco_set(prob, 'cont', 'almax', 15);
prob = coco_set(prob, 'cont', 'h', 0.1);
prob = coco_set(prob, 'cont', 'NPR', 100);
prob = coco_add_func(prob, 'klein', @klein, [], 'zero', ...
  'u0', [0; -1-sqrt(2); 0]);
prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
coco(prob, 'klein', [], 2, {'x' 'y' 'z'});

figure(1)
clf
% hold on
% bd = coco_bd_read('klein');
% x  = coco_bd_col(bd, {'x' 'y' 'z'});
% plot3(x(1,:), x(2,:), x(3,:), '.');
atlas = coco_bd_read('klein', 'atlas');
% plot_trisurf(atlas, 1, 2, 3);
plot_charts(atlas, 1, 2, 3);
axis equal
axis tight
view(60,30)
drawnow
return

%% torus
prob = coco_add_func(coco_prob(), 'torus', @torus, [], ...
  'zero', 'u0', [1; 0; 0]);
prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
prob = coco_set(prob, 'cont', 'h', 0.5, 'almax', 25, 'PtMX', 500);
coco(prob, 'torus', [], 2, {'x' 'y' 'z'});

bd = coco_bd_read('torus');
x  = coco_bd_col(bd, {'x' 'y' 'z'});
figure(1)
clf
plot3(x(1,:), x(2,:), x(3,:), '.');
hold on
col = gray(1000);
colormap(col(end-200:end,:))
atlas = coco_bd_read('torus', 'atlas');
plot_charts(atlas.charts(atlas.boundary), 1, 2, 3);
plot_trisurf(atlas.charts, 1, 2, 3);
axis equal
axis tight
view(60,30)
drawnow
