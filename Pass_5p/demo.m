echo on
%!tkn1
prob = coco_add_func(coco_prob(), 'sphere', @sphere, [], ...
  'zero', 'u0', [2;0;0]);
prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
prob = coco_set(prob, 'cont', 'h', 0.5, 'almax', 35);
coco(prob, 'sphere1', [], 2, {'x' 'y' 'z'});
%!tkn2
prob = coco_set(prob, 'cont', 'Ndirs', 4, 'PtMX', 200);
coco(prob, 'sphere2', [], 2, {'x' 'y' 'z'});
%!tkn3
echo off
figure(1)
clf
d = cd('..');
[X Y Z]=sphere(16);
cd(d);
bd = coco_bd_read('sphere1');
x  = coco_bd_col(bd, {'x' 'y' 'z'});
subplot(1,2,1)
plot3(x(1,:), x(2,:), x(3,:), 'k.', 'MarkerSize', 12);
hold on
surf(0.99*X+1,0.99*Y,0.99*Z, 'EdgeColor', 0.7*[1 1 1], ...
  'FaceColor', 0.8*[1 1 1]);
hold off
view(60,30)
grid on
axis([0 2 -1 1 -1 1]);
axis equal
drawnow

bd = coco_bd_read('sphere2');
x  = coco_bd_col(bd, {'x' 'y' 'z'});
subplot(1,2,2)
plot3(x(1,:), x(2,:), x(3,:), 'k.', 'MarkerSize', 12);
hold on
surf(0.99*X+1,0.99*Y,0.99*Z, 'EdgeColor', 0.7*[1 1 1], ...
  'FaceColor', 0.8*[1 1 1]);
hold off
view(60,30)
grid on
axis([0 2 -1 1 -1 1]);
axis equal
drawnow
