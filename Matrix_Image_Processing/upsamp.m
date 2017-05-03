function y = upsamp(x,L)
if L==1
    y = x;
else
    M = length(x);
    y = zeros(1,(M-1)*L+1);
    y(1:L:end) = x;
end
end

