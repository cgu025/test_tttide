






for ii=5:8;
sc=['K1';'O1';'P1';'Q1';'M2';'S2';'N2';'K2'];

scc=sc(ii,:);
k=1;

uu.am=Amu;                                  % u方向振幅
uu.ph=Phu;                                    % u方向相位
vv.am=Amv;                                   % v方向振幅
vv.ph=Phv;                                     % v 方向相位

dep=depth1;                                  % 深度

p=[1,4,ii-4];

for i=11:6:74                                  % 画第i层的潮流椭圆
m=i;    
[lmax,lmin,Ic] = T_ellipse(uu.am(i,ii),uu.ph(i,ii),vv.am(i,ii),vv.ph(i,ii),scc,lat,t,p,m,dep);
la(k,i) = lmax; sa(k,i) = lmin; thea(k,i) = Ic(1);
clear m 
end

set(gca,'fontsize',12);

end

print(gcf,'zz','-dpng');


