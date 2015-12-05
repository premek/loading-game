local palette = require "palette"

local lg = love.graphics
local lgh, lgw = lg:getHeight(), lg.getWidth()


local getSlide = function(txt)
  return function(t)
    love.graphics.setColor(palette[2])
    love.graphics.rectangle("fill", 0, 0, lgw, lgh)
    local c = palette[1]
    local a = math.min(3*t, 255, -3*(t-255)) -- I like this!
    love.graphics.setColor(c[1], c[2], c[3], a)
    love.graphics.setFont(game.fonts.text)
    love.graphics.printf(txt, 0, 160, lgw, 'center')
  end
end

local m = {
  t = 0,
  slides = {
    function(_) end,
    function(t)
      local c = palette[2]
      love.graphics.setColor(c[1], c[2], c[3], math.min(2*t, 255))
      love.graphics.rectangle("fill", 0, 0, lgw, lgh)
    end,
    getSlide("WhooshSound Games"),
    getSlide("in cooperation with"),
    getSlide("4.55 Entertainment"),
    getSlide("presents"),
    getSlide("a BubbleHorse Studios game"),

    function(t)
      love.graphics.setColor(palette[2])
      love.graphics.rectangle("fill", 0, 0, lgw, lgh)
      local c = palette[1]
      love.graphics.setColor(c[1], c[2], c[3], t)
      love.graphics.setFont(game.fonts.large)
      love.graphics.printf("Loading", 0, 100, lgw, 'center')
    end,
  }
}

function m:draw ()
    self.slides[self.slideNum](self.slideTime)
end

function m:update (dt)
  self.t = self.t + dt
  self.slideNum = math.floor(self.t*50 / 255) + 1 -- 1,2,3,...
  self.slideTime = self.t*50 % 255 -- 0 - 255

  if self.slideNum > #self.slides then game.state = game.states.loading end
end

function m:keypressed(key, unicode)
end

return m
