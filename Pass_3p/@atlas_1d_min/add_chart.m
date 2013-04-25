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

    if ~atlas.isneighbor(cseg.ptlist{1}, cseg.ptlist{end})
      cseg.ptlist{end}.pt_type = 'GAP';
      cseg.ptlist{end}.ep_flag = 2;
      cseg.Status              = cseg.CurveSegmentCorrupted;
    end
else
     cseg.Status = ~CurveSegmentBase.CurveSegmentOK;
     cseg.isInitialSegment = false;
     flush       = true;

end
end
