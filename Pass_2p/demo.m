echo on
%!tkn1
prob = coco_add_func(coco_prob(), 'ellipse', @ellipse, [], ...
  'zero', 'u0', [0.7; 0.8]);
prob = coco_set(prob, 'cont', 'PtMX', 20, 'hmin', 0.065);
bd = coco(prob, '1', [], 1);
coco_bd_col(bd, 'StepSize')
%!tkn2
echo off
% theta == 0 : tangent predictor (explicit Euler)
prob = coco_prob();
prob = coco_set(prob, 'cont', 'atlas', @atlas_1d_min.create);
pprob = coco_set(prob, 'cont', 'theta', 0, 'PtMX', 5);
pprob = coco_add_func(pprob, 'circle', @ellipse, [], 'zero', 'u0', [1.2;0.9] );
pprob = coco_add_pars(pprob, '', [1 2], {'x' 'y'});
coco(pprob, 'th1', [], 1, {'x' 'y'});
% theta = 0.5 : linearly implicit mid-point rule
prob = coco_prob();
prob = coco_set(prob, 'cont', 'atlas', @atlas_1d_min.create);
pprob = coco_set(prob, 'cont', 'theta', 0.5, 'PtMX', 5);
pprob = coco_add_func(pprob, 'circle', @ellipse, [], 'zero', 'u0', [1.2;0.9] );
pprob = coco_add_pars(pprob, '', [1 2], {'x' 'y'});
coco(pprob, 'th2', [], 1, {'x' 'y'});
% theta = 1 : linearly implicit Euler
prob = coco_prob();
prob = coco_set(prob, 'cont', 'atlas', @atlas_1d_min.create);
pprob = coco_set(prob, 'cont', 'theta', 1, 'PtMX', 5);
pprob = coco_add_func(pprob, 'circle', @ellipse, [], 'zero', 'u0', [1.2;0.9] );
pprob = coco_add_pars(pprob, '', [1 2], {'x' 'y'});
coco(pprob, 'th3', [], 1, {'x' 'y'});
coco_view_log('th1', 'type')
coco_view_log('th2', 'type')
coco_view_log('th3', 'type')