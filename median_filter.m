p = 4;
pad=uint8(zeros(size(i)+2*(p-1)));

for x=1:size(i,1)
            for y=1:size(i,2)
                pad(x+p-1,y+p-1)=i(x,y);
            end
end 

 for i= 1:size(pad,1)-(p-1)
    for j=1:size(pad,2)-(p-1)
        kernel=uint8(ones((p)^2,1));
        t=1;
        for x=1:p
          for y=1:p
                kernel(t)=pad(i+x-1,j+y-1);
                t=t+1;
          end
        end
        filt=sort(kernel);
        out(i,j)=filt(ceil(((p)^2)/2));
    end
 end
 