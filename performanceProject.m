%text = fileread('C:\Users\Mohamed Elshek\Desktop\log.txt');
%reads a file and turn it to string

opts = detectImportOptions('log.txt','Delimiter','.');

t = readtable('log.txt',opts);

time = t(:,2);
commands = t{:,1};

t;
time;
commands;
commands = categorical(commands);



