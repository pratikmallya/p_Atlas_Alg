function [prob atlas cseg flush] = add_chart(atlas, prob, cseg)

if labindex > 1
    chart    = cseg.curr_chart;
    chart.pt = chart.pt+1;
    if chart.pt>=atlas.cont.PtMX
      chart.pt_type = 'EP';
      chart.ep_flag = 1;
    end
    [prob cseg] = cseg.add_chart(prob, chart);
    flush       = true;

    al = subspace(cseg.ptlist{1}.TS, cseg.ptlist{end}.TS);
    R  = atlas.base_chart.R;
    if al>atlas.cont.almax
      if R>atlas.cont.hmin
        atlas.base_chart.R = max(atlas.cont.hfred*R, atlas.cont.hmin);
        flush              = false;
      end
    elseif al<=atlas.cont.almax/2
      cseg.ptlist{end}.R = min(atlas.cont.hfinc*R, atlas.cont.hmax);
    end
else
    cseg.Status = ~CurveSegmentBase.CurveSegmentOK;
    cseg.isInitialSegment = false;
    flush       = true;
end
end
