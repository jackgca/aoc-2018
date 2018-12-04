-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function by_date_time(a, b)
    print(a)
    print(b)
    print(string.sub(a, 7, 8))
    print(string.sub(b, 7, 8))
    if (tonumber(string.sub(a, 7, 8)) < tonumber(string.sub(b, 7, 8))) then
        return a
    elseif (tonumber(string.sub(a, 10, 11)) < tonumber(string.sub(b, 10, 11))) then
        return a
    elseif (tonumber(string.sub(a, 13, 14)) < tonumber(string.sub(b, 13, 14))) then
        return a
    elseif (tonumber(string.sub(a, 16, 17)) < tonumber(string.sub(b, 16, 17))) then
        return a
    else
        return b
    end
end

function part1()
    for i,v in ipairs(lines) do
        if (string.len(v) < 2) then
            table.remove(lines, i)
        end
    end
    table.sort(lines, by_date_time)
    for i,v in pairs(lines) do
        print(v)
    end
end


function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
