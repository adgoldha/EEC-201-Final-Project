clc;
% Script used in Test 1 of the project to test human recognition of the sounds
% Plays each training sound once then plays the test sounds in a random order
% The user is asked to identify the sound by number (ie 1, 2, etc)
% The order the test sounds were played and the user answers is shown at the end
n = 8; % Number of Training data - naming must match s#.wav
m = 8; % Number of Testing data - naming must match s#.wav

train_arr = 1:n;
% train_arr = train_arr(randperm(length(train_arr)));
test_arr = 1:m;
test_arr = test_arr(randperm(length(test_arr)));

dir = ".\\GivenSpeech_Data\\Training_Data\\";
for i = 1:length(train_arr)
    file = sprintf("%ss%d.wav",dir,train_arr(i));
    [y,fs] = audioread(file);
    fprintf("Sound %d\n",i);
    sound(y,fs);
    pause(2);
end

dir2 = ".\\GivenSpeech_Data\\Test_Data\\";
user = zeros(1,m);
for j = 1:length(test_arr)
    file = sprintf("%ss%d.wav",dir,test_arr(j));
    [y,fs] = audioread(file);
    sound(y,fs);
    user(j) = input("What signal do you think this is? \n");
end

% train_arr
test_arr
user