% Uses NELData parsing codes for Danish sentence protocol written for n_mr_sEPSM analysis and creates a
% mat-stucture file for each chin. The structure has a number of fields like:
% --- Basic params: chin ID, track, unit, TC, Q10, thresh, SR, SatR, RLF, CF
% --- Trigger quality (percent less than refractory - need to run screenDataMAT for that.)
% --- spike times (3x2) cell. 
% --- Condition description (SNR, noise type, SPL, stimFileNames)
% --- paramsAnal: probably unnecessary now for the most part (was useful in
% n_mr_SEPSM analysis): one useful parameter is average number of reps (nReps)

clear;
clc;

% Declare all directories
dirStruct.WorkingDir='/home/parida/Dropbox/MATLAB/SpeechInNoise/Codes/';
dirStruct.MATDataDir='/media/parida/DATAPART1/Matlab/ExpData/MatData/';
dirStruct.CodesDir= '/media/parida/DATAPART1/Matlab/SNRenv/n_mr_sEPSM/Codes/'; 
dirStruct.OutDir=[dirStruct.WorkingDir 'InData/DanishData/'];
if ~isdir(dirStruct.OutDir)
    mkdir(dirStruct.OutDir);
end

% Use codes written for n_mr_EPSM
addpath(dirStruct.CodesDir);

% chinIDs=[321 322 325 338 341 343 346 347 354 355 361 362];
% It creates a new mat file for each chin. So no need to re-run all chins.
chinIDs=362;

for chinVar=1:length(chinIDs)
    curChinID= chinIDs(chinVar);
    fName2Save=sprintf('%sQ%d_spikestimulusData', dirStruct.OutDir, curChinID); 
    loopChinID=chinIDs(chinVar);
    loopDataDir=dir([dirStruct.MATDataDir '*Q' num2str(loopChinID) '*']);
    [spike_data, ~, ~]=DataAnal.load_data_per_snr(DataAnal.get_ExpControlParams, [dirStruct.MATDataDir loopDataDir.name]);
    
    parsave([fName2Save '.mat'], spike_data); % dummy save function else matlab won't let you run parfor
end

% Remove from path to avoid shadowing effects in other codes.
rmpath(dirStruct.CodesDir);
cd(dirStruct.WorkingDir);


function parsave(fName, spike_data) %#ok<INUSD>
save(fName, 'spike_data');
end