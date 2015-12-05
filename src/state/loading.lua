local palette = require "palette"
local Character = require "character"

local lg = love.graphics
local lgh, lgw = lg:getHeight(), lg.getWidth()

local loading = {
  loaded = 0,
  loadingSpeed = 0.03,
  player = Character:new({x=lgw*.5, y=lgh*.84}),
  remTimeUnits = {"seconds", "days", "years", "minutes", "hours", "lifetimes"},
  remaining = math.random(3,9).. " seconds",
}


function loading:draw ()
  love.graphics.setColor(palette[2])
  love.graphics.rectangle("fill", 0, 0, lgw, lgh)

  love.graphics.setColor(palette[5])
  love.graphics.rectangle("fill", lgw*.1, lgh*.64, lgw*.8*self.loaded, lgh*.2)

  love.graphics.setColor(palette[1])
  love.graphics.setLineWidth(10)
  love.graphics.rectangle("line", lgw*.1, lgh*.64, lgw*.8, lgh*.2) -- TODO inner box size

  love.graphics.setColor(palette[1])
  love.graphics.setFont(game.fonts.text)
  love.graphics.printf(math.floor(self.loaded*100) .."% done. Remaining "..self.remaining, 0, 280, lgw, 'center')
  love.graphics.setFont(game.fonts.large)
  love.graphics.printf("Loading", 0, 100, lgw, 'center')

  self.player:draw()
end


function loading:update (dt)

self.loaded = self.loaded + dt * self.loadingSpeed
if self.loaded >= 1 then game.state = game.states.mainmenu end
if math.floor(self.loaded*1000)%50==0 then
  self.remaining = math.random(1, 200) .. " " .. self.remTimeUnits[math.random(#self.remTimeUnits)]
end

if love.keyboard.isDown('down')  then self.player:down() end
if love.keyboard.isDown('up')    then self.player:jump() end
if love.keyboard.isDown('left')  then self.player:walk(-1) end
if love.keyboard.isDown('right') then self.player:walk(1) end

self.player:update(dt)
if self.loaded > .97 then self.player.dead = true end

local loadingPos = lgw*.1 + lgw*.8*self.loaded

if loadingPos > self.player.pos.x - self.player.size.w/2 then
  self.player.pos.x = loadingPos + self.player.size.w/2
  self.player.speed.x = - self.player.speed.x * 0.1
  --self.player:walk(0.1)
end
if self.player.pos.x + self.player.size.w/2 > lgw*.9 then
  self.player.pos.x = lgw*.9 - self.player.size.w/2 - 3
  self.player.speed.x = - self.player.speed.x * 0.05
end

-- FIXME
local left =  loadingPos
for i, poop in ipairs(self.player.poops) do
  if poop < left+9 then
    self.player.poops[i] = math.min(left+9, lgw*.9-12)
    left = left + 18
  end
end


end


function loading:keypressed(key, unicode)
  -- if key == "escape" then love.event.quit() end -- TODO

  if key == "p" then self.player:poop() end

end


return loading
