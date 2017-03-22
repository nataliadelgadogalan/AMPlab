function nmat_output = velocityFilter(nmat, th, wlength,timetype)

% this function only selects notes over a velocity threshold
% it is computed relatively: per windows, mean velocity is computed.
% only notes with velocity over mean will be stored. 
% th allows changing the threshold. This % value will be added to the mean


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

initSec = nmat(1,6)*1.0;
lastSec = nmat(end,6)*1.0 + nmat(end,7)*1.0;
len_in_sec_nmat =nmat(end,6)*1.0 - nmat(1,6)*1.0 + nmat(end,7)*1.0;
nWindows = floor(len_in_sec_nmat/wlength);
nmat_output =[];
for t = 1:nWindows
    start=initSec+((t-1)*wlength)*1.0;
    finish=initSec+(t*wlength)*1.0;
    nmat_aux = midiWindow(nmat,start,finish,'sec');
    mvn_nmat = maxVelNotes(nmat_aux, th,timetype);
    nmat_output = [nmat_output; mvn_nmat];
end
nmat_aux = midiWindow(nmat,initSec+(t*wlength)+1,lastSec,'sec');
mvn_nmat = maxVelNotes(nmat_aux, th,timetype);
nmat_output = [nmat_output; mvn_nmat];
