function nmat = maxVelNotes(nmat, th,timetype)
% this function only selects notes over a velocity threshold
% it is computed relatively: per windows, mean velocity is computed.
% only notes with velocity over mean will be stored.

if isempty(nmat), return; end
if strcmp(timetype, 'sec')~=1 && strcmp(timetype, 'beat')~=1 
   disp(['Unknown timetype:' timetype])
   disp('Accepted timeformats are ''sec'' or ''beat''! ')
   return
end

if strcmp('sec',timetype)
   os=onset(nmat,'sec');
   ds = dur(nmat,'sec');
else
   os=onset(nmat);
   ds = dur(nmat);
end


% compute velocity threshold
v = velocity(nmat);
vMax = max(v);
vMin = min(v);
vRange = vMax-vMin;
vThreshold = (vRange*th) + vMin;
len_nmat = size(nmat,1);
for n = 1: len_nmat
    if nmat(n,5) < vThreshold
        nmat(n,4) = 0;
    end
end