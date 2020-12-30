-- voltage controlled switch 
-- in1: select output based on 0-5v value
-- in2: cv input
-- out1-4: voltage from in2 (when selected)


function init()
    -- set window ranges of 1.25v to choose outputs
    input[1].mode( 'window', {0,1.25,2.5,3.75,5}, 0.1 )
    input[2].mode( 'stream', 0.01)
    for n=1,4 do
        output[n].slew=0
        output[n].volts=0
    end
end

dest = 1

input[1].window = function(state)
    dest = state

    for n=1,4 do
        if n == state then
        -- do nothing, maintain the current cv
        else
        -- reset to zero
            output[n].volts=0
        end
    end
end

input[2].stream = function(v)
    output[(dest%4)+1].volts = v
end    
