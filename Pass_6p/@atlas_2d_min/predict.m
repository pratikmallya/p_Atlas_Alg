function [prob atlas cseg correct] = predict(atlas, prob, cseg)
if labindex > 1
    chart  = atlas.base_chart;
    s      = chart.s(:,chart.bv(1));
    h      = atlas.cont.Rmarg*chart.R;
    prcond = struct('x', chart.x, 'TS', chart.TS, 's', s, 'h', h);
    th     = atlas.cont.theta;
    if th>=0.5 && th<=1
      xp          = chart.x+(th*h)*(chart.TS*s);
      [prob cseg] = CurveSegment.create(prob, chart, prcond, xp);
      [prob ch2]  = cseg.update_TS(prob, cseg.curr_chart);
      s           = h*(ch2.TS'*chart.TS*s);
      h           = norm(s);
      s           = s/h;
      xp          = chart.x+h*(ch2.TS*s);
      prcond      = struct('x', chart.x, 'TS', ch2.TS, 's', s, 'h', h);
    else
      xp          = chart.x+h*(chart.TS*s);
    end
    [prob cseg] = CurveSegment.create(prob, chart, prcond, xp);
    correct     = true;
else
    [prob cseg] = CurveSegment.create_initial(prob, atlas.charts{atlas.boundary(1)}, false);
    correct     = false;

end
end
