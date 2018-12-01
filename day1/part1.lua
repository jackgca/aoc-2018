function lines_from(file)
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

local file = 'input.txt'
local lines = lines_from(file)

freq = 0
freqs = {}
count = 0
function findFreq()
    while true do
        count = count + 1
        for k,v in pairs(lines) do
            freq = freq + tonumber(v)
            if (freqs[freq]) then
                return freq
            end
            freqs[freq] = true
        end
        print(count)
    end
end

print(findFreq())