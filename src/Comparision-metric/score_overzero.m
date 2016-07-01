function [new_score,lost] = score_overzero(score)
L = length(score);
valid = 0;
lost = 0;
new_score(1,1) = 1;
for pos = 1:L
    if score(pos) > 0
        valid = valid+1;
        new_score(1,valid) = score(pos);
    end
    if score(pos) == 0
        lost = lost+1;
    end
end