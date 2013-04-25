classdef atlas_2d_min < AtlasBase
  
  properties (Access=private)
    base_chart = struct();
    boundary = [];
    charts   = {};
    next_pt  = 0;
    cont     = struct();
    flagarray = [];         % tracks avail. workers
    bound_flag = [];        % tracks avail. charts %%% REMOVE!!%%%
    busy_charts = [];       % tracks busy charts, contains id of busy_charts
  end
  
  methods (Access=private)
    function atlas = atlas_2d_min(prob, cont, dim)
      assert(dim==2, '%s: wrong manifold dimension', mfilename);
      atlas      = atlas@AtlasBase(prob);
      atlas.cont = atlas.get_settings(cont);
    end
  end
  
  methods (Static)
    function [prob cont atlas] = create(prob, cont, dim)
      atlas = atlas_2d_min(prob, cont, dim);
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
  end
  
  methods (Access=private)
    flag = isneighbor(atlas, chart1, chart2)
    [atlas cseg] = merge(atlas, cseg)
  end
  
end
