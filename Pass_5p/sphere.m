function [data y] = sphere(opts, data, u)
  y = (u(1)-1)^2+u(2)^2+u(3)^2-1;
end