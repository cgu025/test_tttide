%%
% this is to calculate tide 2.

function [lmax,lmin,Ic] = T_ellipse(uam,uph,vam,vph,sc,lat,t,p,m1,dep)
%
wk1   = 2*pi/(23.934469*3600);
wo1   = 2*pi/(25.81934 *3600);
wp1   = 2*pi/(24.06589 *3600);
wq1   = 2*pi/(26.86836 *3600);
wm2   = 2*pi/(12.420601*3600);
ws2   = 2*pi/(12.0     *3600);
wn2   = 2*pi/(12.658348*3600);
wk2   = 2*pi/(12.967234*3600);
wf    = 2*(2*pi/(24*3600))*sin(lat*pi/180);  % Local inertial frequency f=2*Omiga*sin(latitude) 
%
frequency =[wk1 wo1 wp1 wq1 wm2 ws2 wn2 wk2 wf];
CA = ['K1';'O1';'P1';'Q1';'M2';'S2';'N2';'K2';'f '];
for i=1:size(CA,1)
    if strcmp(CA(i,:),sc) == 1
        w = frequency(i);
    end
end
%%
for i=1:length(t)
    uel(i) = uam * cos(w*t(i)+uph/180*pi);
    vel(i) = vam * cos(w*t(i)+vph/180*pi);
end
L    = sqrt(uel.^2+vel.^2);
lmax = max(L); lmin = min(L);                               % 长轴和短轴
maxP = find(L == max(L));   
minP = find(L == min(L));

     %%  绘制潮流椭圆
      ha = subplot(3,1,1);      

%      subplot('Position',[0.05+(p(3)-1)*0.25,0.1,0.18,0.8],'parent',gcf);
     plot(uel,vel-dep(m1),'m','LineWidth',1);
     hold on;
     plot(uel(maxP),vel(maxP)-dep(m1),'c.'),plot(-uel(maxP),-vel(maxP)-dep(m1),'c.')
     plot(uel(minP),vel(minP)-dep(m1),'g.'),plot(-uel(minP),-vel(minP)-dep(m1),'g.')
     xlabel('U (cm/s)','fontsize',12);
     title([sc],'fontsize',14)                                       %'tidal ellipse of ',
     line([uel(maxP) -uel(maxP)],[vel(maxP)-dep(m1) -vel(maxP)-dep(m1)]),line([uel(minP) -uel(minP)],[vel(minP)-dep(m1) -vel(minP)-dep(m1)])
       axis equal;
%       axis ij;
      grid on
%      set(ha,'Position',[0.05+(p(3)-1)*0.25,0.1,0.18,0.8]);

%%
A = (uam.^2)*cos(2*uph/180*pi) + (vam.^2)*cos(2*vph/180*pi);
B = (uam.^2)*sin(2*uph/180*pi) + (vam.^2)*sin(2*vph/180*pi);
sgm = (atan_pm(B,A))/2;
W =sqrt( (uam.^2)*(cos((sgm-uph)/180*pi))^2 + (vam.^2)*(cos((sgm-vph)/180*pi))^2  );
tha = atan_pm((vam*cos((sgm-vph)/180*pi)),(uam*cos((sgm-uph)/180*pi)));
%%%%%%%%%%%
%采用潮汐教材中方法
% if  uam*cos((sgm-uph)/180*pi)>=0
% tha2 = asin((vam*cos((sgm-vph)/180*pi))/W);
% else
% tha2 = pi-asin((vam*cos((sgm-vph)/180*pi))/W);  
% end
% tha2 = tha2 *180/pi;
% Ic=tha2;
%%%%%%%%%%%%
Ic = tha;
%%  和t-tide得到结果一样 师兄程序
%      Ic = atan_pm(vel(maxP),uel(maxP)); 
%      Ic = Ic(1);
     if Ic > 180, Ic = Ic - 360; end
     hold on
      text(0+25,-dep(m1),num2str(fix(Ic(1))),'fontsize',10);
     ylim([-400 0])
%      if (p(3)==1);
         set(gca,'ytick',[-400:50:0]);
%          xi=400:-50:0;
%          set(gca,'yticklabel',num2str(xi(1:end)))
%      else
%          set(gca,'ytick',[]);
%      end
      xlim([-30 30])
      set(gca,'xtick',[-30:20:30]);
%      ylabel('Depth/m','fontsize',12)
%%

     
return
