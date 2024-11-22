% Generic Descent Algorithm with Adaptive momentum for Ax=b
% Author : Mengqi Hu
% Date   : 01/22/2021

function [x,output] =  Linear_Grad_Descent_Adp(A,b,pm)
    [M,N] = size(A); start_time = tic; 
    if isfield(pm,'x0') 
        x = pm.x0; 
    else
        x = zeros(N,1);
    end
    if isfield(pm,'xg') 
        xg = pm.xg; 
    else
        xg = x;
    end
    if isfield(pm,'maxit')  
        maxit = pm.maxit; 
    else
        maxit = 5*N; 
    end    
    if isfield(pm,'reltol')
        reltol = pm.reltol;
    else
        reltol  = 1e-6;
    end
    if ~issymmetric(A)
        A0 = A'*A;
        Ab = A'*b;
    else
        A0 = A;
        Ab = b;
    end
    
    % objective function 0.5*norm(A*x-b)^2
% 	obj = @(t) 0.5*(A0*t-Ab)'*(A0*t-Ab);
    obj = @(u) 0.5*(u)'*A0*(u) - Ab'*(u);
    r = Ab;
    r = r-A0*x;
    p = r;
    for it = 1:maxit
       q = A0*p;
       alpha = (p'*r)/(p'*q);
       xold = x;
       x = x + alpha*p;
       r_old = r;
       r = r - alpha*q;
       beta = (r'*r)/(r_old'*r_old);
       p = r + beta*p;
       
       relerr      = norm(xold - x)/max([norm(x), norm(xold), eps]);
       residual    = norm(A*x - b)/norm(b);
       output.relerr(it)   = relerr;
       output.obj(it)      = obj(x);
       output.objd(it)     = abs(obj(x) - obj(xg));
       output.time(it)     = toc(start_time);
       output.res(it)      = residual;
       output.err(it)      = norm(x - xg)/norm(xg);
       if relerr < reltol && it > 2
           break;
       end
    end
end 