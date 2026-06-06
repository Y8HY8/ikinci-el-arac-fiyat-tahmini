%% 
% İKİNCİ EL ARAÇ PİYASA DEĞERİ TAHMİNLEME
% ÇOKLU DOĞRUSAL REGRESYON MODELİ
clc; clear; close all;
%% 1. VERİ SETİNİN OLUŞTURULMASI (PDF'TEKİ ORİJİNAL 10 ARAÇ)
Fiyat = [1650000; 1820000; 1500000; 1950000; 1740000; 1580000; 2100000; 1680000; 1890000; 1550000];
Kilometre = [115000; 85000; 160000; 42000; 95000; 130000; 25000; 105000; 60000; 145000];
Yas = [6; 4; 8; 2; 5; 7; 1; 5; 3; 8];
Tramer = [12000; 0; 45000; 5000; 18000; 22000; 0; 8000; 0; 35000];
LCI_Durumu = [0; 1; 0; 1; 0; 0; 1; 0; 1; 0];
%% 2. MODELİN KURULMASI VE KATSAYILARIN BULUNMASI (Matris Yöntemi)
Y = Fiyat;
X = [ones(length(Fiyat),1), Kilometre, Yas, Tramer, LCI_Durumu];
% En Küçük Kareler Yöntemi ile katsayı çözümü
b = X \ Y;
%% 3. TAHMİNLER VE HATA HESAPLAMALARI
tahminY = X * b;
hata = Y - tahminY;
mutlakHata = abs(hata);
SSE = sum(hata.^2);
SST = sum((Y - mean(Y)).^2);
R2 = 1 - (SSE / SST);
MAE = mean(mutlakHata);
RMSE = sqrt(mean(hata.^2));
fprintf('--------------------------------------------------\n');
fprintf('MODEL BAŞARI DEĞERLERİ\n');
fprintf('R-Kare Değeri : %.4f\n', R2);
fprintf('Ortalama Mutlak Hata MAE : %.2f TL\n', MAE);

fprintf('RMSE Hata Değeri : %.2f TL\n', RMSE);
fprintf('--------------------------------------------------\n');
%% 4. GRAFİK ÇİZİMLERİ (Orijinal Mavi Yuvarlaklı Format)
figure('Name', 'Lineer Regresyon Arac Fiyat Tahmini', 'NumberTitle', 'off ');
% Grafi k 1: Gerçek Fiyat - Tahmin Fiyat Karşılaştırması
subplot(1,2,1);
scatter(Y, tahminY, 80, 'filled'); hold on;

minDeger = min([Y; tahminY]); maxDeger = max([Y; tahminY]);
plot([minDeger maxDeger], [minDeger maxDeger], 'r', 'LineWidth', 2);
xlabel('Gerçek Fiyatlar (TL)'); ylabel('Tahmin Edilen Fiyatlar (TL)');
title('Gerçek Fiyat - Tahmin Grafi ği'); grid on;
ax = gca; ax.XAxis.Exponent = 0; ax.YAxis.Exponent = 0;
% Grafi k 2: Hata Dağılımı
subplot(1,2,2);
scatter(tahminY, hata, 80, 'filled'); hold on;

plot([min(tahminY) max(tahminY)], [0 0], 'r', 'LineWidth', 2);
xlabel('Tahmin Edilen Fiyatlar (TL)'); ylabel('Hata Degeri');
title('Hata Dağılımı (Residuals)'); grid on;
ax = gca; ax.XAxis.Exponent = 0; ax.YAxis.Exponent = 0;