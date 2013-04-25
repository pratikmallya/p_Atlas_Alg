function [prob atlas cseg] = flush(atlas, prob, cseg)

if labindex == 1
     if cseg.isInitialSegment
         atlas.flagarray = ones(1, numlabs);
     else
         [cseg, src, tag] = labReceive();
         atlas.flagarray(src) = 1;
     end

    if cseg.Status==cseg.CurveSegmentOK
      [atlas cseg] = atlas.merge(cseg);
    end
    [prob atlas cseg] = atlas.flush@AtlasBase(prob, cseg);
    if cseg.Status==cseg.CurveSegmentOK
      if isempty(atlas.boundary) || ...
          (atlas.boundary{1,1}.pt>=atlas.cont.PtMX)
        cseg.Status = cseg.BoundaryPoint;
      end
    end
    % logic for scheduling job amongst workers
    scheduleSend(atlas.boundary, cseg.Status, atlas.flagarray);
else

     if ~cseg.isInitialSegment
         labSend(cseg,1);
     end
     dat = labReceive(1);
     
     cseg.Status = dat{1}; % stop FSM
     atlas.boundary = dat{2};
end

end

function scheduleSend(boundary, status, farray)
    if ~isempty(boundary)
        for i = 2:numlabs
            if ~isempty(boundary)
                farray(i) = 0;     
                labSend({status boundary(1, :)}, i);
            end
        end
    else
        for i = 2:numlabs
            farray
            if ~farray(i)
                farray(i) = 1;
                dat = labReceive(i);
            end
            labSend({status []}, i);
        end
    end
end
