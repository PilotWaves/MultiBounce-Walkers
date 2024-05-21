tic

set(0,'DefaultAxesFontSize',16)

vin = [0:0.000002:0.2];

plot(0,0,'.','Color',[0, 0.4470, 0.7410])
hold on
plot(0,0,'.','Color',[0.9290, 0.6940, 0.1250])
hold on
plot(0,0,'.','Color',[0.4940, 0.1840, 0.5560])
hold on
plot(0,0,'.','Color',[1, 0, 0])
hold on


for i = 1:length(vin)
    [vout, bounces, nstop] = nbounce(vin(i));
    if bounces == 1
        BounceColor = [0, 0.4470, 0.7410]; % blue
        plot(vin(i),vout,'.','MarkerSize',1,'Color',BounceColor)
        hold on
    elseif bounces == 2
        BounceColor = [0.9290, 0.6940, 0.1250]; % yellow
        plot(vin(i),vout,'.','MarkerSize',2,'Color',BounceColor)
        hold on
    elseif bounces == 3
        BounceColor = [0.4940, 0.1840, 0.5560]; % purple
        plot(vin(i),vout,'.','MarkerSize',3,'Color',BounceColor)
        hold on
    elseif bounces > 4
        BounceColor = [1, 0, 0]; % red
        plot(vin(i),vout,'.','MarkerSize',6,'Color',BounceColor)
        hold on
    end
end

hold off

axis([0 0.2 0.001 0.2])
        xlabel('$v_{in}$','FontSize',16,'Interpreter',"latex")
        ylabel('$v_{out}$','FontSize',16,'Interpreter',"latex")

[~, objh] = legend({'$1$ bounce', '$2$ bounce', '$3$ bounce', '$> 4$ bounce'},'FontSize',16,'Interpreter',"latex",'orientation','horizontal','location','southoutside');
objhl = findobj(objh, 'type', 'line');
set(objhl, 'Markersize', 40);

toc