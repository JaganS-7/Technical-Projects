clc; clear; close all;

curr_data = readmatrix("16Ohm_rheo_48V_3A.xlsx");

t = curr_data(:, 1);  %time stamps
Fs=1/(t(2)-t(1));     %sampling frequency
norm_curr =   14.5*curr_data(:, 2);   % normal current
arc_curr =   14.5*curr_data(:, 3);    % normal current

threshold_high = 3+0.07;   
threshold_low  = 3-0.07;   

norm_curr_clean = norm_curr;  
norm_curr_clean(norm_curr > threshold_high | norm_curr < threshold_low) = 3;

%concatnate both normal and arc current signals
t_combined = [t; t + 0.1]; 
combined_signal = [norm_curr_clean; arc_curr];  

window_size=5;        
h=ones(window_size,1)/window_size;
x_movg_avg=filter(h,1,combined_signal);
x_filtered = medfilt1(x_movg_avg, window_size); % moving median filter to the signal

window_sz = 11; % wind_size=11 is reducing complete noise here(do not take more than this), adjust as needed
x_filt = medfilt1(x_movg_avg, window_sz); 

window_length = 10;
num_windows = floor(length(x_filt) / window_length);
Peak_to_peak_x=zeros(1, num_windows);
for i = 1:num_windows
    window_start = (i - 1) * window_length + 1;
    window_end = min(i * window_length, length(x_filt));
    window_data = x_filt(window_start:window_end);

    window_time = t_combined(window_start:window_end);

    Peak_to_peak_x(i) = max(window_data) - min(window_data);
    time_windows(i) = mean(window_time);
end

[arc_spike, arc_spike_index] = max(Peak_to_peak_x(2:end));
arc_spike_index = arc_spike_index + 1; % index to account for starting from index 2
time_of_arc_spike= (arc_spike_index-1) * window_length / Fs;

num_windows = floor(arc_spike_index / window_size); 
avg_peak=zeros(1, num_windows);
for i = 2:num_windows
    window_start = (i - 1) * window_size + 1;
    window_end = min(i * window_size, arc_spike_index);
    window_data = Peak_to_peak_x(window_start:window_end);

    avg_peak(i) = max(window_data);
end

avg_mean_of_normal_signal_mags= mean(avg_peak); 

[C, L] = wavedec(Peak_to_peak_x , 6, 'db4');  

threshold = 0.001 * max(C);    
C(abs(C) < threshold) = 0;   

recon_signal = waverec(C, L, 'db4');  

threshold_peak_max = avg_mean_of_normal_signal_mags * max(recon_signal);
min_peak_dist = 10;
[pks_max, locs_max] = findpeaks(recon_signal, 'MinPeakHeight', threshold_peak_max, 'MinPeakDistance', min_peak_dist);
                        %'MinPeakHeight'=peaks to be detected must have a height (amplitude) >= to threshold(threshold_peak_max).
                        %'MinPeakDistance'=minimum distance between adjacent peaks(w.r.t min_peak_dist)
peaks_max=locs_max;     %occurance of max peaks in filtered signal by their locations(indices)

figure;
plot(time_windows, Peak_to_peak_x, 'b');        %signal with peaks
hold on;
plot(time_windows(peaks_max), Peak_to_peak_x(peaks_max), 'go');
hold on; % arc currentin red
plot(time_windows(time_windows >= 0.1), Peak_to_peak_x(time_windows >= 0.1), 'r');
xlabel('Sample Number');
ylabel('Amplitude');
title('Peak-to-peak Signal with max peaks');
grid on;
set(gca, 'FontName', 'Times', 'FontSize', 12);


%----detection algo.----
% Samples in 0.1-second window length, which should be < length of peak_to_peak_x signal

window_length = 1250;  
num_peaks_threshold = 5;  
peak_threshold = avg_mean_of_normal_signal_mags;     
fault_detected = false;  
detection_time = 0;
window_start = 1;

while window_start <= length(Peak_to_peak_x)
    window_end=min(window_start+window_length-1, length(Peak_to_peak_x));
    window_signal = Peak_to_peak_x(window_start:min(window_start+window_length-1, end));
    
    num_peaks = 0;
    for j = 1:length(pks_max)     %if any pks_max values are in the current window_signal
        if locs_max(j) >= window_start && locs_max(j) <= window_start + window_length - 1
            num_peaks = num_peaks + 1; 
        end
    end
 
    if all(pks_max(locs_max >= window_start & locs_max <= window_end) > peak_threshold) && num_peaks > num_peaks_threshold
        fault_detected = true;
        detection_time = window_start / Fs % Convert window start index to time
        break; 
    else
        window_start = window_start + window_length; 
    end
end

if fault_detected
    disp('Fault detected!');
else
    disp('No fault detected.');
end
