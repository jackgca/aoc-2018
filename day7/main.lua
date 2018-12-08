-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
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
    points = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    edges = {}

    for i,v in pairs(lines) do
        table.insert(edges, v:sub(6,6) .. v:sub(37,37))
    end

    answer = ""

    workers = {}

    for i=1,5 do
        workers[i] = {
            step = nil,
            time_left = nil
        }
    end

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
            edges = false
        end
        while edges do
            remove_edge()
        end
        points = points:gsub(letter, "")
        return e
    end

    steps_added = {}

    function tick()
        assign_work()
        for i=1,#workers do
            if (workers[i].step) then
                workers[i].time_left = workers[i].time_left - 1
            end
            if (workers[i].time_left == 0) then
                workers[i].step = nil
                workers[i].time_left = nil
            end
        end
    end

    steps_queue = {}
    total_time = 0

    function assign_work()
        for j=1,#workers do
            if (not workers[j].step) then
                if (steps_queue[1]) then
                    workers[j].step = steps_queue[1]
                    time = 60 + (steps_queue[1]:byte() - 64)
                    workers[j].time_left = time
                    print("step " .. steps_queue[1] .. "  will take " .. time .. " seconds")
                    print("assigned to worker " .. j)
                    total_time = total_time + time
                    table.remove(steps_queue, 1)
                end
            end
        end
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
        for i=1,#candidates do
            if (not steps_added[candidates[i]]) then
                steps_added[candidates[i]] = true
                table.insert(steps_queue, candidates[i])
            end
        end

        return sort_graph(remove_edges(e, candidates[1]))
    end

    function still_work()
        for i=1,#workers do
            if (workers[i].step) then
                return true
            end
        end
        return false
    end

    sort_graph(edges)
    assign_work()

    while still_work() do
        tick()
    end

    return total_time

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
