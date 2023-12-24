% Coefficients of Cubic Spline functions : "Not-a-Knot" end conditions
% Given n data points [xdata,ydata]
% Defines spline function for interval [xdata(k),xdata(k+1)] for k=1,...,n-1
% The spline functions are for i= 1 to n-1 :
%S_i(x)=a(i)/(6*h(i))*(x-x(i))^3+a(i-1)/(6*h(i))*(x(i+1)-x)^3+c(i)*(x-x(i))+
%d(i)*(x(i+1)-x)

clear all
xdata=[ ];% user input
ydata=[ ];% user input

n=length(xdata);
for i=1:n-1
   h(i)=xdata(i+1)-xdata(i);
end

AA=zeros(n,n);

% Need to find a0, a(1),...,a(n-1) : Vector p below
% Rows 1 to n-2 of matrix equation AA*p=bb
for i=1:n-2
   AA(i,i)=h(i)/6;
   AA(i,i+1)=(h(i)+h(i+1))/3;
   AA(i,i+2)=h(i+1)/6;
   
   bb(i)=(ydata(i+2)-ydata(i+1))/h(i+1)-(ydata(i+1)-ydata(i))/h(i);
end

% Not-a-Knot End conditions : Rows n-1 and n of matrix equation AA*p=bb
AA(n-1,1)=h(2);
AA(n-1,2)=-(h(1)+h(2));
AA(n-1,3)=h(1);
bb(n-1)=0;

AA(n,n-2)=h(n-1);
AA(n,n-1)=-(h(n-2)+h(n-1));
AA(n,n)=h(n-2);
bb(n)=0;

p=inv(AA)*bb';

a0=p(1);
for i=1:n-1
   a(i)=p(i+1);
end

for i=1:n-1
   c(i)=ydata(i+1)/h(i)-a(i)*h(i)/6;
end

d(1)=ydata(1)/h(1)-a0*h(1)/6;
for i=2:n-1
   d(i)=ydata(i)/h(i)-a(i-1)*h(i)/6;
end

b(1)=a0;
for i=2:n-1
   b(i)=a(i-1);
end
a0
a
c
d