--[[
-- This file is part of wtfthisstupidgame.
--
-- (c) 2016 YouniS Bensalah <younis.bensalah@gmail.com>
--
-- For the full copyright and license information, please view the LICENSE
-- file that was distributed with this source code.
--]]

WTFTHISSTUPIDGAME_VERSION = '1.1'

colors = {
    {r=0x88,g=0xff,b=0x00},
    {r=0xff,g=0x00,b=0xbb},
    {r=0x00,g=0xff,b=0xee},
    {r=0xfb,g=0xff,b=0x00}
}

function love.load()
    print("wtf this stupid game by younishd\nversion " .. WTFTHISSTUPIDGAME_VERSION)
    math.randomseed(os.time())
    love.window.setMode(600, 600)
    love.window.setTitle("wtf this stupid game by younishd")
    running = false
    timeleft = 10
    lasttimeleft = timeleft
    score = 0
    lastscore = 0
    highscore = 0
    next = -1
    flash = true
    flashcolor = 0
    toggleflash()
    h1font = love.graphics.newFont(32)
    h2font = love.graphics.newFont(26)
    h3font = love.graphics.newFont(18)
end

function love.update(dt)
    if running then
        timeleft = timeleft - dt
        running = timeleft > 0
        if not running then
            reset()
        end
    end
end

function love.draw()
    crazyflash()
    if running then
        love.graphics.rectangle('fill', 50 + next * 300, 100, 200, 400)
        love.graphics.setFont(h2font)
        love.graphics.print("score " .. score, 25, 25)
        love.graphics.print("time " .. string.format("%.3f", timeleft), 25, 545)
    else
        love.graphics.setFont(h1font)
        love.graphics.printf("WTF THIS STUPID GAME\n(by younishd)", 0, 150, 600, "center")
        love.graphics.setFont(h2font)
        love.graphics.print("score " .. lastscore .. " (" .. highscore .. ")", 25, 25)
        love.graphics.print("time " .. string.format("%.3f", lasttimeleft), 25, 545)
        love.graphics.printf("CLICK TO START", 0, 285, 600, "center")
        love.graphics.printf("How to play:", 0, 380, 600, "center")
        love.graphics.setFont(h3font)
        love.graphics.printf("LEFT/RIGHT mouse click\nif you see the rectangle on the left/right", 0, 420, 600, "center")
    end
end

function love.mousepressed(x, y, button)
    if running then
        -- love version < 0.10.0
        if (button == 1 or button == 'l') and next == 0 or (button == 2 or button == 'r') and next == 1 then
            yep()
        else
            reset()
        end
    else
        start()
    end
end

function love.conf(t)
    t.window.fsaa = 4
end

function reset()
    if timeleft > 0 then
        lasttimeleft = timeleft
    else
        lasttimeleft = 0
    end
    lastscore = score
    if lastscore > highscore then
        highscore = lastscore
    end
    timeleft = 10
    score = 0
    running = false
end

function start()
    running = true
    next = math.random(0, 1)
end

function yep()
    score = score + 1
    next = math.random(0, 1)
    toggleflash()
end

function toggleflash()
    flash = not flash
    flashcolor = colors[math.random(1, #colors)]
end

function crazyflash()
    if flash then
        love.graphics.setColor(0, 0, 0, 0xff)
        love.graphics.setBackgroundColor(flashcolor.r, flashcolor.g, flashcolor.b)
    else
        love.graphics.setColor(flashcolor.r, flashcolor.g, flashcolor.b, 0xff)
        love.graphics.setBackgroundColor(0, 0, 0)
    end
end
