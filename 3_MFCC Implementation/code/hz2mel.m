% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 1


% this is a Hz to mel scale conversion - the first portion of an MFCC warping function.
function [melval] = hz2mel(hzval)

melval = 1127.01028 * (log(1 + (hzval/700)));

end