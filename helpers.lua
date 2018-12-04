local helpers = {}

function helpers.lines_from(file)
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

function timer_start()
    helpers.start_time = os.clock()
end

function timer_end()
    return os.clock() - helpers.start_time
end

function helpers.analyze(func)
    timer_start()
    print(func())
    print("time: " .. timer_end())
end

return helpers
