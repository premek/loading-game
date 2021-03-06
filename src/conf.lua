function love.conf(t)
  t.window = t.window or t.screen

  t.version = "0.9.1"                -- The LÖVE version this game was made for (string)
  t.window.title = "Loading"        -- The window title (string)
  t.title = "Loading"        -- The window title (string)
  t.window.fullscreen = true        -- Enable fullscreen (boolean)
  t.window.fullscreentype = "normal" -- Standard fullscreen or desktop fullscreen mode (string)

  t.window.width = 800 -- t.screen.width in 0.8.0 and earlier
  t.window.height = 600 -- t.screen.height in 0.8.0 and earlier
  t.screen = t.screen or t.window

end
