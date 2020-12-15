function [filter] = getNormalisedHiFilterPhase(f_B1,f_A1,n)
[h,w] = freqz(f_B1, f_A1,n);
raw = rot90(unwrap(angle(h))*180/pi);
crop = raw(2:(size(raw,2)));
filter = [-fliplr(crop) 90 crop(1:size(crop,2)) crop(size(crop,2))];
close
end