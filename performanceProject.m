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

event.name = '' ;
event.time = 0; 
event.calledTimes = 0;
event.inclusiveTime = 0;
event.exclusiveTimes = 0;

for i = 1:height(t)
   
    callOf_a = 0;
    callOf_b = 0;
    callOf_c = 0;
    
    if (commands(i)=='Call_a') 
       event(1).name = 'a';
       callOf_a = i;
    elseif (commands(i)=='Call_b')
         event(2).name = 'b';
         callOf_b = i;
    elseif (commands(i)=='Call_c')
         event(3).name = 'c';
         callOf_c = i;
         
   
    end

end

event(1)
event(2)
event(3)






