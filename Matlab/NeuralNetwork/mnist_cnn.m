% Load the Digit Dataset
digitDatasetPath = fullfile(matlabroot, 'toolbox', 'nnet', 'nndemos', 'nndatasets', 'DigitDataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% Split dataset into training and testing sets
[imdsTrain, imdsTest] = splitEachLabel(imds, 0.8, 'randomized');

% Display example images
figure;
perm = randperm(numel(imdsTrain.Files), 20);
for i = 1:20
    subplot(4, 5, i);
    imshow(readimage(imdsTrain, perm(i)));
    title(char(imdsTrain.Labels(perm(i))));
end

% Define CNN architecture
layers = [
    imageInputLayer([28 28 1]) % Input layer for 28x28 grayscale images

    convolution2dLayer(3, 32, 'Padding', 'same') % Conv layer with 32 filters, 3x3 kernel
    batchNormalizationLayer % Batch normalization
    reluLayer % ReLU activation

    maxPooling2dLayer(2, 'Stride', 2) % Max-pooling layer

    convolution2dLayer(3, 64, 'Padding', 'same') % Conv layer with 64 filters, 3x3 kernel
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    fullyConnectedLayer(128) % Fully connected layer with 128 neurons
    reluLayer

    fullyConnectedLayer(10) % Fully connected layer with 10 neurons (number of classes)
    softmaxLayer % Softmax layer for classification
    classificationLayer % Output classification layer
];

% Set training options
options = trainingOptions('adam', ...
    'InitialLearnRate', 0.001, ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', imdsTest, ...
    'ValidationFrequency', 30, ...
    'Verbose', true, ...
    'Plots', 'training-progress');

% Train the network
net = trainNetwork(imdsTrain, layers, options);

% Evaluate the model on test data
YPred = classify(net, imdsTest);
accuracy = sum(YPred == imdsTest.Labels) / numel(imdsTest.Labels);
disp(['Test Accuracy: ', num2str(accuracy * 100), '%']);
