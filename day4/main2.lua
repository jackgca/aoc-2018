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
    for i, v in pairs(lines) do
        print(v)
    end
end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
