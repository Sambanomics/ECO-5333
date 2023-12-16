GDP_i = repmat(lnGDPi, 1, 15);
GDP_j = repmat(lnGDPj, 15, 1);
GDP_j = reshape(GDP_j, [], 1);
GDP_i = reshape(GDP_i, [], 1);


b = fitlm([GDP_i,GDP_j, lnd,border_s], lnX, "linear");

% Source (Dummy variable)
d_s = categorical(iso_d_sel);
d_s = dummyvar(d_s);
p_i = d_s;

% Destination (Dummy variable)
iso_d = unique(iso_d_sel);
iso_d_r = repmat(iso_d,15,1);
d_d = categorical(iso_d);
d_d = dummyvar(d_d);
p_j = d_d;

p_j =reshape(p_j,225,[]);



X_var = [GDP_i GDP_j lnd border_s p_i p_j];
Y_var = lnX;

[beta,~,~,~,stats] = regress(Y_var,X_var);


Standard_errors = sqrt(diag(stats(1:4)));