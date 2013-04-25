function [prob atlas cseg] = flush(atlas, prob, cseg)

if labindex == 1
     if cseg.isInitialSegment
         atlas.flagarray = ones(1, numlabs);
     else
         [cseg, src, tag] = labReceive();
         atlas.flagarray(src) = 1;
        chart    = cseg.curr_chart;
        chart.pt = chart.pt+1;
        if chart.pt>=atlas.cont.PtMX
          chart.pt_type = 'EP';
          chart.ep_flag = 1;
        end
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
    [atlas.boundary, atlas.flagarray] = scheduleSend(atlas.boundary, cseg.Status, atlas.flagarray);
else

     if ~cseg.isInitialSegment
         labSend(cseg,1);
     end
     dat = labReceive(1);
     
     cseg.Status = dat{1}; % stop FSM
     atlas.boundary = dat{2};
end

end

function [boundary, farray] = scheduleSend(boundary, status, farray)
    if  status == 0
        for i = 2:numlabs
            for j = 1:size(boundary, 1)    
                if farray(i) & boundary{j,end}
                    farray(i) = 0;
                    boundary{j,end} = 0;
                    labSend({status boundary(j, :)}, i);
                    break
                end
            end
        end
    else % terminate all labs
        a = 'done!'
        pause(3);
        for i = 2:numlabs
            if ~farray(i)
                farray(i) = 1;
                dat = labReceive(i);
            end
            labSend({status []}, i);
        end
    end
end
