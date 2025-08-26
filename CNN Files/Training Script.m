% File Paths to Folders
trainFolder = "Insert Training Image Folder Path here";
validFolder = "Insert Validation Image Folder Path here";
testFolder = "Insert Testing Image Folder Path here";

% Creating Datastores for each Folder
imdsTrain = imageDatastore(trainFolder, "IncludeSubfolders",true,"LabelSource","foldernames");
imdsValid = imageDatastore(validFolder, "IncludeSubfolders",true,"LabelSource","foldernames");
imdsTest = imageDatastore(testFolder, "IncludeSubfolders", true, "LabelSource", "foldernames");

% Creating labels for classification based on Folder Names
classes = categories(imdsTest.Labels);

% Image Augmenter (to challenge the CNN)
augmenter = imageDataAugmenter(...
    "RandRotation",[-20 20], ...         % Rotates the image by +/- 20 degrees
    "RandXScale", [0.9 1.1], ...         % Streches or compresses an image horizontally by a factor between 0.9-1.1
    "RandYScale", [0.9 1.1], ...         % Streches or compresses an image vertically by a factor between 0.9-1.1
    "RandXShear", [-5 5], ...            % Slants the image horizontally by +/- 5 degrees
    "RandYShear", [-5 5], ...            % Slants the image vertically by +/- 5 degrees
    "RandXReflection", true, ...         % Reflects image horizontally
    "RandYReflection", true, ...         % Reflects image vertically 
    "RandXTranslation", [-5 5], ...      % Moves image left or right by 5 pixels
    "RandYTranslation", [-5 5]);         % Moves image up or down by 5 pixels

% Stores the augmented images in new datastores
augmentedImdsTrain = augmentedImageDatastore([227 227], imdsTrain, "DataAugmentation", augmenter);
augmentedImdsValid = augmentedImageDatastore([227 227], imdsValid, "DataAugmentation", augmenter);
augmentedImdsTest = augmentedImageDatastore([227 227], imdsTest, "DataAugmentation", augmenter);

% Initializes the Convoloutional Neural Network for Binary Classification
net = imagePretrainedNetwork("squeezenet", NumClasses=2);

% Tweaking Training Options to get the Best Result
options = trainingOptions("sgdm", ...               % SDGM -> Stochastic Gradient Descent with Momentum (Mathematical function to balance speed and training effectiveness)
    "MaxEpochs", 10, ...                            % Defines the number of times the CNN trains through the entire dataset
    "ValidationData", augmentedImdsValid, ...       % Validation data to check whether the CNN is memorising new content or actually learning from it
    "ValidationFrequency", 30, ...                  % Checks if CNN is memorising every 30 iterations
    "Plots", "training-progress", ...               % Plots a line graph to show training progress
    "InitialLearnRate", 1e-4, ...                   % Defines how fast the CNN learns
    "L2Regularization", 5e-3, ...                   % Weight penalty to reduce memorisation
    "Metrics", "accuracy", ...                      % Tells program to measure CNN accuracy
    "ExecutionEnvironment", "auto", ...             % Tells program to run via GPU (if available) or CPU to reduce processing load on hardware
    "LearnRateSchedule", "piecewise", ...           % Learning Rate increases/decreases at set intervals instead of being constant to improve CNN performance
    "LearnRateDropFactor", 0.1, ...                 % When the Learn Rate Schedule interval is done, learning rate drops by a factor of ten
    "LearnRateDropPeriod", 5, ...                   % Number of Epochs it takes to trigger an interval in learning rate
    "MiniBatchSize", 128, ...                       % How many images are processed every gradient update
    "Shuffle","every-epoch", ...                    % Shuffles training data at the start of every epoch to make training for the CNN a bit trickier
    "Verbose", true);                               % Prints data after epoch in command window for debugging and performance tracking

% Initializes CNN Training
trainedNet = trainnet(augmentedImdsTrain, net, "crossentropy", options); % "Crossentropy" -> measures how different the predicted class of an image is from the actual class of an image

% Testing the Retrained CNN
testScores = minibatchpredict(trainedNet,augmentedImdsTest);    % Starts Testing the Trained CNN and assigns scores to "testScores"
testClasses = scores2label(testScores, classes);               % Gets scores from "testScores" and assigns the image to either "Fire" or "No Fire" based on its score

acc = testnet(trainedNet, augmentedImdsTest, "accuracy"); % Evaluates Test Accuracy
confusionchart(imdsTest.Labels, testClasses) % Prints a confusion matrix in the command window to show how the CNN identified the testing dataset

disp("Test Accuracy: " + acc);     % Numerical figure to show testing accuracy 

save("Retrained_Wildfire_Classification_CNN.mat", "trainedNet");  % Saves the Retrained CNN to my PC