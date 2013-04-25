classdef atlas_1d_min < AtlasBase
  
  properties (Access=private)
    base_chart = struct();
    cont       = struct();
  end
  
  methods (Access=private)
    function atlas = atlas_1d_min(prob, cont, dim)
      assert(dim==1, '%s: wrong manifold dimension', mfilename);
      atlas      = atlas@AtlasBase(prob);
      atlas.cont = atlas.get_settings(cont);
    end
  end
  
  methods (Static)
    function [prob cont atlas] = create(prob, cont, dim)
      atlas = atlas_1d_min(prob, cont, dim);
      prob  = CurveSegment.add_prcond(prob, dim);
    end
  end
  
  methods (Static, Access=private)
    cont = get_settings(cont)
  end
  
  methods (Access=public)
    [prob atlas cseg correct] = init_prcond(atlas, prob, chart)
    [prob atlas cseg flush]   = init_atlas (atlas, prob, cseg)
    [prob atlas cseg]         = flush      (atlas, prob, cseg)
    [prob atlas cseg correct] = predict    (atlas, prob, cseg)
    [prob atlas cseg flush]   = add_chart  (atlas, prob, cseg)
    [prob atlas cseg predict] = refine_step(atlas, prob, cseg)
  end
  
end