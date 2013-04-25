echo on
%!tkn1
prob = coco_add_func(coco_prob(), 'pillow', @pillow, [], ...
  'zero', 'u0', [1; 0; 0]);
prob = coco_add_pars(prob, '', [1 2 3], {'x' 'y' 'z'});
prob = coco_set(prob, 'cont', 'PtMX', 1000, 'NPR', 200);
prob = coco_set(prob, 'cont', 'h', 0.15, 'almax', 30);
coco(prob, 'pillow', [], 2, {'x' 'y' 'z'});
%!tkn2
echo off