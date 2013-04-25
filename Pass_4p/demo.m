echo on
%!tkn1
prob = coco_add_func(coco_prob(), 'sphere', @sphere, [], ...
  'zero', 'u0', [2; 0; 0]);
prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
prob = coco_set(prob, 'cont', 'h', 0.5, 'almax', 35);
%coco(prob, 'sphere', [], 2, {'x' 'y' 'z'});
%!tkn2
prob = coco_set(prob, 'cont', 'Ndirs', 4, 'PtMX', 300);
coco(prob, 'sphere', [], 2, {'x' 'y' 'z'});
%!tkn3
echo off
