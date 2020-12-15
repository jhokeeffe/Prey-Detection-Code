function [filter] = getNormalisedLoFilterPhase(f_B1,f_A1,n)
[h,w] = freqz(f_B1, f_A1,n);
raw = rot90(unwrap(angle(h))*180/pi);
crop = raw(2:(size(raw,2)));
filter = [-fliplr(crop) 0 crop crop(size(crop,2))];
close
end