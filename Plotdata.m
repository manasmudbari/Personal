clear ; close all ; clc
data = load('ex2data1.txt');
X=data(: , [1,2]); y = data(:, 3);
plotData(X, y);
hold on;
xlabel('Exam 1 score')
ylabel('Exam 2 score')
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;
