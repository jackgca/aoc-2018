-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
    function execute(line) 
        reactions = false
        for i=1,string.len(line) do
            first = string.sub(line, i, i)
            second = string.sub(line, i+1, i+1)
            if (string.lower(first) == string.lower(second)) then
                if (first ~= second) then
                    line = string.gsub(line, first .. second, "")
                    reactions = true
                end
            end
        end
        if (reactions == false) then
            print(string.len(line))
        else
            execute(line)
        end
    end

    for i,v in pairs(lines) do
        return execute(v)
    end
end

function part2()
    function execute(line)
        reactions = true
        while reactions do
            reaction_count = 0
            for i=1,#alpha do
                line, n = line:gsub(alpha:sub(i, i) .. alpha:sub(i, i):upper(), "")
                line, m = line:gsub(alpha:sub(i, i):upper() .. alpha:sub(i, i), "")
                reaction_count = reaction_count + n + m
            end
            if (reaction_count == 0) then
                reactions = false
            end
        end
        return string.len(line)
    end
    
    alpha = "qwertyuiopasdfghjklzxcvbnm"
    for j,v in pairs(lines) do
        for i=1,#alpha do
            letter = string.sub(alpha, i, i)
            temps = string.gsub(v, "(" .. letter .. ")", "")
            temps = string.gsub(temps, "(" .. string.upper(letter) .. ")", "")
            print(execute(temps))
        end
    end
end

function run()
    print("#")
    --helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
