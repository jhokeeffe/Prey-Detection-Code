function [filter] = getNormalisedLoFilterResponse(f_B1,f_A1,n)
[h,w] = freqz(f_B1, f_A1,n);
raw = rot90((abs(h)));
crop = raw(2:(size(raw,2)));
norm = crop;
filter = [fliplr(norm) 1 norm norm(:,end)];
close
end