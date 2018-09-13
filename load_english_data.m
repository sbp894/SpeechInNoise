% Uses NELData parsing codes for English sentence protocol written for n_sEPSM analysis and creates a
% mat-stucture file for each chin. The structure has a number of fields like:
% --- Basic params: chin ID, track, unit, TC, Q10, thresh, SR, SatR, RLF, CF
% --- Trigger quality (percent less than refractory - need to run screenDataMAT for that.)
% --- spike times (3x2) cell, nReps. 
% --- Condition description (SNR, noise type, SPL, stimFileNames)
% --- paramsAnal: probably unnecessary now (was useful in n_SEPSM analysis)

clear;
clc;


% Declare all directories
dirStruct.WorkingDir='/home/parida/Dropbox/MATLAB/SpeechInNoise/Codes/';
dirStruct.MATDataDir='/media/parida/DATAPART1/Matlab/ExpData/MatData/';
dirStruct.CodesDir= '/media/parida/DATAPART1/Matlab/SNRenv/n_sEPSM/Codes/';
dirStruct.OutDir=[dirStruct.WorkingDir 'InData/EnglishData/'];
if ~isdir(dirStruct.OutDir)
    mkdir(dirStruct.OutDir);
end

addpath(dirStruct.CodesDir);
chinIDs=[245 277 282 285];

for chinVar=1:length(chinIDs)
    curChinID= chinIDs(chinVar);
    fName2Save=sprintf('%sQ%d_spikestimulusData', dirStruct.OutDir, curChinID); 
    loopChinID=chinIDs(chinVar);
    loopDataDir=dir([dirStruct.MATDataDir '*Q' num2str(loopChinID) '*']);
    [spike_data, ~, ~]=DataAnal.load_data(DataAnal.get_ExpControlParams, [dirStruct.MATDataDir loopDataDir.name]);
    
    parsave([fName2Save '.mat'], spike_data); % dummy save function else matlab won't let you run parfor
end

% Remove from path to avoid shadowing effects in other codes.
rmpath(dirStruct.CodesDir);
cd(dirStruct.WorkingDir);


function parsave(fName, spike_data) %#ok<INUSD>
save(fName, 'spike_data');
end