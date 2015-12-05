local palette = require "palette"

local lg = love.graphics
local lgh, lgw = lg:getHeight(), lg.getWidth()

local m = {
  menu = {
    {l="New Game", cb=love.event.quit},
    {l="Options",  cb=love.event.quit},
    {l="Credits",  cb=love.event.quit},
    {l="Quit",     cb=love.event.quit},
  },
  selected = 1,
}

function m:draw ()
love.graphics.setColor(palette[2])
love.graphics.rectangle("fill", 0, 0, lgw, lgh)

love.graphics.setColor(palette[1])

love.graphics.setFont(game.fonts.large)
love.graphics.printf("Loading", 0, 100, lgw, 'center')

love.graphics.setFont(game.fonts.text)
for k,v in ipairs(self.menu) do
  local l = v.l
  if self.selected == k then l = "> " .. l .. " <" end
  love.graphics.printf(l, 0, 280+32*k, lgw, 'center')
end
end

function m:update (dt)
end

function m:keypressed(key, unicode)
  if key == "down"   then self.selected = self.selected % #self.menu + 1 end
  if key == "up"     then self.selected = (self.selected + #self.menu - 2) % #self.menu + 1 end -- I dont know....
  if key == "return" then self.menu[self.selected].cb() end
end

return m
