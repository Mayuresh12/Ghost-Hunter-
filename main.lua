
local Player = require("Player")
local Enemy = require("Enemy")
local BulletManager = require("BulletManager")

local _playerArray={}
local _enemyArray={}
local _spawnTimer = 0
local _spawnRate = 1
local currentTime=0


KEYS ={
	["Spieler1"] ={up ="up",down="down", shoot =" "},
	["game"] ={quit ="escape", reset ="r"},
}
function collision(a,b)
	return a.x+a.w >b.x and a.x<b.x+ b.w
	and a.y+a.h>b.y and a.y<b.y+ b.h
	-- body
end
local function init()
	 _playerArray={}
	 _enemyArray={}
	 BulletManager:clear()
	_playerArray[1] = Player.create(32,love.window.getHeight()/2 - 16)
	_playerArray[1]:setKeys(KEYS["Spieler1"])
end

function love.load()
--t = love.timer.getMicroTime( )
	 --currentTime = love.timer.getTime()
--	while(t+5) do
--	love.graphics.newImage("Player.png")
--	end--love.timer.sleep(10)

	love.graphics.newFont("rockwell.ttf",12)
	love.graphics.setBackgroundColor( 12, 19,49)
	music = love.audio.newSource("ninjaGhost.ogg")
   music:play()
   music:setVolume(0.12) -- 90% of ordinary volume
--music:setPitch(0.5)


	
	init()

	  stars = {} -- table which will hold our stars
   max_stars = 100 -- how many stars we want
   for i=1, max_stars do -- generate the coords of our stars
      local x = math.random(5, love.graphics.getWidth()-5) -- generate a "random" number for the x coord of this star
      local y = math.random(5, love.graphics.getHeight()-5) -- both coords are limited to the screen size, minus 5 pixels of padding
      stars[i] = {x, y} -- stick the values into the table
      end
   love.graphics.setPointSize ( 3 )
   love.graphics.setPointStyle ( "smooth" )
end

function love.update(dt)
	
	_spawnTimer=_spawnTimer+dt
	if _spawnTimer>_spawnRate then
		local enemy =Enemy.create()
		_enemyArray[#_enemyArray+1] =enemy
		_spawnTimer=0
	end
	for i,player in ipairs (_playerArray) do
		if not player.removed then 
			player:update(dt)
		else
			table.remove(_playerArray,i)
		end
	end

	for i,enemy in ipairs (_enemyArray) do
		if not enemy.removed then 
			enemy:update(dt)
		else
			table.remove(_enemyArray,i)
		end
	end
BulletManager:update(dt)
	
end



function love.draw()
	
	love.graphics.print("SCORE", love.window.getWidth()/2,0)
	love.graphics.print("HEALTH", 0, 0)
	love.graphics.print("%",35, 12)
	for i=1, #stars do -- loop through all of our stars
      love.graphics.point(stars[i][1], stars[i][2]) -- draw each point

   end
for i,player in ipairs (_playerArray) do
	player:draw()
	end


	for i,enemy in ipairs (_enemyArray) do
	enemy:draw()
	end
	BulletManager:draw()
end

function love.keypressed(key)
	local keys =KEYS ["game"]
	if key ==keys.quit then love.event.quit() end 
	if key ==keys.reset then init() end
	if key == "a" then
    local a= love.audio.newSource("ghost1.ogg", "static")
         love.audio.play(a)
     end

     if key == "s" then
    local s= love.audio.newSource("ghost2.ogg", "static")
         love.audio.play(s)
     end

     if key == "d" then
    local d= love.audio.newSource("ghost3.ogg", "static")
         love.audio.play(d)
     end
     if key == "f" then
    local f= love.audio.newSource("ghost_deeper.ogg", "static")
         love.audio.play(f)
     end
end


