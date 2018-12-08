-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
    steps = lines
    alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    alpha2 = "ABCDEF"

    alpha_list = {}

    for i=1,#alpha do
        alpha_list[i] = alpha:sub(i, i)
    end

    index_list = {}

    function update_index()
        for i=1,#alpha do
            index_list[alpha_list[i]] = i
        end
    end

    update_index()

    table.sort(steps)

    function sort_by_parent(index, l, r, par)
        table.sort(par)
        print("#")
        temp = ""
        for i,v in pairs(par) do
            temp = temp .. i
        end
        print(temp)
        table.insert(alpha_list, index_list[r], l)
        table.remove(alpha_list, index_list[l] + 1)
        for i=index,#alpha_list do
            if (par[steps[i]:sub(6, 6)]) then
                table.insert(alpha_list, index_list[r], steps[i]:sub(6, 6))
                table.remove(alpha_list, index_list[l] + 1)
            end
        end
        update_index()
    end

    parents = {}

    for i,v in pairs(steps) do
        left = v:sub(6, 6)
        right = v:sub(37 ,37)
        if (index_list[right] < index_list[left]) then
            if (not parents[left]) then
                parents[left] = {}
            end
            parents[left][right] = true
            sort_by_parent(index_list[left], left, right, parents[left])
        end
    end

    answer = ""
    for i,v in pairs(alpha_list) do
        answer = answer .. v
    end

    print(answer)
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
