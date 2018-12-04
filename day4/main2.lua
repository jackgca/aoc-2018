-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function datetime(a, b)
    amonth = string.sub(a, 7, 8)
    bmonth = string.sub(b, 7, 8)
    aday = string.sub(a, 10, 11)
    bday = string.sub(b, 10, 11)
    ahour = string.sub(a, 13, 14)
    bhour = string.sub(b, 13, 14)
    aminute = string.sub(a, 16, 17)
    bminute = string.sub(b, 16, 17)
    anum = tonumber(amonth .. aday .. ahour .. aminute)
    bnum = tonumber(bmonth .. bday .. bhour .. bminute)

    return anum < bnum
end

function part1()
    table.sort(lines, datetime)
    
    guards = {}
    guard_id = 0
    guard_list = {}
    for i, v in pairs(lines) do
        minute = tonumber(string.sub(v, 16, 17))
        if (string.find(v, "#")) then
            guard_id = tonumber(string.match(v, "#(.*)b"))
            guard_list[#guard_list + 1] = guard_id
            if (not guards[guard_id]) then
                guards[guard_id] = {
                    time_asleep = 0
                }
            end
        end
        if (string.find(v, "falls")) then
            print(lines[i])
            print(lines[i + 1])
            guards[guard_id].time_asleep = guards[guard_id].time_asleep + ( 
                tonumber(string.sub(lines[i + 1], 16, 17)) - minute)
        end
    end
    sleepiest = 0
    time_asleep = 0
    for i=1,#guard_list do
        if (guards[guard_list[i]].time_asleep > sleepiest) then
            sleepiest = guard_list[i]
            time_asleep = guards[guard_list[i]].time_asleep
        end
    end
    print(sleepiest)
    print(time_asleep)
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
