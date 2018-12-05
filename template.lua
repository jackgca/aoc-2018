-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("example.txt")

function part1()

end

function part2()

end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
