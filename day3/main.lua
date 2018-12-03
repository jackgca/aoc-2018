-- load helper module
package.path = package.path .. ";../?.lua"
helpers = require "helpers"

lines = helpers.lines_from("input.txt")

function part1()
    suit = {}
    maxwidth = 0
    maxheight = 0
    for k,v in pairs(lines) do
        left = tonumber(string.match(v, "@(.*),"))
        top = tonumber(string.match(v, ",(.*):"))
        width = tonumber(string.match(v, ":(.*)x"))
        height = tonumber(string.match(v, "x(.*)"))
        if (maxwidth < left + width) then
            maxwidth = left + width
        end
        if (maxheight < top + height) then
            maxheight = top + height
        end
        for i=left,left + width - 1 do
            for j=top,top + height - 1 do
                if (not suit[i]) then
                    suit[i] = {}
                end
                
                if (not suit[i][j]) then
                    suit[i][j] = 1
                elseif (suit[i][j] == 1) then
                    suit[i][j] = 2
                end
        
            end
        end
    end
    count = 0
    for i=1,maxwidth do
        for j=1,maxheight do
            if (suit[i] and suit[i][j] == 2) then
                count = count + 1
            end
        end
    end
    return count

end

function part2()
    suit = {}
    for k,v in pairs(lines) do
        left = tonumber(string.match(v, "@(.*),")) 
        top = tonumber(string.match(v, ",(.*):")) 
        width = tonumber(string.match(v, ":(.*)x")) 
        height = tonumber(string.match(v, "x(.*)")) 
        for i=left,left + width - 1 do
            for j=top,top + height - 1 do
                if (not suit[i]) then
                    suit[i] = {}
                end

                if (not suit[i][j]) then
                    suit[i][j]  = 1
                elseif (suit[i][j] == 1) then
                    suit[i][j] = 2
                end

            end
        end
    end
    for k,v in pairs(lines) do
        left = tonumber(string.match(v, "@(.*),")) 
        top = tonumber(string.match(v, ",(.*):")) 
        width = tonumber(string.match(v, ":(.*)x"))  
        height = tonumber(string.match(v, "x(.*)")) 
        hastwo = false
        for i=left,left + width - 1 do 
            for j=top,top + height - 1 do
                if (suit[i][j] == 2) then
                    hastwo = true
                end
            end
        end
        if (not hastwo) then
            return string.match(v, "#(.*)([0-9])")
        end
    end
end

function run()
    helpers.analyze(part1)
    helpers.analyze(part2)
end

run()
