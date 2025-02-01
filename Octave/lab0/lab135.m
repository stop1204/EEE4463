clear;clc;
v= zeros(10,1);

v % show v



for i=1:10,
  v(i) = 2^i;

end;


v  % show v


for i=1:2:10,
  v(i)=i;
end;

v % show v


i=1;
while i<=5,
  v(i)=100;
  i=i+1;
 end

 v %show v


 v(1) %v(1)
 if v(1) ==1,
   disp('The value is one!');
 elseif v(1)==2,
   disp('The vaule is two!');
 else
   disp('The value is not one or two!');
 endif


 fprintf('\nmessage: v(1)=%d\n',v(1));

