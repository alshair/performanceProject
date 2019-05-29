%text = fileread('C:\Users\Mohamed Elshek\Desktop\log.txt');
%reads a file and turn it to string

opts = detectImportOptions('log.txt','Delimiter','.');

t = readtable('log.txt',opts);

time = t{:,2};
commands = t{:,1};

t;

commands = categorical(commands);
time = categorical(time);

callOfa = 0;
callOfb = 0;
callOfc = 0;
    
if(commands(1) == 'Start/callmain')
for i = 1:height(t)
   
 
    if (commands(i)=='Call_a') 
      
      callOfa = callOfa + 1;
      a.name='event a';
      a.calledTimes= callOfa;
      
    elseif (commands(i)=='Call_b')
       
         callOfb = callOfb + 1;
          b.name='event b';
      b.calledTimes= callOfb;
     
    elseif (commands(i)=='Call_c')
     
         callOfc = callOfc + 1;
          c.name='event c';
      c.calledTimes= callOfc;
      
         
   
    end

end
end

a
b
c


