function [filter] = getNormalisedHiFilterResponse(f_B1,f_A1,n)
[h,w] = freqz(f_B1, f_A1,n);

raw = rot90((abs(h)));
crop = raw(2:(size(raw,2)));
norm = crop;
filter = [fliplr(norm) 0 norm 1];
close
end