function resultsTable = calculateActivityStats(weight, height, sensorDataFile)
    %% load sensor data from mobile
    load(sensorDataFile);
    %% Initialize Variables
    earthCirc = 24901; % 24901 miles
    totaldis = 0;
    stride = height*0.415 % Your_strip = height * 0.415, (cm) 
    lat = Position{:,1};
    lon = Position{:,2};
    
    %% Processing Loop
    for i = 1:(length(lat)-1)  % Loop through every data sample
      lat1 = lat(i); % Latitude of the i’th sample
      lon1 = lon(i); % Longitude of the i’th sample
      lat2 = lat(i+1); % Latitude of the (i+1)’th sample
      lon2 = lon(i+1); % Latitude of the (i+1)’th sample
      diff = distance(lat1, lon1, lat2, lon2); % MATLAB function to compute 
                                               % distance between 2 points on a
                                               % sphere
      dis = (diff/360)*earthCirc; % convert degrees to miles
      totaldis = totaldis +dis;
    end

    steps = totaldis/(stride/160934); % covert stride(cm) into , then calculate steps


    % Calories burned per mile = 0.57 x 175 lbs.(your weight) = 99.75 calories per mile.
    calories_burned_per_mile = 0.57*(weight*2.2046); % covert kilogram into pounds, then caculate
    % steps_in_1_mile = 160934.4(mile in cm) / strip.
    steps_in_1_mile = 160934.4 / stride;
    % conversationFactor = CaloriesBurnedPerMile / step_in_1_mile
    conversation_factor = calories_burned_per_mile / steps_in_1_mile
    % CaloriesBurned = stepsCount (what the pedometer provides) * conversationFactor
    calories_burned = steps * conversation_factor 
    % caculate the time spent
    time_spent = max(Position.Timestamp) -  min(Position.Timestamp)
    
    % Create a table to store the results
    resultsTable = table(steps', totaldis', calories_burned', time_spent', 'VariableNames', {'stepsCount', 'distances', 'caloriesBurned', 'timeSpent'});

    %display the results
    disp(resultsTable);

end


