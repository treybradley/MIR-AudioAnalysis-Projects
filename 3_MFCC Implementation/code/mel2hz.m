% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 2


% this is a mel to Hz conversion - the second portion of an MFCC warping function.
function [hzval] = mel2hz(melval)

hzval = 700 * (((exp(melval / 1127.01028)) - 1));

end