
%%%%%%%%%%% OVERHEADS %%%%%%%%%%%%%

px2deg = 1/6.5;
FrameRate = 60;
n = 5;
SampleRate = n*FrameRate;   
   




%%%%%%%%%% GENERATE SINE STIMULI %%%%%%%%%%%%%

vid = double(FM); %Set stimulus as double array
vid = vid-(max(max(max(vid)))/2); %Set the range of values in stimuli to be [-max +max]
videofile2 = repelem(vid,1,1,n); %Simulate sample rate = n*frameRate

FourTemp = ((1:size(videofile2,3))-ceil(size(videofile2,3)/2))*(SampleRate/size(videofile2,3)); %Temporal domain scale (first layer input)
FourTempb = ((1:size(videofile2(:,:,41:440),3))-ceil(size(videofile2(:,:,41:440),3)/2))*(SampleRate/size(videofile2(:,:,41:440),3)); %Temporal domain scale (second layer input)

FourSpatPx = -(0.5/((size(videofile2,2)/2)))*fliplr((0:size(videofile2,2)-1)-(size(videofile2,2)/2)); %Spatial domain scale px
FourSpat = -(0.5*px2deg/((size(videofile2,2)/2)))*fliplr((0:size(videofile2,2)-1)-(size(videofile2,2)/2)); %Spatial domain scale cycles/deg

if mod(size(videofile2,2),2) ~= 0 %Fix in case of odd # of data entries
    axisOffset = (0.5*0.5*(1/px2deg)/(size(videofile2,2)/2));
else
    axisOffset = 0;
end


%%%%%%%%%% POSITION SENSOR %%%%%%%%%%%%
SD1 = 10*px2deg; %Std Dev of Gaussian spatial filter at first layer
tau_hpf1 = 20e-3; % First layer high pass filter time constant (seconds)
hpc1 = 1/(2*pi*tau_hpf1); % HPF cutoff frequency (Hz)
[hpf_B1, hpf_A1] = butter(1, hpc1/(SampleRate/2), 'high'); %generate 1st order high pass butterworth filter
PosLR = getPositionOutput(videofile2,(SD1/px2deg),hpf_B1, hpf_A1).^2; % Get 1st layer output for L-R stimulus
PosRL = getPositionOutput(flip(videofile2,2),(SD1/px2deg),hpf_B1, hpf_A1).^2; % Get 1st layer output for R-L stimulus



%%%%%%%%%% REICHARDT DETECTOR %%%%%%%%%%
OmmSpacing = 148*px2deg; %Interommatidial spacing

tau_hpf2 = 250e-3; % Second layer high pass filter time constant (seconds)
tau_lpf2 = 200e-3; % Second layer low pass filter time constant (seconds)

hpc2 = 1/(2*pi*tau_hpf2); % HPF cutoff frequency (Hz)
lpc2 = 1/(2*pi*tau_lpf2); % LPF cutoff frequency (Hz)
[hpf_B2, hpf_A2] = butter(1, hpc2/(SampleRate/2), 'high'); %generate 1st order high pass butterworth filter
[lpf_B2, lpf_A2] = butter(1, lpc2/(SampleRate/2), 'low'); %generate 1st order low pass butterworth filter
SD2 = 80*px2deg; %Std Dev of Gaussian spatial filter at second layer

RDLR=getReichardtOutput(PosLR,(SD2/px2deg),OmmSpacing/px2deg,lpf_B2, lpf_A2,hpf_B2, hpf_A2); %Get second layer output L-R
rLR = squeeze(sum(RDLR,1)); %Collapse output array vertically (for horizontal motion)
rsumLR = sum(rLR,1)/size(rLR,1); %Get directional RD response (mean average)

RDRL=getReichardtOutput(PosRL,(SD2/px2deg),OmmSpacing/px2deg,lpf_B2, lpf_A2,hpf_B2, hpf_A2); %Get second layer output R-L
rRL = squeeze(sum(RDRL,1)); %Collapse output array vertically (for horizontal motion)
rsumRL = sum(rRL,1)/size(rRL,1); %Get directional RD response (mean average)

%%%%%%%%%%% STIMULI FT & FILTER RESPONSES %%%%%%%%%%%

FTmeana=fliplr(rot90(getFT(videofile2))); %Get fourier transform of stimuli
FTmeanb=fliplr(rot90(getFT(PosLR(:,:,41:440)))); %Get fourier transform of first layer output

gauss1FT = exp(-(FourSpatPx.^2)/(2/((2*pi*SD1/px2deg)^2))); %First layer gaussian filter frequency response (units:pixels)
gauss2FT = exp(-(FourSpatPx.^2)/(2/((2*pi*SD2/px2deg)^2))); %Second layer gaussian filter frequency response (units:pixels)
SpatPhaseDif = sin(2*pi*(FourSpat.*(OmmSpacing))); %Phase difference of gaussian filters at each ommatidia (units:degrees)

hitemp1cont=getNormalisedHiFilterResponse(hpf_B1, hpf_A1,size(videofile2,3)/2); %Normalised first layer high pass temporal filter frequency response 
hitemp1phase = getNormalisedHiFilterPhase(hpf_B1, hpf_A1,size(videofile2,3)/2); %Normalised first layer high pass temporal filter phase response
hitemp2cont=getNormalisedHiFilterResponse(hpf_B2, hpf_A2,size(videofile2(:,:,41:440),3)/2); %Normalised second layer high pass temporal filter frequency response 
hitemp2phase = getNormalisedHiFilterPhase(hpf_B2, hpf_A2,size(videofile2(:,:,41:440),3)/2); %Normalised second layer high pass temporal filter phase response

lotemp2cont = getNormalisedLoFilterResponse(lpf_B2, lpf_A2,size(videofile2(:,:,41:440),3)/2); %Normalised second layer low pass temporal filter frequency response 
lotemp2phase = getNormalisedLoFilterPhase(lpf_B2, lpf_A2,size(videofile2(:,:,41:440),3)/2); %Normalised second layer low pass temporal filter phase response
TempPhaseDif = sin((hitemp2phase- lotemp2phase).*pi/180); %Phase difference of second layer temporal filters
magTerms = rot90(hitemp2cont.*lotemp2cont,-1)*(gauss2FT.^2); % Second layer SpatialTemporal frequency response
phaseTerms = rot90(TempPhaseDif,-1)*SpatPhaseDif; % Second Layer SpatialTemporal phase response

filter1=rot90(hitemp1cont,-1)*gauss1FT; %First layer filter response
filter2 = magTerms.*phaseTerms; %Second layer filter response


%%% DISPLAY OUTPUT %%%
filter2p = filter2;
filter2n = filter2;
filter2p(filter2p(:,:,:)<0)=0;
filter2n(filter2n(:,:,:)>0)=0; %Separate directional components of second layer filter response for plotting

figure(1) 

subplot(1,3,1)
plot(rsumLR, 'b')
hold on
plot(rsumRL, 'r')
title('Reichardt response')
subplot(1,3,2)
imagesc(FourSpat-axisOffset, FourTemp, FTmeana);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r')
title('Input Fourier transform')
xlabel('Spatial Frequency (cycles/deg)')
ylabel('Temporal Frequency (Hz)')
subplot(1,3,3)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanb);
caxis([0 5000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,6,'LineColor','r')
contour(FourSpat-axisOffset, FourTempb, filter2n,6,'LineColor','b')
title('Output Fourier transform')
xlabel('Spatial Frequency (cycles/deg)')
ylabel('Temporal Frequency (Hz)')
    


