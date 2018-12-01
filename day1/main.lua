-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

-- load input
local file = 'input-rob.txt'
local lines = helpers.lines_from(file)

function part1()
    local freq = 0

    for k,v in pairs(lines) do
        freq = freq + tonumber(v)
    end

    return freq
end

function part2()
    local freq = 0
    local freqs = {}

    while true do
        for k,v in pairs(lines) do
            freq = freq + tonumber(v)
            if (freqs[freq]) then
                return freq
            end
            freqs[freq] = true
        end
    end
end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()