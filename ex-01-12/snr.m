function x = snr(I)
    gs = mean(I,3);
    x = 20*log10((max(gs(:))-min(gs(:)))./std(gs(:)));
end