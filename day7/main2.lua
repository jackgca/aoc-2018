-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("example.txt")

function sort_by_2(a, b)
    return a:sub(37, 37) > b:sub(37, 37)
end

function part1()
    table.sort(lines, sort_by_2)
    points = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    points = "ABCDEF"
    edges = {}
    for i,v in pairs(lines) do
        table.insert(edges, v:sub(6, 6) .. v:sub(37, 37))
    end
    
    table.sort(edges, edge_sort)

    answer = {}
    answers = ""
    letters = {}
    -- find start
    for i,v in pairs(edges) do
        letters[v:sub(2,2)] = true
    end

    start = nil

    for i=1,#points do
        if (not letters[points:sub(i,i)]) then
            start = points:sub(i,i)
            break
        end
    end

    print(start)

    answer = {}
    index = {}
    for i,v in pairs(points) do
        table.insert(answer, v)
        table.insert(index, i, v)
    end

    for i,v in pairs(edges) do
        left = v:sub(1,1)
        right = v:sub(2,2)
        if (index[right] < index[left]) then
            table.insert(answer, index[right], left)
            table.remove(answer, index[left] + 1)
            table.insert(index, answer[right], )
        

    --print(answers)
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
