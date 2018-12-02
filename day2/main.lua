-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
