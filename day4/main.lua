-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function month(a, b)
    if (tonumber(string.sub(a, 7, 8)) < tonumber(string.sub(b, 7, 8))) then
        return true
    elseif (tonumber(string.sub(a, 10, 11)) < tonumber(string.sub(b, 10, 11))) then
        return true
    elseif (tonumber(string.sub(a, 13, 14)) < tonumber(string.sub(b, 13, 14))) then
        return true
    elseif (tonumber(string.sub(a, 16, 17)) < tonumber(string.sub(b, 16, 17))) then
        return true
    end
end

function part1()
    guards = {}
    current_guard = 0
    guards_list = {}
    table.sort(lines, month)
    for i, v in pairs(lines) do
        if (string.find(v, "#")) then
            current_guard = string.match(v, "#(.*)b")
            if (not guards[current_guard]) then
                guards[current_guard] = {}
                guards_list[#guards_list + 1] = current_guard
            end
        elseif (string.find(v, "falls")) then
            minute = string.sub(v, 16, 17)
            if (not guards[current_guard].time_sleep) then
                guards[current_guard].time_asleep = 0
            end
            sleep_time = tonumber(string.sub(lines[i + 1], 16, 17)) - tonumber(minute)
            guards[current_guard].time_asleep = guards[current_guard].time_asleep + sleep_time
        end
    end
    most_asleep = 0
    guard = 0
    for i=1,#guards_list do
        if (guards[guards_list[i]].time_asleep and guards[guards_list[i]].time_asleep > most_asleep) then
            most_asleep = guards[guards_list[i]].time_asleep
            guard = guards_list[i]
        end
    end
    sleep = {}
    current_guard = 0
    for i, v in pairs(lines) do
        current_guard = string.match(v, "#(.*)b")
        if (string.find(v, "#" .. guard)) then
            yes = true
        else
            yes = false
        
        end
    end
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
