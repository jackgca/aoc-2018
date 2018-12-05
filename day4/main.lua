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
            guards[guard_id].time_asleep = guards[guard_id].time_asleep + ( 
                tonumber(string.sub(lines[i + 1], 16, 17)) - minute)
        end
    end
    
    sleepiest = 0
    time_asleep = 0
    
    for i=1,#guard_list do
        if (guards[guard_list[i]].time_asleep > time_asleep) then
            sleepiest = guard_list[i]
            time_asleep = guards[guard_list[i]].time_asleep
        end
    end

    sleep = {}
    
    for i=0,59 do
        sleep[i] = 0
    end
    sleepy_guard = false
    for i,v in pairs(lines) do
        if (string.find(v, "#")) then
            if (string.find(v, "#" .. sleepiest)) then
                sleepy_guard = true
            else
                sleepy_guard = false
            end
        end
        if (sleepy_guard) then
            if (string.find(v, "falls")) then
                startminute = tonumber(string.sub(v, 16, 17))
                endminute = tonumber(string.sub(lines[i + 1], 16, 17))
                for j=startminute,endminute do
                    sleep[j] = sleep[j] + 1
                end
            end
        end
    end
    most_minutes = 0
    the_minute = 0
    
    for i=0,59 do
        if (sleep[i] > most_minutes) then
            most_minutes = sleep[i]
            the_minute = i
        end
    end
    
    return the_minute * sleepiest
end

function part2()
    table.sort(lines, datetime)
    guards = {}
    guard_id = 0
    guards_list = {}
    current_guard = 0
    for i,v in pairs(lines) do
        minute = tonumber(string.sub(v, 16, 17))
        if (string.find(v, "#")) then
            current_guard = string.match(v, "#(.*)b")
            if (not guards_list[current_guard]) then
                guards_list[current_guard] = {}
                for i=0,59 do
                    guards_list[current_guard][i] = 0
                end
            end
        end
        if (string.find(v, "falls")) then
            minute_start = tonumber(string.sub(v, 16, 17))
            minute_end = tonumber(string.sub(lines[i+1], 16, 17))
            for j=minute_start,minute_end do
                guards_list[current_guard][j] = guards_list[current_guard][j] + 1
            end
        end
    end

    guard_id = 0
    sleepiest_minute = 0
    most_minutes = 0
    for i,v in pairs(guards_list) do
        for j=0,59 do
            if (guards_list[i][j] > most_minutes) then
                most_minutes = guards_list[i][j]
                sleepiest_minute = j
                guard_id = i
            end
        end
    end
    print(sleepiest_minute)
    print(guard_id)
    return sleepiest_minute * guard_id
end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
