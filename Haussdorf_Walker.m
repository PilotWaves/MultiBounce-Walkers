tiledlayout(2,1)

nexttile
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




% Run for each bisection

nexttile
tic

set(0,'DefaultAxesFontSize',16)

for pow = 9:13
eps = 1./(2.^([1:pow-1]-1));
N = 0*eps;

for i = 1:pow-1
    vin = linspace(0.2/2^pow,0.2,2^pow);
    for j = 1:2^(i-1)
        if j == 1
        vin_part = vin(1 + 2^pow*(j-1)/(2^(i-1))):0.2/2^(pow-3): vin(2^pow*j/(2^(i-1)));
        else
        vin_part = vin(2^pow*(j-1)/(2^(i-1))):0.2/2^(pow-3): vin(2^pow*j/(2^(i-1)));
        end
        %[vin_part(1), vin_part(end)]
        for k = 1:2^(i-1)
            %[vin(1 + 2^pow*(k-1)/(2^(i-1))), vin(2^pow*k/(2^(i-1)))]
            vin_high = vin(2^pow*k/(2^(i-1)));
            if k == 1
                vin_low = vin(1 + 2^pow*(k-1)/(2^(i-1)));
            else
                vin_low = vin(2^pow*(k-1)/(2^(i-1)));
            end
            for l = 1:length(vin_part)
            [vout, ~, ~] = nbounce(vin_part(l));
            if vout > vin_low && vout <= vin_high
                N(i) = N(i) + 1;
                break
            end
            end
        end
    end
end

log(N)./log(1./eps)

loglog(1./eps(2:end),N(2:end),'.','markersize',20)
xlabel('$1/\varepsilon$','FontSize',16,'Interpreter',"latex")
ylabel('$N(\varepsilon)$','FontSize',16,'Interpreter',"latex")
hold on

end

[~, objh] = legend({'$2^9$', '$2^{10}$', '$2^{11}$', '$2^{12}$ grid points'},'FontSize',16,'Interpreter',"latex",'orientation','horizontal','location','southoutside');
objhl = findobj(objh, 'type', 'line');
set(objhl, 'Markersize', 40);

hold off

toc