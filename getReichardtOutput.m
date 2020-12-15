function [RD] = getReichardtOutput(input, h, Tr, lpf_B, lpf_A, hpf_B, hpf_A)
    for i=1:size(input,3)
        %Spatial Filtering
        G=double(input(:,:,i));    
        G_TRAN = imtranslate(G, [Tr 0]);
        IMAGEN(:,:,i) = imgaussfilt(G,h);   
        IMAGEN_TRAN(:,:,i) = imgaussfilt(G_TRAN,h);

    end
%Temporal Filtering
B1_LP = filter(lpf_B, lpf_A, IMAGEN,[],3);
B1_HP = filter(hpf_B, hpf_A, IMAGEN,[],3);
B2_LP = filter(lpf_B, lpf_A, IMAGEN_TRAN,[],3);
B2_HP = filter(hpf_B, hpf_A, IMAGEN_TRAN,[],3);

%Hassenstein-Reichardt Detector
M1=(B1_HP.*B2_LP);
M2=(B2_HP.*B1_LP);
RD=(M1-M2);
end