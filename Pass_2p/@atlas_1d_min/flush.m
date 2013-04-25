function [prob atlas cseg] = flush(atlas, prob, cseg)

if labindex == 1
    if ~cseg.isInitialSegment
         cseg = labReceive(2);
    end

    [prob atlas cseg] = atlas.flush@AtlasBase(prob, cseg);
    if cseg.Status==cseg.CurveSegmentOK
      atlas.base_chart = cseg.ptlist{end};
      if atlas.base_chart.pt>=atlas.cont.PtMX
        cseg.Status = cseg.BoundaryPoint;
      end
    end
    
    labSend({cseg.Status atlas.base_chart},2);

else
    if ~cseg.isInitialSegment
       labSend(cseg,1);
    end
    dat = labReceive(1);
         
    cseg.Status = dat{1}; % stop FSM
    atlas.base_chart = dat{2};

end
end
