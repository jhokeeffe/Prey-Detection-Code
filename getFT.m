function [FTmean] = getFT(input)
    x=1:1:size(input,2);
    y=1:1:size(input,3);
    for j=1:size(input,1)
        row(:,:)=input(j,:,:);    
        [FT(j,:,:),freqx(j,:,:),freqy(j,:,:)] = jfft2(x,y,row); 
        %jfft2 is a version of MATLAB's fft2 function modified by Jenny Read    
    end
    %Get real components of Fourier transform
    FTmean=mean(abs(FT));
    FTmean=squeeze(FTmean);
end