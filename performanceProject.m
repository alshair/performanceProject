
import java.util.*;

%function used to read the text file which contains the events log
opts = detectImportOptions('log.txt','Delimiter','.');
%function used to turn the data in the text file to a useful table
t = readtable('log.txt',opts);

time = t{:,2}; % extracting the time stamp column from the table

commands = t{:,1};% extracting the the command column from the table

t;
time;
commands;
commands = categorical(commands); % turning the commands column to categorical form


%analyzing some variables to be used 
event = struct('name', {},'totalTimeInStack', {}, 'calledTimes',{} );

callOfa = 0;
callOfb = 0;
callOfc = 0;

%function to start reading the command column and identifying the commands, 
%and stating how many times an event is called 
if(commands(1) == 'Start/callmain')
for i = 1:height(t)
   
    if (commands(i)=='Call_a') 
      
      callOfa = callOfa + 1;
      event(1).name = 'event a';
      event(1).calledTimes = callOfa;
      
    elseif (commands(i)=='Call_b')
       
         callOfb = callOfb + 1;
        event(2).name = 'event b';
        event(2).calledTimes = callOfb;
     
    elseif (commands(i)=='Call_c')
     
        callOfc = callOfc + 1;
        event(3).name = 'event c';
        event(3).calledTimes = callOfc;
    
    end

end
end

%analyzing some variables to be used 
inclusive = struct('Name', {},'iMain', {},'ia', {}, 'ib',{} ,'ic',{});
exclusive = struct('Name', {},'eMain', {},'ea', {}, 'eb',{} ,'ec',{});

inclusive(1).Name = 'Inclusive Time';
exclusive(1).Name = 'exclusive Time';

%funtion used to construct the call stack content, and to 
% do some calculations to get the inclusive and exclusive time 
if(commands(1) == 'Start/callmain')
        disp('Call Stack Content')
        E = Stack();
         m = 'M';
         E.push(m);
         disp(E)
         arr = zeros(1,7);
         arr = E.toArray(arr);
        
         if(arr(1) == 'M')
             exclusive(1).eMain = 0;
             tt = time(2) - time(1);
             exclusive(1).eMain = tt;
             
         end
         
        counter = 0;
        exclusive(1).ea = 0;
        exclusive(1).eb = 0;
        exclusive(1).ec = 0;
        inclusive(1).ia = 0;
        inclusive(1).ib = 0;
        inclusive(1).ic = 0;
        for j = 2:height(t)
        
            if (commands(j) == 'Call_a')
            
            a = 'a';
            E.push(a);
            disp(E)
            arr = zeros(1,7);
            arr = E.toArray(arr);
            
            s = size(arr);
            s2 = [2,1];
            s3 = [3,1];
            if(arr(1) == 'M' & arr(2) == 'a' & (s == s2))
                
                    tt = time(j+1) - time(j);
                    exclusive(1).ea = exclusive(1).ea + tt;
                    
            else

                    tt = time(j+1) - time(j);
                    inclusive(1).ia = inclusive(1).ia + tt;
            end
            
            
           
            
            
        elseif (commands(j) == 'Call_b')
            b = 'b';
            E.push(b);
            disp(E)
            arr = E.toArray(arr);
             if(arr(1) == 'M' & arr(2) == 'a' & arr(3) == 'b')
                
                    tt = time(j+1) - time(j);
                    inclusive(1).ib = inclusive(1).ib + tt;
                    inclusive(1).ia = inclusive(1).ia + tt;
             elseif (arr(1) == 'M' & arr(2) == 'b')
                 
                 tt = time(j+1) - time(j);
                 exclusive(1).eb = exclusive(1).eb + tt;
             else
                 exclusive(1).eb =0 ;
             end
            
            
        elseif (commands(j) == 'Call_c')
            c = 'c';
            E.push(c);
            disp(E)
            arr = E.toArray(arr);
             if(arr(1) == 'M' & arr(2) == 'a' & arr(3) == 'c')
                
                    tt = time(j+1) - time(j);
                    inclusive(1).ic = inclusive(1).ic + tt;
                    inclusive(1).ia = inclusive(1).ia + tt;
             elseif (arr(1) == 'M' & arr(2) == 'b')
                 
                 tt = time(j+1) - time(j);
                 exclusive(1).ec = exclusive(1).ec + tt;
             else
                 exclusive(1).ec =0 ;
             end
        elseif (commands(j) == 'Return')
            E.pop();
            disp(E)
            arr = zeros(1,7);
            arr = E.toArray(arr);
            s = size(arr);
            s2 = [1,1];
            if(arr(1) == 'M' & (s == s2) )
              tt = (time(j+1) - time(j));
              exclusive(1).eMain = exclusive(1).eMain + tt;
            end
            s3 = size(arr);
            s4 = [2,1];
            s5 = [3,1];
            if(s3 == s4)
            if(arr(1) == 'M' & arr(2) == 'a')
                
                    tt = time(j+1) - time(j);
                    exclusive(1).ea = exclusive(1).ea + tt;
            end
            end
            
            if(s3 >= s5)
                if(arr(1) == 'M' & arr(2) == 'a' )

                    tt = time(j+1) - time(j);
                    inclusive(1).ia = inclusive(1).ia + tt;
                end
            end
               
            end 
        inclusive(1).iMain = time(height(t)) - exclusive(1).eMain;
        end
