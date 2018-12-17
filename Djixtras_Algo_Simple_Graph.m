s=[];
t=[];
p=5;
r=5;
q=1;
for i=1:15
    if(mod(i,3)~=0)
        s=[s,i,i];
        if i<12
            t=[t,i+1,i+4];
        else
            t=[t,i+1,i-11];
        end
    end
end

G=digraph(s,t);
plot(G);

