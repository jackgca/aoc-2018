-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
    table.sort(lines, sort_by_2)
    points = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    points2 = "ABCDEF"
    edges = {}

    for i,v in pairs(lines) do
        table.insert(edges, v:sub(6, 6) .. v:sub(37, 37))
    end

    answer = ""

    function remove_edges(e, letter)
        answer = answer .. letter
        edges = true
        function remove_edge()
            for i,v in pairs(e) do
                if (letter == v:sub(1,1)) then
                    table.remove(e, i)
                    return true
                end
            end
            edges =  false
        end
        while edges do
            remove_edge()
        end
        points = points:gsub(letter, "")
        return e
    end

    function sort_graph(e)
        if (#points == 1) then
            return answer .. points
        end
        candidates = {}
        for i=1,#points do
            found_incoming = false
            for j,w in pairs(e) do
                if (points:sub(i,i) == w:sub(2,2)) then
                    found_incoming = true
                    break
                end
            end
            if (not found_incoming) then
                table.insert(candidates, points:sub(i,i))
            end
        end
        table.sort(candidates)
        return sort_graph(remove_edges(e, candidates[1]))
    end

    print(sort_graph(edges))

end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
