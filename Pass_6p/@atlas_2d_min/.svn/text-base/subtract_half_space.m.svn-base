function chart = subtract_half_space(atlas, chart, test, phi, flag, NB)

k        = find(flag & ~circshift(flag, -1), 1);
flag     = circshift(flag, -k(1));
test     = circshift(test, -k(1));
chart.s  = circshift(chart.s, [0, -k(1)]);
chart.v  = circshift(chart.v, -k(1));
chart.nb = circshift(chart.nb, [0, -k(1)]);
j        = find(~flag & circshift(flag, -1), 1);
vx1      = chart.v(j)*chart.s(:,j);
vx2      = chart.v(j+1)*chart.s(:,j+1);
nvx1     = vx1-test(j)/((vx2-vx1)'*phi)*(vx2-vx1);
vx1      = chart.v(end)*chart.s(:,end);
vx2      = chart.v(1)*chart.s(:,1);
nvx2     = vx1-test(end)/((vx2-vx1)'*phi)*(vx2-vx1);
chart.s  = [chart.s(:,1:j), nvx1/norm(nvx1), nvx2/norm(nvx2)];
chart.v  = [chart.v(1:j); norm(nvx1); norm(nvx2)];
chart.nb = [chart.nb(1:j+1), NB];
chart.bv = find(chart.v>atlas.cont.Rmarg*chart.R);

end