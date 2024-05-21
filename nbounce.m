function[vout, bounces, nstop] = nbounce(vin)

N = 1000;
M = 2;

v = zeros(M,N);
x = v;

set(0,'DefaultAxesFontSize',14)

omega = 31/2;
nu = omega^2/2.1/4/pi^2;
K = -(pi*exp(nu*pi^2))/(sin(pi*omega));

C = 1/(5*K);

v(:,1) = [vin -vin]; % v = 5/(3*del)
x(:,1) = [-1/2 1/2];

% writerObj = VideoWriter('MultipleSpeed.avi');
% writerObj.FrameRate = 5;
% open(writerObj);

bounces = 0;
nstop = N;


for n = 1:N-1
    
    if abs(x(1,n)-x(2,n)) < 1
        eta = exp(1 - 1/(1-((x(1,n)-x(2,n)))^2));
    else
        eta = 0;
    end
    
    v(1,n+1) = C*(v(1,n) + K*sin(omega*v(1,n))*exp(-v(1,n)^2*nu) + K*eta*sign((x(1,n) - x(2,n)))*exp(-nu*(x(1,n) - x(2,n))^2));

    %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-v(1,n)^2*del^2/(8.4*pi^2)) + K*eta*sign(x(1,n) - x(2,n))*exp(-(del^2/(8.4*pi^2))*(x(1,n) - x(2,n))^2));
        %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-abs(v(1,n))*del/(4.2*pi)) + K*sign(x(1,n) - x(2,n))*exp(-(del/(4.2*pi))*abs(x(1,n) - x(2,n))));
        %v(1,n+1) = mu*(v(1,n) + K*sin(del*v(1,n))*exp(-abs(v(1,n))*del/(4.2*pi)) + K*eta*sign(x(1,n) - x(2,n))*exp(-(del/(4.2*pi))*abs(x(1,n) - x(2,n))));
        
        
    x(1,n+1) = x(1,n) + v(1,n+1);

    v(2,n+1) = C*(v(2,n) + K*sin(omega*v(2,n))*exp(-v(2,n)^2*nu) + K*eta*sign((x(2,n) - x(1,n)))*exp(-nu*(x(2,n) - x(1,n))^2));

    %v(2,n+1) = mu*(v(2,n) + K*sin(del*v(2,n))*exp(-v(2,n)^2*del^2/(8.4*pi^2)) + K*eta*sign(x(2,n) - x(1,n))*exp(-(del^2/(8.4*pi^2))*(x(2,n) - x(1,n))^2));
        %v(2,n+1) = mu*(v(2,n) + K*sin(del*v(2,n))*exp(-abs(v(2,n))*del/(4.2*pi)) + K*sign(x(2,n) - x(1,n))*exp(-(del/(4.2*pi))*abs(x(2,n) - x(1,n))));
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

% if n>20
% if v(2,n-19:n+1) >  0
%    break 
% end
% end

% if x(2,n+1) < 1 && influence == 0
%     influence = 1;
% end

if n > 1
if (v(2,n+1) == 0 && v(2,n-1) < 0 && v(2,n+1) > 0) || (v(2,n) < 0 && v(2,n+1) > 0)
    bounces = bounces + 1;
end
end


if abs(x(2,n+1)) > 0.5
    if x(2,2) > x(2,1) || x(2,n+1) < 0
        vout = 0; 
    else
        vout = mean(v(2,n:n+1)); 
    end
    nstop = n+1;
   break 
end

if n+1 == N
    vout = 0;
else
    vout = v(2,n+1);
end

end

%mean(v(2,n-9:n+1));

% if x(2,n+1) < 1
%    vout = 0; 
% end

 %close(writerObj)
 
% plot([1:N],x(2,:),'LineWidth',5)
% xlabel('n')
% ylabel('x')