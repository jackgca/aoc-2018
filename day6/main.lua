-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

--lines = helpers.lines_from("input.txt")

function part1()
    input = "67, 191|215, 237|130, 233|244, 61|93, 93|145, 351|254, 146|260, 278|177, 117|89, 291|313, 108|145, 161|143, 304|329, 139|153, 357|217, 156|139, 247|304, 63|202, 344|140, 302|233, 127|260, 251|235, 46|357, 336|302, 284|313, 260|135, 40|95, 57|227, 202|277, 126|163, 99|232, 271|130, 158|72, 289|89, 66|94, 111|210, 184|139, 58|99, 272|322, 148|209, 111|170, 244|230, 348|112, 200|287, 55|320, 270|53, 219|42, 52|313, 205|166, 259"

    input2 = "1, 1|1, 6|8, 3|3, 4|5, 5|8, 9"

    coords = {}
    i = 1
    for str in input:gmatch("([^|]+)") do
        coords[i] = {
            x = tonumber(str:match("(.*),")),
            y = tonumber(str:match(",(.*)"))
        }
        i = i + 1
    end

    xmin = nil
    ymin = nil
    xmax = 0
    ymax = 0

    for i,v in pairs(coords) do
        if (not xmin) then xmin = v.x end
        if (not ymin) then ymin = v.y end
        if (v.x < xmin) then xmin = v.x end
        if (v.y < ymin) then ymin = v.y end
        if (v.x > xmax) then xmax = v.x end
        if (v.y > ymax) then ymax = v.y end
    end

    closest_coord = {}

    function distance_to_point(x1, x2, y1, y2)
        return math.abs(x2 - x1) + math.abs(y2 - y1)
    end

    for i,v in pairs(coords) do
        for j=xmin,xmax do
            for k=ymin,ymax do
                coordinate = j .. "," .. k
                check_distance =  distance_to_point(v.x, j, v.y, k)
                if (not closest_coord[coordinate]) then
                    closest_coord[coordinate] = {
                        coord = {
                            x = v.x,
                            y = v.y
                        },
                        distance = check_distance
                    }
                else
                    if (closest_coord[coordinate].distance > check_distance) then
                        closest_coord[coordinate] = {
                            coord = {
                                x = v.x,
                                y = v.y
                            },
                            distance = check_distance
                        }
                    elseif (closest_coord[coordinate].distance == check_distance) then
                        closest_coord[coordinate] = {
                            coord = {
                                x = nil,
                                y = nil
                            },
                            distance = check_distance
                        }
                    end
                end
            end
        end
        print(v.x .. ", " .. v.y .. " done")
    end

    largest_area = {}

    for i,v in pairs(closest_coord) do
        if (v.coord.x and v.coord.y) then
            coordinate = v.coord.x .. "," .. v.coord.y
            if (largest_area[coordinate]) then
                largest_area[coordinate].count = largest_area[coordinate].count + 1
            else
                largest_area[coordinate] = {
                    count = 1
                }
            end

            x = tonumber(i:match("(.*),"))
            y = tonumber(i:match(",(.*)"))

            if (x == xmin or x == xmax or y == ymin or y == ymax) then
                largest_area[coordinate].invalid = true
            end
        end
    end

    largest = {
        count = 0,
        coord = nil
    }

    largest_list = {}

    for i,v in pairs(largest_area) do
        if (not v.invalid) then
            largest_list[#largest_list + 1] = v.count
        end
        if (v.count > largest.count and not v.invalid) then
            largest.count = v.count
            largest.coord = i
        end
    end

    print(largest.count)
    print(largest.coord)
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
