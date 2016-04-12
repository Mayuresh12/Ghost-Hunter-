vector = require 'vector'
local Player = {}
local BulletManager = require("BulletManager")
local _mt  ={__index = Player}

function Player.create(x,y)
	local self = {}
	bullets = {}
	self.bullets ={}
	self.x = x or 0
	self.y = y or 0
	self.image =love.graphics.newImage("Player.png")
	self.w =self.image:getWidth()
	self.h =self.image:getHeight()
	self.keys={}
	self.tweentimer=0
	self.health=100
	self.speed =400
	self.removed=false
	self.shootTimer =0
	self.shootRate =.1
	setmetatable(self , _mt)
	return self
end


function Player:setKeys(keys)
self.keys=keys
end

function Player:destroy()
	self.removed=true
end

function Player.mousepressed( x, y, button )
	 if love.mouse.isDown("l") then
         x = love.mouse.getX( )
         y = love.mouse.getY( ) local start = vector.new(love.window.getWidth()/2, love.window.getHeight())
         local speed = 1000
         local dir = vector.new(x,y) - start
         dir:normalize_inplace()
         createNewBullet ( start, dir * speed )
      end if love.mouse.isDown("l") then
         x = love.mouse.getX( )
         y = love.mouse.getY( ) local start = vector.new(love.window.getWidth()/2, love.window.getHeight())
         local speed = 1000
         local dir = vector.new(x,y) - start
         dir:normalize_inplace()
         createNewBullet ( start, dir * speed )
      end
end


function Player:update(dt)
	
	self.tweentimer =self.tweentimer+ dt
	self.y =self.y +math.sin(self.tweentimer *8) *20 *dt


	if love.keyboard.isDown(self.keys.up) then self.y =self.y -self.speed *dt end
	if love.keyboard.isDown(self.keys.down) then self.y =self.y +self.speed *dt end
	if self.y < 0 then self.y = 0 end
	if self.y >love.window.getHeight()-self.h then self.y =love.window.getHeight() -self.h end

	self.shootTimer =self.shootTimer -dt
	if self.shootTimer <=0 and love.keyboard.isDown(self.keys.shoot) then
		BulletManager:addBullet("player",self.x + self.w,self.y+ self.h/2,"right")
		self.shootTimer =self.shootRate
	end	

		for i,bullet in ipairs (BulletManager:getArray()) do
			if bullet.owner =="enemy" and collision (self,bullet) then
				bullet.destroy()
				self.health =self.health -20
			end
		end

		if self.health <=0 then self:destroy() end
end
function Player:draw()
	for i,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end
	
	love.graphics.print(self.health, 5, 12)
	
	love.graphics.draw(self.image,self.x,self.y)
end


return Player