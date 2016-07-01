score_tortilla = reading_gazedata('bus_ride.xlsx','bus_ride');

[score_overzero_tortilla,lost_tortilla] = score_overzero(score_tortilla);
resul(1,1) = mean(score_overzero_tortilla);

%Number of lost frames:
per_lost_tortilla = (lost_tortilla*100)/(length(score_tortilla));
% Top10 scores
top10_tortilla = score_tortilla;
for i = 1:10
    Ma_tortilla = max(top10_tortilla);
    pos = find(top10_tortilla(1,:) == Ma_tortilla);
    tortilla10(1,i) = top10_tortilla(pos);
    tortilla10_frame(1,i) = pos;
    top10_tortilla(pos) = 0;
end

% Top10 minimum scores
min10_tortilla = score_tortilla;
L = length(min10_tortilla);
for n = 1:L
    if min10_tortilla(n) <= 0
        min10_tortilla(n) = 10;
    end
end
for i = 1:10
    Mi_tortilla = min(min10_tortilla);
    pos = find(min10_tortilla(1,:) == Mi_tortilla);
    min10(1,i) = top10_tortilla(pos);
    min10_frame(1,i) = pos;
    min10_tortilla(pos) = 10;
end