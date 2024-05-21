N = 1000;
M = 2;
t = [1:N];

v = zeros(M,N);
x = v;

xline = [-2 2];

%set(0,'DefaultAxesFontSize',20)

omega = 31/2;
nu = omega^2/2.1/4/pi^2;
K = -(pi*exp(nu*pi^2))/(sin(pi*omega));

C = 1/(5*K);

%vin = 5/(3*omega); 
%vin = (8/6)*2*pi/omega;
%vin = 0.1335045; % multi bounce
%vin = 0.01; % two bounce
%vin = 0.15; % one bounce
vin = 0.135; % bound state
v(:,1) = [vin -vin];
x(:,1) = [-1/2 1/2];

% writerObj = VideoWriter('MultipleSpeed.avi');
% writerObj.FrameRate = 5;
% open(writerObj);


for n = 1:N-1
    
    if abs(x(1,n)-x(2,n)) < 1
        eta = exp(1 - 1/(1-((x(1,n)-x(2,n)))^2));
    else
        eta = 0;
    end

    v(1,n+1) = C*(v(1,n) + K*sin(omega*v(1,n))*exp(-v(1,n)^2*nu) + K*eta*sign((x(1,n) - x(2,n)))*exp(-nu*(x(1,n) - x(2,n))^2));
            %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-abs(v(1,n))*del/(4.2*pi)) + K*eta*sign(x(1,n) - x(2,n))*exp(-(del/(4.2*pi))*abs(x(1,n) - x(2,n))));
    
    x(1,n+1) = x(1,n) + v(1,n+1);

    v(2,n+1) = C*(v(2,n) + K*sin(omega*v(2,n))*exp(-v(2,n)^2*nu) + K*eta*sign((x(2,n) - x(1,n)))*exp(-nu*(x(2,n) - x(1,n))^2));
            %v(2,n+1) = mu*(v(2,n) + K*sin(del*v(2,n))*exp(-abs(v(2,n))*del/(4.2*pi)) + K*eta*sign(x(2,n) - x(1,n))*exp(-(del/(4.2*pi))*abs(x(2,n) - x(1,n))));
    
    x(2,n+1) = x(2,n) + v(2,n+1);
    
%     h = plot(xline,xline*0,'-',x(1,n),x(1,n)*0,'.',x(2,n),x(2,n)*0,'.');
%     set(h(2),'MarkerSize',30);
%     set(h(3),'MarkerSize',30);
%     set(h(1),'LineWidth',5);
%     axis([-10 10 -1 1]);
%     axis off

%     frame = getframe(gcf);
%     writeVideo(writerObj,frame);

% if x(2,n+1) < 1 && influence == 0
%     influence = 1;
% end

if abs(x(2,n+1)) > 0.5
   break 
end


end

 %close(writerObj)

% plot([1:n+1],x(2,1:n+1), '.', [1:n+1],x(1,1:n+1),'.','Markersize',60)
% ylabel('$x$','Interpreter',"latex");
% xlabel('$n$','Interpreter',"latex");
% pbaspect([(1 + sqrt(5))/2 1 1]);
% fontsize(gcf,scale = 1.5);


plot([1:100],x(2,1:100), '-', [1:100],x(1,1:100),'-','LineWidth',5)
ylabel('$x$','Interpreter',"latex");
xlabel('$n$','Interpreter',"latex");
pbaspect([(1 + sqrt(5))/2 1 1]);
fontsize(gcf,scale = 1.5);