end

exclusive(1)

inclusive(1)

event(1).totalTimeInStack = inclusive(1).ia + exclusive(1).ea;
event(2).totalTimeInStack = inclusive(1).ib + exclusive(1).eb;
event(3).totalTimeInStack = inclusive(1).ic + exclusive(1).ec;

event(1)
event(2)
event(3)

im = inclusive(1).iMain; % Main inclusive time
em = exclusive(1).eMain; % Main exclusive time
mt = im + em;
ia = inclusive(1).ia;    % Event 'a' inclusive time
ea = exclusive(1).ea;    % Event 'a' exclusive time
at = event(1).totalTimeInStack; % Event 'a' total time in stack
ib = inclusive(1).ib;    % Event 'b' inclusive time
eb = exclusive(1).eb;    % Event 'b' exclusive time
bt = event(2).totalTimeInStack;  % Event 'b' total time in stack
ic = inclusive(1).ic;    % Event 'c' inclusive time
ec = exclusive(1).ec;    % Event 'c' exclusive time
ct = event(3).totalTimeInStack;  % Event 'c' total time in stack

% a simple function to check for the event with highest dynamic call or the
% more frequent appearing
mbc = max(bt,ct);
mtot = max(at, mbc);
if(mtot == at)
    disp('The function  with highest dynamic call time or the more frequent appearing is event a ')
else
    if(mtot == bt)
        disp('The function  with highest dynamic call time or the more frequent appearing is event b');
    else 
        disp('The function  with highest dynamic call time or the more frequent appearing is event c');
    end
end
    
 
%plot bar to visualize the inclusive, exclusive and total time
x = [im em mt;ia ea at;ib eb bt;ic ec ct];
c = categorical({'Main','Event a','Event b','Event c'});
rr= bar(c,x, 'EdgeColor','black','lineWidth', 1.5);
set(rr(1),'FaceColor','r');
set(rr(2),'FaceColor','b');
set(rr(3),'FaceColor','y');
aa={'Inclusive Time','Exclusive Time','Total time'};
legend(aa,'Location','Northeast');
figure(2)
rr= bar(c,x, 'stacked', 'EdgeColor','black','lineWidth', 1.5);
set(rr(1),'FaceColor','r');
set(rr(2),'FaceColor','b');
set(rr(3),'FaceColor','y');
aa={'Inclusive Time','Exclusive Time','Total time'};
legend(aa,'Location','Northeast');

% % this function is used to construct the context call tree
% load fisheriris
% elem=detectImportOptions('cct.txt','Delimiter',' ');
% tree = readtable('cct.txt',elem);
% command= tree{:,:};
% Mdl = TreeBagger(10,tree,command);
% Tree = Mdl.Trees{4};
% view(Tree,'Mode','graph');









