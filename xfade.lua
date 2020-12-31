-- voltage controlled cross fade - scan & width 
-- in1: scan - select output based on 0-5v value
-- in2: width - how wide the xfade should be
-- out1-4: voltage from in2 

bucket = {}
targets = {0,1.666,3.333,5}
width = 1.5
peak_volts = 10 

function init()
    input[1].mode( 'stream', 0.01)
    input[2].mode( 'stream', 0.01)
    for n=1,4 do
        output[n].slew=0.01
        output[n].volts=0
    end
end

input[2].stream = function(v)
    width = math.abs(v)
end

input[1].stream = function(v)
    for n=1,4 do 
        bucket[n] = width - math.abs(v - targets[n])
        if bucket[n] > 0 then
            output[n].volts = peak_volts * (bucket[n] / width)
        else
            output[n].volts = 0 
        end
    end
end

   
