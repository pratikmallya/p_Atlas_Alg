function [data y] = pillow(opts, data, u)
  y = u(1)^4+u(2)^4+u(3)^4-u(1)^2-u(2)^2-u(3)^2;
end