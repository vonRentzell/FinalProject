function [] = FinalProject()
    global graph;
   
    graph.fig = figure('numbertitle','off','name','Final Project'); %Creates the main figure
    graph.plot = plot(0,0);
        xlim([0 10]); %Sets up some default limits
        ylim([-5 5]);
    graph.plot.Parent.Position = [0.1 0.4 0.85 0.5]; %Establishes the main graph

    %Sets up the first button group which controls line color
    graph.buttonGroup = uibuttongroup('title','Line Color','titleposition','centertop','units','normalized','position',[.04 0.025 .15 .25],'selectionchangedfcn',{@radioSelect});
    graph.r11 = uicontrol(graph.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .7 1 .2],'string','Blue');
    graph.r12 = uicontrol(graph.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .4 1 .2],'string','Black');
    graph.r13 = uicontrol(graph.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .1 1 .2],'string','Red');
    
    %Sets up the second button group which controls line style
    graph.buttonGroup2 = uibuttongroup('title','Line Style','units','normalized','position',[.20 0.025 .15 .25],'selectionchangedfcn',{@radioSelect2});
    graph.r21 = uicontrol(graph.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .7 1 .2],'string','Solid');
    graph.r22 = uicontrol(graph.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .4 1 .2],'string','Dashed');
    graph.r23 = uicontrol(graph.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .1 1 .2],'string','Circles');
    
    %Creates a pushbutton
    graph.reset = uicontrol('style','pushbutton','position',[470 10 80 20],'string','Reset','callback',{@reset});
    
    %Creates edit boxes
    graph.title = uicontrol('style','edit','position',[140 380 300 20],'string','Title');
    graph.xtitle = uicontrol('style','edit','position',[140 125 300 20],'string','X Axis');
    
    %Creates the x limit text and edit boxes
        graph.xtext = uicontrol('style','text','position',[218 92 40 20],'string','X Limit:');
            graph.xedit = uicontrol('style','edit','position',[260 95 25 20],'string','0');
        graph.xtext2 = uicontrol('style','text','position',[285 92 20 20],'string','<');
            graph.xedit2 = uicontrol('style','edit','position',[305 95 25 20],'string','10');
            
    %Creates the y limit text and edit boxes
        graph.ytext = uicontrol('style','text','position',[218 67 40 20],'string','Y Limit:');
            graph.yedit = uicontrol('style','edit','position',[260 70 25 20],'string','-5');
        graph.ytext2 = uicontrol('style','text','position',[285 67 20 20],'string','<');
            graph.yedit2 = uicontrol('style','edit','position',[305 70 25 20],'string','5');
            
    %Creates the y axis edit box to allow the user to edit the y axis label
    %Also creates the "Graph" pushbutton
        graph.ylabel = uicontrol('style','text','position',[210 17 60 20],'string','Y Label:');
        graph.ylabeledit = uicontrol('style','edit','position',[265 20 190 20],'string','Click Graph to enter');
        graph.newLim = uicontrol('style','pushbutton','position',[210 45 120 20],'string','Graph','callback',{@Graph});
        
        %Creates edit boxes for the user to enter values into and also instructes the user on which format to use
            graph.instructions = uicontrol('style','text','position',[350 100 300 20],'string','Separate value with spaces.','horizontalalignment','left');
            graph.instructions2 = uicontrol('style','text','position',[500 100 75 20],'string','Ex. 1 2 3 4','FontAngle','italic','horizontalalignment','left');
            graph.instructions3 = uicontrol('style','text','position',[380 85 300 20],'string','(value length must be the same)','FontAngle','italic','horizontalalignment','left');
            graph.xval = uicontrol('style','text','position',[352 66 50 20],'string','X Values:');
                graph.xvaledit = uicontrol('style','edit','position',[405 69 150 20],'string','1 2 3 4');
            graph.yval = uicontrol('style','text','position',[352 42 50 20],'string','Y Values:');
                graph.yvaledit = uicontrol('style','edit','position', [405 45 150 20],'string','1 2 3 4');
           
        %Makes sure that the graph starts off with a blue and solid
        %line, regardless of previous stored variables in the workspace
            graph.rad1 = 'b';
            graph.rad2 = '-';
end

function [] = radioSelect(~,~) %Triggers when a radio button on the first button group gets selected
    global graph;
    bluestatus = get(graph.r11,'value'); %Checks to see if the blue radio button is selected
    blackstatus = get(graph.r12,'value'); %Checks to see if the black radio button is selected
       
    %Sets the global variable, graph.rad1, to the correct color modifier 
       if bluestatus == 1
           graph.rad1 = 'b'; 
       elseif blackstatus == 1
            graph.rad1 = 'k';
       else
           graph.rad1 = 'r';
       end
       
    %Refreshes the graph
       Graph();
end

function [] = radioSelect2(~,~) %Triggers when a radio button on the second button group gets selected
    global graph;
    circlestatus = get(graph.r23,'value'); %Checks to see if the circle radio button is selected
    dashesstatus = get(graph.r22,'value'); %Checks to see if the dashed radio button is selected
    
    %Sets the global variable, graph.rad2, to the correct line style modifier
        if circlestatus == 1
            graph.rad2 = 'o';
        elseif dashesstatus == 1
            graph.rad2 = '--';
        else
            graph.rad2 = '-';
        end
        
    %Refreshes the graph    
        Graph();
end

function [] = Graph(~,~) %Triggers when the "Graph" pushbutton is pressed
   global graph;
    
   %Takes whatever was typed in the y label edit box and creates a
   %text box near the y axis with the same text
   graph.defY = get(graph.ylabeledit,'string');
   graph.ytitle = uicontrol('style','text','position',[5 190 50 75],'string',graph.defY,'horizontalalignment','center');
   
   %Takes whatever strings the user imputs into the x and y value edit boxes and
   %makes them into numerical values
    graph.xdata = get(graph.xvaledit,'string');
        graph.xdata = str2num(graph.xdata);
    graph.ydata = get(graph.yvaledit,'string');
        graph.ydata = str2num(graph.ydata);
        
    %Takes whatever strings the user imputs into the x and y limit edit
    %boxes and makes them into numerical values
    graph.xlimit1 = get(graph.xedit,'string');
        graph.xlimit1 = str2num(graph.xlimit1);
    graph.xlimit2 = get(graph.xedit2,'string');
        graph.xlimit2 = str2num(graph.xlimit2);
    graph.ylimit1 = get(graph.yedit,'string');
        graph.ylimit1 = str2num(graph.ylimit1);
    graph.ylimit2 = get(graph.yedit2,'string');
        graph.ylimit2 = str2num(graph.ylimit2);

        %Creates a modal error message if the x and y value lengths are not
        %the same
        if length(graph.xdata) ~= length(graph.ydata)
            message = ['X and Y values are not the same length.'];
            msgbox(message,'Error!','modal');
            
        %Plots the values if the lengths are the same
        else
        str = append(graph.rad1,graph.rad2); %Combines the two modifing strings from the radio buttons
        graph.plot = plot(graph.xdata,graph.ydata,str); %Plots the graph with the appropriate modifiers
        xlim([graph.xlimit1 graph.xlimit2]); %Sets the new limits
        ylim([graph.ylimit1 graph.ylimit2]);
        end
    
end

function [] = reset(~,~) %Triggers when the "Reset" button is pushed
    global graph;
    close all %Closes the current open figure
    FinalProject(); %Reopens a fresh figure
end