% Cone sensitivities for short, medium and long wavelengths.
% lambda contains the wavelength values in nanometers
function [lambda cone_short cone_med cone_long] = cones( filename )

% Read the base cone sensitivity values (default filename 'ciexyz31.csv')
A = csvread( filename );

% Following http://www.cvrl.org/database/text/cones/smj2.htm
% lambda, R, G and B are the columns from ciexyz31.txt in the same order
lambda = A(:,1);
R = A(:,2);
G = A(:,3);
B = A(:,4);

cone_long = zeros( numel(lambda), 1 );
cone_med = zeros( numel(lambda), 1 );
cone_short = zeros( numel(lambda), 1 );

for i=1:numel(lambda)
	cone_long(i) = 0.214808*R(i) + 0.751035*G(i) + 0.045156*B(i);
	cone_med(i) = 0.022882*R(i) + 0.940534*G(i) + 0.076827*B(i);

	if lambda(i) <= 525
		cone_short(i) = 0.0*R(i) + 0.016500*G(i) + 0.999989*B(i);
	else
		cone_short(i) = exp( (10402.1/lambda(i)) - 21.549 );
	end
end

m = max( [cone_short;cone_med;cone_long] );
cone_long = cone_long ./ m;
cone_med = cone_med ./ m;
cone_short = cone_short ./ m;