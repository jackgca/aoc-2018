-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
    twos = 0
    threes = 0
    for i,v in pairs(lines) do
        letters = {}
        for j = 1, string.len(v) do
            letter = string.sub(v, j, j)
            if (letters[letter]) then
                letters[letter] = letters[letter] + 1
            else
                letters[letter] = 1
            end
        end
        has_two = false
        has_three = false
        for j = 1, string.len(v) do
            if (letters[string.sub(v, j, j)] == 2 and not has_two) then
                twos = twos + 1
                has_two = true
            end
            if (letters[string.sub(v, j, j)] == 3 and not has_three) then
                threes = threes + 1
                has_three = true
            end
        end
    end
    return twos * threes
end

function part2()
    for i,v in pairs(lines) do
        for j, w in pairs(lines) do
            wrong_count = 0
            for i = 1, string.len(v) do
                if (string.sub(v, i, i) ~= string.sub(w, i, i)) then
                    wrong_count = wrong_count + 1
                end
                if (wrong_count == 2) then
                    break
                end
                if (i == string.len(v) and v ~= w) then
                    return v .. " " .. w
                end
            end
        end
    end
end

function run()
    --helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
