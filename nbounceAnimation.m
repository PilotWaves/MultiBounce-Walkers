N = 1000;
M = 2;
t = [1:N];
tj = 0;

v = zeros(M,N);
x = v;

xline = [-2 2];

set(0,'DefaultAxesFontSize',14)

omega = 31/2;
nu = omega^2/2.1/4/pi^2;
K = -(pi*exp(nu*pi^2))/(sin(pi*omega));

C = 1/(5*K);

vin = 0.01;
v(:,1) = [vin -vin];
x(:,1) = [-1/2 1/2];

% writerObj = VideoWriter('MultipleSpeed.avi');
% writerObj.FrameRate = 5;
% open(writerObj);

count = 0;

for n = 1:N-1
    
    if abs(x(1,n)-x(2,n)) < 1
        eta = exp(1 - 1/(1-((x(1,n)-x(2,n)))^2));
    else
        eta = 0;
    end
    
        %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-abs(v(1,n))*del/(4.2*pi)) + K*sin(del*(x(1,n) - x(2,n)))*exp(-(del/(4.2*pi))*abs(x(1,n) - x(2,n))));

    v(1,n+1) = C*(v(1,n) + K*sin(omega*v(1,n))*exp(-v(1,n)^2*nu) + K*eta*sign((x(1,n) - x(2,n)))*exp(-nu*(x(1,n) - x(2,n))^2));
    %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-v(1,n)^2*del^2/(8.4*pi^2)) + K*eta*sign(x(1,n) - x(2,n))*exp(-(del^2/(8.4*pi^2))*(x(1,n) - x(2,n))^2));
            %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-abs(v(1,n))*del/(4.2*pi)) + K*eta*sign(x(1,n) - x(2,n))*exp(-(del/(4.2*pi))*abs(x(1,n) - x(2,n))));
    
    x(1,n+1) = x(1,n) + v(1,n+1);

        %v(2,n+1) = mu*(v(2,n) + K*sin(del*v(2,n))*exp(-abs(v(2,n))*del/(4.2*pi)) + K*sin(del*(x(2,n) - x(1,n)))*exp(-(del/(4.2*pi))*abs(x(2,n) - x(1,n))));

    v(2,n+1) = C*(v(2,n) + K*sin(omega*v(2,n))*exp(-v(2,n)^2*nu) + K*eta*sign((x(2,n) - x(1,n)))*exp(-nu*(x(2,n) - x(1,n))^2));
    
    %v(2,n+1) = mu*(v(2,n) + K*sin(del*v(2,n))*exp(-v(2,n)^2*del^2/(8.4*pi^2)) + K*eta*sign(x(2,n) - x(1,n))*exp(-(del^2/(8.4*pi^2))*(x(2,n) - x(1,n))^2));
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

if abs(x(2,n+1)) > 0.5
   break 
end


end

E = v(2,1:n+1).^2/2 + exp(-2*x(2,1:n+1)) - exp(-x(2,1:n+1));

% alpha = 1;
% E0 = alpha^2/tj(1)^2;
% Efinal = alpha^2/t(tfinal - tj(count))^2;
% 
% for j = 1:count-1
%    Ej(j) = alpha^2/(tj(j+1)-tj(j))^2; 
% end
% 
% Ej = [E0 Ej Efinal];

% writerObj = VideoWriter('nbounce.avi');
% writerObj.FrameRate = 5;
% open(writerObj);

tiledlayout(3,2)

for i = 1:n

if i == 1 || (1 < i < n && ((v(2,i+1) == 0 && v(2,i-1) < 0 && v(2,i-1) > 0) || (v(2,i) < 0 && v(2,i+1) > 0) || (x(2,i+1) < x(2,i) && x(2,i-1) < x(2,i))))

    nexttile
    h = plot(xline,xline*0,'-',x(1,i),x(1,i)*0,'.',x(2,i),x(2,i)*0,'.');
    set(h(2),'MarkerSize',100);
    set(h(3),'MarkerSize',100);
    set(h(1),'LineWidth',5);
    axis([-0.6 0.6 -0.1 0.1]);
    axis off
    %pause

    %i
end
    

%     l = plot([1:n+1],E,'m',i,E(i),'k.');
%     set(l(1),'LineWidth',5);
%     set(l(2),'MarkerSize',40)
%     xlabel('n')
%     ylabel('E')
    
%     subplot(3,1,2);
%     g = plot([1:n+1],x(2,1:n+1),i,x(2,i),'k.');
%     set(g(1),'LineWidth',5);
%     set(g(2),'MarkerSize',40)
%     xlabel('n')
%     ylabel('x')

%     frame = getframe(gcf);
%     writeVideo(writerObj,frame);
end

    nexttile([1,2])
    plot([1:n+1],x(2,1:n+1),'linewidth',4);
    xlabel('n')
    ylabel('x')

% close(writerObj)
 
% yyaxis left
% plot([1:n+1],x(2,1:n+1),'LineWidth',5)
% hold on
% yyaxis right
% plot([1:n+1],v(2,1:n+1),'LineWidth',5)
% xlabel('n')
% ylabel('x')