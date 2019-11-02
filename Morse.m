%% I take zero credit for the original codebook setup. I mainly focus on generating the waveform.
%% This is readapted from https://www.mathworks.com/matlabcentral/answers/404470-matlab-morse-code-decoder-please-help-me
%% I also implemented the spacing methods from http://www.nu-ware.com/NuCode%20Help/index.html?morse_code_structure_and_timing_.htm

function cw = Morse(word,fs)

%% wpm = 2.4 * dots/second (dps)
wpm = 60;
dps = wpm/2.4;
dot = dps;
dash = 3*dps;
cw = [ones(1,dot*fs),zeros(1,dot*fs)];

word = upper(word);
word = strjoin(strsplit(word));
morse={'.----','..---','...--','....-','.....','-....','--...','---..','----.','-----','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..','/'}; 
NumberOrLetter={'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' '};
for i=1:length(word)
    [~, index] = ismember(word(i), NumberOrLetter);
    if index > 0
        in = morse{index};
        word = [word, in];
        cw = [cw,zeros(1,dot*fs)];
        seg = char(compose('%c',in));
        for j = 1:length(seg)
            if seg(j) == '.'
               cw = [cw,ones(1,dot*fs)];
            end
            if seg(j) == '-'
               cw = [cw,ones(1,dash*fs)];
            end
            cw = [cw, zeros(1,dot*fs)];
        end
    else
        cw = [cw, zeros(1,2*dot*fs)];
    end 
end
cw = [cw, zeros(1,2*dot*fs)];