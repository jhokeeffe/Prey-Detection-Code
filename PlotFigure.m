close all;
%importdata('PATH\PlotData.mat'); %Import data to plot

filter2p = filter2;
filter2n = filter2;
filter2p(filter2p(:,:,:)<0)=0;
filter2n(filter2n(:,:,:)>0)=0;

Contourlevel2 = abs(max(max(filter2p)))*0.1;
levels2 = [Contourlevel2*1 Contourlevel2*3 Contourlevel2*5 Contourlevel2*7 Contourlevel2*9]; %set 2nd layer contour lines
xlim3 = [100*1000/300 440*1000/300];
ylim3 = 5e4;
xlim2 = 0.0005;
ylim2 = [-1 5];
xlim1 = 0.005;
ylim1 = [0 30];
axisOffset = 0;


figure(1)
%%%%%%%FOURIER MOTION%%%%%%%%%
subplot(5,3,1)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanaFM);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r','LineWidth',2)
title('Input Stimuli Fourier transform')
xlim([-xlim1 xlim1])
ylim(ylim1)
set(gca,'ydir','norm');
%ylabel('Temporal Frequency (Hz)')
subplot(5,3,2)
imagesc(FourSpat-axisOffset, FourTempb, FTmeanbFM);
caxis([0 3000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,levels2,'LineColor','r','LineWidth',2)
contour(FourSpat-axisOffset, FourTempb, filter2n,-levels2,'LineColor','b','LineWidth',2)
title('Position Sensor Output Fourier transform')
xlim([-xlim2 xlim2])
ylim(ylim2)
set(gca,'ydir','norm');
subplot(5,3,3)
plot((0:size(rsumLRFM,2)-1)*1000/300, rsumLRFM, 'b')
hold on
plot((0:size(rsumLRFM,2)-1)*1000/300, rsumRLFM, 'r')
plot([100*1000/300 460*1000/300],[0 0],'k','clipping','off')
errorbar(450*1000/300,mean(rsumLRFM(100:440)),std(rsumLRFM(100:440)),'bo','clipping','off')
errorbar(450*1000/300,mean(rsumRLFM(100:440)),std(rsumRLFM(100:440)),'ro','clipping','off')
xlim(xlim3)
ylim([-ylim3 ylim3])
title('Motion Detection Model response')
legend({'Left - Right stimuli','Right - Left stimuli'}, 'FontSize', 5)
%%%%%%%%THETA MOTION%%%%%%%%%%%%%%
subplot(5,3,4)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanaTM);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r','LineWidth',2)
xlim([-xlim1 xlim1])
ylim(ylim1)
set(gca,'ydir','norm');
%ylabel('Temporal Frequency (Hz)')
subplot(5,3,5)
imagesc(FourSpat-axisOffset, FourTempb, FTmeanbTM);
caxis([0 3000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,levels2,'LineColor','r','LineWidth',2)
contour(FourSpat-axisOffset, FourTempb, filter2n,-levels2,'LineColor','b','LineWidth',2)
xlim([-xlim2 xlim2])
ylim(ylim2)
set(gca,'ydir','norm');
subplot(5,3,6)
plot((0:size(rsumLRTM,2)-1)*1000/300, rsumLRTM, 'b')
hold on
plot((0:size(rsumLRTM,2)-1)*1000/300, rsumRLTM, 'r')
plot([100*1000/300 460*1000/300],[0 0],'k','clipping','off')
errorbar(450*1000/300,mean(rsumLRTM(100:440)),std(rsumLRTM(100:440)),'bo','clipping','off')
errorbar(450*1000/300,mean(rsumRLTM(100:440)),std(rsumRLTM(100:440)),'ro','clipping','off')
xlim(xlim3)
ylim([-ylim3 ylim3])
%%%%%%DRIFT BALANCED%%%%%%%%%%%%%%
subplot(5,3,7)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanaDB);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r','LineWidth',2)
xlim([-xlim1 xlim1])
ylim(ylim1)
set(gca,'ydir','norm');
ylabel('Temporal Frequency (Hz)')
subplot(5,3,8)
imagesc(FourSpat-axisOffset, FourTempb, FTmeanbDB);
caxis([0 3000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,levels2,'LineColor','r','LineWidth',2)
contour(FourSpat-axisOffset, FourTempb, filter2n,-levels2,'LineColor','b','LineWidth',2)
xlim([-xlim2 xlim2])
ylim(ylim2)
set(gca,'ydir','norm');
ylabel('Temporal Frequency (Hz)')
subplot(5,3,9)
hold on
plot((0:size(rsumLRDB,2)-1)*1000/300, rsumLRDB, 'b')
hold on
plot((0:size(rsumLRDB,2)-1)*1000/300, rsumRLDB, 'r')
plot([100*1000/300 460*1000/300],[0 0],'k','clipping','off')
errorbar(450*1000/300,mean(rsumLRDB(100:440)),std(rsumLRDB(100:440)),'bo','clipping','off')
errorbar(450*1000/300,mean(rsumRLDB(100:440)),std(rsumRLDB(100:440)),'ro','clipping','off')
xlim(xlim3)
ylim([-ylim3 ylim3])
ylabel('Summed Opponent Energy of Reichardt Detector Array (arbitrary units)')
%%%%%%%%%ELEMENTARY MOTION %%%%%%%%%%%%%%%
subplot(5,3,10)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanaEM);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r','LineWidth',2)
xlim([-xlim1 xlim1])
ylim(ylim1)
set(gca,'ydir','norm');
subplot(5,3,11)
imagesc(FourSpat-axisOffset, FourTempb, FTmeanbEM);
caxis([0 3000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,levels2,'LineColor','r','LineWidth',2)
contour(FourSpat-axisOffset, FourTempb, filter2n,-levels2,'LineColor','b','LineWidth',2)
xlim([-xlim2 xlim2])
ylim(ylim2)
set(gca,'ydir','norm');
subplot(5,3,12)
plot((0:size(rsumLREM,2)-1)*1000/300, rsumLREM, 'b')
hold on
plot((0:size(rsumLREM,2)-1)*1000/300, rsumRLEM, 'r')
plot([100*1000/300 460*1000/300],[0 0],'k','clipping','off')
errorbar(450*1000/300,mean(rsumLREM(100:440)),std(rsumLREM(100:440)),'bo','clipping','off')
errorbar(450*1000/300,mean(rsumRLEM(100:440)),std(rsumRLEM(100:440)),'ro','clipping','off')
xlim(xlim3)
ylim([-ylim3 ylim3])
%%%%%%%%%%LUM FLIP%%%%%%%%%%%%
subplot(5,3,13)
imagesc(FourSpat-axisOffset, FourTemp, FTmeanaLF);
caxis([0 50000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTemp, filter1,'LineColor','r','LineWidth',2)
xlim([-xlim1 xlim1])
ylim(ylim1)
set(gca,'ydir','norm');
xlabel('Spatial Frequency (cycles/deg)')
subplot(5,3,14)
imagesc(FourSpat-axisOffset, FourTempb, FTmeanbLF);
caxis([0 3000000]);
colormap gray
hold on
contour(FourSpat-axisOffset, FourTempb, filter2p,levels2,'LineColor','r','LineWidth',2)
contour(FourSpat-axisOffset, FourTempb, filter2n,-levels2,'LineColor','b','LineWidth',2)
xlabel('Spatial Frequency (cycles/deg)')
xlim([-xlim2 xlim2])
ylim(ylim2)
set(gca,'ydir','norm');
subplot(5,3,15)
plot((0:size(rsumLRLF,2)-1)*1000/300, rsumLRLF, 'b')
hold on
plot((0:size(rsumLRLF,2)-1)*1000/300, rsumRLLF, 'r')
plot([100*1000/300 460*1000/300],[0 0],'k','clipping','off')
errorbar(450*1000/300,mean(rsumLRLF(100:440)),std(rsumLRLF(100:440)),'bo','clipping','off')
errorbar(450*1000/300,mean(rsumRLLF(100:440)),std(rsumRLLF(100:440)),'ro','clipping','off')
xlim(xlim3)
ylim([-ylim3 ylim3])
xlabel('Time (ms)')
    