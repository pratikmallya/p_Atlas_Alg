function [prob atlas cseg correct] = predict(atlas, prob, cseg)
if labindex > 1
    [chart xp s h] = atlas.boundary{1,:};
    prcond         = struct('x', chart.x, 'TS', chart.TS, 's', s, 'h', h);
    th             = atlas.cont.theta;
    if th>=0.5 && th<=1
      xp          = chart.x+(th*h)*(chart.TS*s);
      [prob cseg] = CurveSegment.create(prob, chart, prcond, xp);
      [prob ch2]  = cseg.update_TS(prob, cseg.curr_chart);
      h           = h*(ch2.TS'*chart.TS);
      xp          = chart.x+h*(ch2.TS*s);
      prcond      = struct('x', chart.x, 'TS', ch2.TS, 's', s, 'h', h);
    end
    [prob cseg] = CurveSegment.create(prob, chart, prcond, xp);
    correct     = true;
else
    [prob cseg]   = CurveSegment.create_initial(prob, atlas.boundary{1,1}, false);
    correct     = false;

end
end
