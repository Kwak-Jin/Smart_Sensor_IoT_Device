%% Average filter ����
instrreset; clear all; close all; clc;

dt = 0.1;
time = 0:dt:20;

sample_size = length(time);

raw_data = zeros(sample_size,1);
avg_data = zeros(sample_size,1);

for k = 1:sample_size
   data = 10.0 + 2*randn(1); % randn(n) = ��� 0 ,ǥ������1�� ���� n*n ����
   raw_data(k,1) = data;
   avg_data(k,1) = AvgFilter(data);
end

figure
plot(time, raw_data,'k*:')
hold on
plot(time, avg_data,'bo-')
set(gca, 'fontsize',20)
grid on

title('Average Filter Test', 'fontsize', 20)
xlabel('Time[s]', 'fontsize', 20)
ylabel('Voltage[V]', 'fontsize', 20)
legend('Raw Data', 'Average Data')

