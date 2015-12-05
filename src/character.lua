local palette = require "palette"

local Character = {}

function Character:new (pos)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  -- TODO understand lua metatables, __index. etc.

  o.pos = pos
  o.facing = 0 -- 1=right, 0=front, -1=left
  o.ground = pos.y-5 -- TODO replace with collision
  o.size = {w=20, h=40}

  o.speed = {x=0, y=0}
  o.maxSpeed = {x=500, y=400}
  o.acceleration = {x=200, y=350}
  o.gravity = 20
  o.friction = 0.9

  o.dead = false
  o.deadTime = 0
  o.poops = {} -- x positions
  o.pooping = 0 -- time until pooping is finished

  --print("creating character", o.pos.x, o.pos.y)
  return o
end


function Character:walk(x)
  if self.pooping <= 0 and self.speed.y == 0 then
    self.speed.x = self.speed.x + x * self.acceleration.x
  end
  self.facing = x / math.abs(x)
end

function Character:jump()
  if self.pooping <= 0 and self.pos.y == self.ground then
    self.speed.y = -self.acceleration.y
  end
  self.facing = 0
end

function Character:down()
  self.speed.x = self.speed.x * 0.9
  self.facing = 0
end

function Character:poop()
  if self.pooping <= 0 and self.speed.x < 0.3 then
    self.pooping = .8 -- how long to sit down
    table.insert(self.poops, self.pos.x)
  end
end



function Character:update(dt)
  if self.dead then
    self.deadTime = self.deadTime + dt
    return
  end

  if self.pooping > 0 then self.pooping = self.pooping - dt end

  -- gravity
  self.speed.y = self.speed.y + self.gravity
  -- friction
  self.speed.x = math.floor(self.speed.x * self.friction * 100)*0.01
  -- update pos
  self.pos.x = self.pos.x + self.speed.x * dt
  self.pos.y = self.pos.y + self.speed.y * dt

  -- TODO proper collision
  if self.pos.y > self.ground then
    self.pos.y = self.ground
    self.speed.y = 0
  end

end



function Character:drawDead()
  love.graphics.setColor(palette[3])
  for i=1, self.deadTime*2500 do
    love.graphics.circle("fill",
        self.pos.x +  math.random(0, i) - i*.5,
        self.pos.y-self.size.h/2 + math.random(0, i) - i*.5,
        i/200+10)
  end
end



function Character:draw()
  if self.dead then self:drawDead(); return end

  local pos = {x = self.pos.x, y = self.pos.y}
  if self.pooping > 0 then pos.y = pos.y + 10 end

  love.graphics.setColor(palette[3])

  --love.graphics.rectangle("fill", self.pos.x, self.pos.y, 1,1)

  -- body
  love.graphics.rectangle("fill", pos.x-self.size.w*0.5, pos.y-self.size.h, self.size.w,self.size.h*0.64)

  -- legs
  if self.pooping <= 0 then
    if self.facing == 0 then
      love.graphics.rectangle("fill", pos.x-self.size.w*0.5, pos.y-self.size.h*0.36, self.size.w*0.3, self.size.h*0.36)
      love.graphics.rectangle("fill", pos.x+self.size.w*0.2, pos.y-self.size.h*0.36, self.size.w*0.3, self.size.h*0.36)
    else
      love.graphics.rectangle("fill", pos.x-self.size.w*0.2*self.facing-self.size.w*0.15, pos.y-self.size.h*0.36, self.size.w*0.3, self.size.h*0.36)
      love.graphics.rectangle("fill", pos.x-self.size.w*0.05*self.facing-self.size.w*0.3, pos.y-self.size.h*0.1, self.size.w*0.6, self.size.h*0.1)
    end
  end

  -- arms
  if self.facing == 0 then
    love.graphics.rectangle("fill", pos.x-self.size.w*0.9, pos.y-self.size.h, self.size.w*0.3, self.size.h*0.5)
    love.graphics.rectangle("fill", pos.x+self.size.w*0.6, pos.y-self.size.h, self.size.w*0.3, self.size.h*0.5)
  end

  -- head
  love.graphics.rectangle("fill",
    pos.x + self.size.w/5-self.size.w*0.5, pos.y - self.size.w/1.3 - self.size.h,
    3*self.size.w/5, 3*self.size.w/5)
  -- nose
  love.graphics.rectangle("fill",
    pos.x + (2.5+1.5*self.facing)*self.size.w/5-self.size.w*0.5, pos.y - self.size.w/1.9 - self.size.h, self.size.w/5 * self.facing,3)

  -- eyes
  love.graphics.setColor(palette[2])
  if self.facing <= 0 then love.graphics.rectangle("fill",
    pos.x + self.size.w/2 - 5-self.size.w*0.5, pos.y - self.size.w/1.8 - self.size.h, 3,3)
  end
  if self.facing >= 0 then love.graphics.rectangle("fill",
    pos.x + self.size.w/2 + 2-self.size.w*0.5, pos.y - self.size.w/1.8 - self.size.h, 3,3)
  end

  -- poops
  love.graphics.setColor(palette[3])
  for i, poop in ipairs(self.poops) do
    love.graphics.circle("fill", poop, self.ground-4, 5)
    love.graphics.circle("fill", poop-7, self.ground-2, 3)
    love.graphics.circle("fill", poop+7, self.ground-2, 3)
  end

end



return Character
