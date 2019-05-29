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

event = struct('name', {},'time', {}, 'calledTimes',{} ,'inclusiveTime',{} ,'exclusiveTimes', {} );

callOfa = 0;
callOfb = 0;
callOfc = 0;
    
for i = 1:height(t)
   
 
    if (commands(i)=='Call_a') 
       event(1).name = 'a';
      callOfa = callOfa + 1;
     
        event.calledTimes(1) = callOfa;
    elseif (commands(i)=='Call_b')
         event(2).name = 'b';
         callOfb = callOfb + 1;
        event.calledTimes(2) = callOfb;
    elseif (commands(i)=='Call_c')
         event(3).name = 'c';
         callOfc = callOfc + 1;
        event.calledTimes(3) = callOfc;
         
   
    end

end

event(1)
event(2)
event(3)

