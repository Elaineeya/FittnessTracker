% Load results dataset 
data = readtable('mocked_results_data.csv'); 


predictorVariable = data.stepsCount; % stepsCount 
responseVariable = data.moodIndicator; % moodIndicator



predictorVariable = data.stepsCount;
responseVariable = data.moodIndicator;


rng(0); % Set a random seed for reproducibility
numRows = height(data);
cv = cvpartition(numRows, 'Holdout', 0.3); % 70% for training, 30% for testing
trainData = data(training(cv), :);
testData = data(test(cv), :);


mdl = fitlm(trainData, 'moodIndicator ~ stepsCount'); 


predictedMood = predict(mdl, testData);


% Calculate the mean squared error (MSE)
mse = immse(predictedMood, testData.moodIndicator);

% Calculate the R-squared value
rSquared = 1 - mse / var(testData.moodIndicator);



scatter(testData.stepsCount, testData.moodIndicator, 'filled');
hold on;
plot(testData.stepsCount, predictedMood, 'r');
xlabel('stepsCount'); % Replace with 'caloriesBurned' if needed
ylabel('mood');
legend('Actual Mood', 'Predicted Mood');
title(['Linear Regression: R-squared = ', num2str(rSquared)]);
