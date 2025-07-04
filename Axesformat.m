clc;
clear;
% Read audio
[audio, Fs] = audioread("audioDSP.wav");
% First Filter - Bandstop Butterworth
f_low1 = 780; f_high1 = 820;
cutoff1 = [f_low1 f_high1] / (Fs / 2);
N1 = 4;
[b, a] = butter(N1, cutoff1, 'stop');
% Second Filter - Bandpass Butterworth
f_low2 = 500; f_high2 = 2000;
cutoff2 = [f_low2 f_high2] / (Fs / 2);
N2 = 5;
[e, d] = butter(N2, cutoff2, 'bandpass');
% Frequency response
[H1, w] = freqz(b, a, 1024);
[H2, ~] = freqz(e, d, 1024);
f = w * Fs / (2 * pi);  % Convert from rad/sample to Hz
% 1. Plot |H(w)| - Magnitude
figure;
plot(f, abs(H1), 'b', 'LineWidth', 1.5); hold on;
plot(f, abs(H2), 'r', 'LineWidth', 1.5);
title('|H(\omega)| - Magnitude Response');
xlabel('Frequency (Hz)');
ylabel('|H(\omega)|');
legend('Stopband (780-820 Hz)', 'Bandpass (500-2000 Hz)');
grid on;
% 2. Plot |H(w)| in dB
figure;
plot(f, 20*log10(abs(H1)+eps), 'b', 'LineWidth', 1.5); hold on;
plot(f, 20*log10(abs(H2)+eps), 'r', 'LineWidth', 1.5);
title('|H(\omega)| in dB');
xlabel('Frequency (Hz)');
ylabel('|H(\omega)| (dB)');
legend('Stopband (780-820 Hz)', 'Bandpass (500-2000 Hz)');
grid on;
% 3. Plot Δ|H(w)| - Magnitude Difference
figure;
delta_H = abs(abs(H2) - abs(H1));
plot(f, delta_H, 'b', 'LineWidth', 1.5);
title('\Delta|H(\omega)| = |H_{bandpass}(\omega)| - |H_{stop}(\omega)|');
xlabel('Frequency (Hz)');
ylabel('\Delta|H(\omega)|');
grid on;