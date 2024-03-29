%echo on
%!tkn1
prob = coco_add_func(coco_prob(), 'circle', @circle, [], ...
  'zero', 'u0', [1.5; 1]);
prob = coco_add_pars(prob, '', [1 2], {'x' 'y'});
prob = coco_set(prob, 'cont', 'PtMX', 100);
coco(prob, '1', [], 1, {'x' 'y'});
return
%!tkn2
prob = coco_add_func(coco_prob(), 'ellipse', @ellipse, [], ...
  'zero', 'u0', [0.6; 0.5]);
prob = coco_add_pars(prob, '', [1 2], {'x' 'y'});
coco(prob, '1', [], 1, {'x' 'y'});
%!tkn3
prob = coco_add_func(coco_prob(), 'circle', @circle, [], ...
  'zero', 'u0', [1.5; 1]);
prob = coco_add_pars(prob, '', [1 2], {'x' 'y'});
coco(prob, '1', [], 1, {'x' 'y'}, [2 3]);
%!tkn4
coco(prob, '1', [], 1, {'x' 'y'}, [1 2]);
%!tkn5
echo off
