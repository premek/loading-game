math.randomseed(os.time()); math.random(); math.random(); math.random(); -- wft

game = { -- global shared table
  state = nil,
  states = {
    loading = require "state.loading",
    mainmenu = require "state.mainmenu",
    splash = require "state.splash",
  },
  fonts = {},
}


function love.load()
  love.mouse.setVisible(false)
  game.state = game.states.splash

  game.fonts.text = love.graphics.newFont("goodbyeDespair.ttf", 25)
  game.fonts.large = love.graphics.newFont("goodbyeDespair.ttf", 75)
end



function love.keypressed(key, unicode)
  game.state:keypressed(key, unicode)
end

--function love.mousepressed(x, y, button)
  --if button == "l" then selected = clicked end
--end

function love.draw()
  game.state:draw()
  --love.graphics.setFont(game.fonts.text)
  --love.graphics.setColor(0,0,0)
  --love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.update(dt)
  game.state:update(dt)
end

--function love.focus(f)
  --  game:pause( not f )
--end

function love.quit()
  print("\n                            __          .gp.__/                            \n                       .ssSSSSSs.__    d$P^^^\"                             \n                    .sSSSSSSS$$$$$$$p.dP                                   \n                  .SSSSSS$$$$$SSSSSSSS$bs+._                               \n                .SSSS$$$$$SSSSS$$$$$$$SS$$$$b__                       /\"-. \n                SSS$$$SSSSS$$$$$$$$SSSS$$$SSSS$b                   _/\"-. / \n               :S$$$SSSSS$$$$$$$SSSSS$$$SSSS$$SSb                 //   /\"-.\n               $$SSSSS$$$$$$SSSSS$$$$$$S$$$$S$$$Sb.               ;   /   /\n               SSSSS$$$$$SSSSS$$$$$$$SS'P   SS$$S`^b._.'         /:  :   / \n               :S$$$$$SSSSS$$$$$$$SSSP      :$SS$b              / ;  +-./  \n                $$$$SSSS$$$$$$$SSSSSP        S$SS$;            / /  / / ;  \n               d$$SSS$$$$$SSSSSSSSS' ,=._    :S':S$           / /  / / /   \n              :$SSS$$$$SSSSSSSSS^\"  '  _ \";  ;   S$          / /  / / /    \n              SSS$$$SSSP.-TSS^\"     .=\"$;   /    S;         / /  / / /     \n             :SS$$$SSS$$ (;            \"    \\    P         / /  / : :      \n             :S$$$SS$$$$b :                  \\ .'         / /  /  :  \\     \n              T$$SS$$$$$j`-,    .          ,  \\         /\"-(  /   ;_-.\\    \n               `TSS$$$$P   ;    `.         `.-'        /  /\\\\/   .'/_ ;;   \n                 TS$$$P    :             _.-;         /  /\\\\(   / /-\" ;;   \n                  SSS'      \\           :-t\"         : .-\\\\/ \"-/\":   //    \n                .SS$$        `.          `-;         )Y   y   /  ;  J/     \n               :S$$$;          \"-.        (          '\"; j_.-/-./.-\" \\_    \n               $S$SS              \"j.     :            :/  ':    `-..' \\   \n              d$$SS;     :        /  \"-._.'             `.  ;       `-./;  \n            _S$$$SP       \\      :                        \\: :\"-.      \\;  \n          ,$$$SSSj       , `.    ;                         : ;   \"-,   /   \n          S$$SS'\"^-...___       : \"-.                      ;/      ;  t    \n      __.-`SS'---. `T$$$$$$q._       \"-.                  / `.    /   ;    \n  .-\"\"__ `.'      `. `T$$$$$$$$b.       `.               :    \"--\"   /     \n /.-\"\"  \\/          `. T$$$$$$$$$$p.     .`._            /\"-.  _   .'      \n::      /             \\ T$$$$$SS$$$$$b._  `.T$p.        /    \"\" ;-'        \n;;     :               \\ T$$$S$$$$$$$$$$$p._L$$$$p.    /       ,           \n;;     ;                \\ $$$$$$$$$$$$$$$$$$$SS$$$$$. /                    \n::     ;                 ;:$$$$$$$$$$$$$$SSSSSSSSS$$$y        '            \n ;;    :                  \"^$$$$$$$$$$$$$$$$$SSSS$$$P        /             \n ;;     b.                   \"^$$$$$$$$$$$$$$$$$S$$'        /              \n ::     :$$p.  -._              \"^$$$$$$$$$$$$$$$'         /               \n  ;;     $$$$$p.                   \"^$$$$$$$$$$P          /                \n  ::     :$$$$$$p.                    \"^$$$$$$P          ,                 \n   ;;     T$$$$$$$$p.                    \"^$$P                             \n   ::      T$$$$$$$P \"-.                    \"           '                  \n   s;;      $$$$$$P   d$$p._                     /     /                   \n  S$$:      $$$$$t   d$$$$$$$p._          \"-.  .'     /                    \n  SS$;;     :P^\"\\ \\.d$$$$$$$$$$$$p._         \"\"      /                     \n   TS::      \\   d$$$$$$$$$$$$$$$$$$$p._            /                      \n    SS.\\     .jq$$$$$$$$$$$$$$$$$$^^^^^\"\"-._      .';                      \n   $$$$.tsssj' `T$$$$$$$^^^^^\"\"\"            \"-._.'  ;                      \n   $$$SSS         \\                 /            \\ :                       \n   '^SSS_          \\               :          :    :                       \n     $$$SS.         \\              ;          :    ;                       \n     '$$$SS          \\            :           ;   :                        \n       \"^S$.          \\           ;          :    :                        \n         S$$b.         \\                     ;    ;                        \n         S$$$$          ;                   :    :                         \n         'TSS$$$s.      :                   ;    ;                         \n             TS$$Ss_    ;                   ;   :                          \n              `SSS$$$p./                   :    ;                          \n                  TS$$'            ;       ;    :                          \n                   \"S              :       ;     ;                         \n                   /                ;      :     :                         \n                  /                 :            :                         \n                 /\"-.                          .' ;                        \n                /    \"\"--..__          __..--\"\"   :                        \n                             \"\"\"\"\"\"\"\"\"\"                                    \n\nThanks for playing...\nYes, that's it. Sorry I didn't managed to add a meaning to this game in a given time for #LoadingJam. You can poop by pressing 'p' but it doesn't change anything. You cannot win...")
end
