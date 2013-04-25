function [data y] = torus(opts, data, u)
  y = (2-sqrt(u(1)^2+u(2)^2))^2+u(3)^2- 1;
end
