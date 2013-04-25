function [prob atlas cseg] = flush(atlas, prob, cseg)

if labindex == 1
     if cseg.isInitialSegment
         atlas.flagarray = ones(1, numlabs);
     else
         [cseg, src, tag] = labReceive();
         atlas.flagarray(src) = 1;
         atlas.busy_charts(atlas.busy_charts == cseg.ptlist{1,1}.id) = [];
         for i = 2:numel(cseg.ptlist)   
         %% fix the chart ids so they are unique
            chart         = cseg.ptlist{1,i};
            chart.pt      = atlas.next_pt;
            atlas.next_pt = atlas.next_pt + 1;
            chart.id      = chart.pt+1;
            cseg.ptlist{1,i}= chart;
            
         end
     end
    if cseg.Status==cseg.CurveSegmentOK
      [atlas cseg] = atlas.merge(cseg);
    end
    [prob atlas cseg] = atlas.flush@AtlasBase(prob, cseg);
    if cseg.Status==cseg.CurveSegmentOK
      if isempty(atlas.boundary) || (atlas.next_pt>atlas.cont.PtMX)
        cseg.Status = cseg.BoundaryPoint;
      end
    end
    [atlas.flagarray, atlas.busy_charts] = scheduleSend(atlas.boundary, cseg.Status, atlas.flagarray, atlas.busy_charts, atlas.charts);

else
     if ~cseg.isInitialSegment
         labSend(cseg,1);
     end
     dat = labReceive(1);
     cseg.Status = dat{1}; % stop FSM
     atlas.base_chart = dat{2};
end

function [farray, busy_charts] = scheduleSend(boundary, status, farray, busy_charts, charts)
     if  status == 0
         for i = 2:numlabs
            for j = 1:numel(boundary)        
            if farray(i) & ~(ismember(charts{boundary(j)}.id, busy_charts)) 
                     farray(i) = 0;
                     busy_charts(end + 1) = charts{boundary(j)}.id;
                     labSend({status charts{boundary(j)}}, i);
                     break
                 end
            end
         end
     else % terminate all labs
         for i = 2:numlabs
             if ~farray(i)
                 farray(i) = 1;
                 dat = labReceive(i);
             end
             labSend({status []}, i);
         end
        % print all the chat ids to make sure that they are unique
        %for i = 1:numel(charts)
        %    charts{i}.pt
        %end
     end
end


end
