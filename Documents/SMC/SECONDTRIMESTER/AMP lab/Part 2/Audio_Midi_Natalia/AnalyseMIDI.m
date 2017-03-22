clear all; close all; clc
% Natalia Delgado

%% READ MIDIFILE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path = 'C:/Users/natad/Documents/SMC/SECONDTRIMESTER/AMP lab/Part 2/Audio_Midi_Natalia/';
%filename = 'C:/Users/natad/Documents/SMC/SECONDTRIMESTER/AMP lab/Part 2/Audio_Midi_Natalia/arabesqu.mid';
filename = 'arabesque-2-track.mid';
filename = 'arabesqu1.mid';
outputFilename = 'dynamicsOutcome.mid'
filename = (strcat(path,filename));
[nmat, mstr] = readmidi(filename);
%% REPRESENT SECTIONS OF THE PIECE (frequency, velocity)
%% VARIABLE DEFINITION
% declare vector with moments in time (in secs) in which to generate a new piano
% roll (extracted manually)
dur = [1.5 16 40 62 92 112 130 140 149 157 167 179 203 232 254];
%dur = [0 16 40 62 92 112 130 167 179 203 232 253]

% define relative percentual threshold (0 to 1)
th = 0.7;
% define window length in seconds (for dynamics filtering)
wlength = 0.5;

% represent = 1 to show figures, 0 to just run the program
represent = 0;

%% START REPRESENTATION & DYNAMICS COMPUTATION

nmat1 = midiWindow(nmat,dur(1),dur(2),'sec');
nmatDynamics = velocityFilter(nmat1, th, wlength,'sec');
dynamicsOutcome = nmatDynamics;

if represent == 1
    figure()
    pianoroll(nmat1,'name','sec','vel');
    figure()
    pianoroll(nmat1,'name','sec','r');
    pianoroll(nmatDynamics, 'sec','b','hold'); % 2nd melody in blue color
end

for i = 2: length(dur)-1
    nmatWindow = midiWindow(nmat,dur(i),dur(i+1),'sec');
    nmatDynamics = velocityFilter(nmatWindow, th, wlength,'sec');
    if represent == 1
        figure()
        pianoroll(nmatWindow,'name','sec','vel');
        figure()
        pianoroll(nmatWindow,'name','sec','r');
        pianoroll(nmatDynamics, 'sec','b','hold'); % 2nd melody in blue color
    end
    dynamicsOutcome = [dynamicsOutcome ; nmatDynamics];
    
end

figure()
pianoroll(dynamicsOutcome,'name','sec','r');
title('final dynamics outcome')

%% WRITE DYNAMIC OUTCOME TO MIDI
n = writemidi(nmat, outputFilename);

%beats or ticks per quarter note to seconds
BPM = gettempo(nmat)
PPQ = mstr(1).ticks_per_quarter_note
sec = 60000 / (BPM * PPQ)
% for i = 1:floor(length/)
%     nm = midiWindow(nmat,mintime,maxtime,timetype,clipmode)
%     pianoroll(nmat,'num','beat')
% end

% trying out functions
n = kkkey(nmat);
name=keyname(n)
k = keymode(nmat) % 1=major, 2=minor
ob = onset(nmat);
p = tonality(nmat);
