function [ Lnorm_error ] = Lnorm_error( a, b, n )
%LNORM_ERROR Compare two vectors using the L-norm algorithm
%   
% Description: 
%   The L-norm function is a useful measure of the equivalence of 
%   two equal length vectors.  It can handy to compare the error between
%   two vectors that are expected to be equal but have different numerical
%   formats (e.g. fixed point vs floating point).
%
%   err = Lnorm_error(a, b)
%       Compare vectors A and B
% 
% Arguments:
% 
%   a,b: double
%       Input vectors to compare
% 
%   n: int
%       Order of L-norm 
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

if nargin < 3
    n = 2;
end

Lnorm_error = Lnorm( a - b , n ) / Lnorm(b,n);

end


function [ Lnorm ] = Lnorm( a, n )

if nargin < 2
    n = 2;
end

Lnorm = (sum(abs(a).^n)).^(1/n);

end
