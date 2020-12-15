function [P] = getPositionOutput(input, h, hpf_B, hpf_A)
for i=1:size(input,3)
    %Spatial Filtering
    IMAGEN(:,:,i) = imgaussfilt(double(input(:,:,i)),h);       
 
end
%Temporal filtering
P=filter(hpf_B, hpf_A, IMAGEN,[],3);
end