local Enemy = {}
local BulletManager = require("BulletManager")
local _mt  ={__index = Enemy}
require("AnAL")

function Enemy.create(x,y)
	local self = {}	
	self.image =love.graphics.newImage("Enemy.png")
	anim = newAnimation(self.image,124,124, .1, 0)
	self.w =self.image:getWidth()
	self.h =self.image:getHeight()
	self.x = x or love.window.getWidth()
	self.y = y or math.random(0,love.window.getHeight()-self.h)
	self.keys={}
	self.speed =200
	self.removed=false
	self.tweentimer=0
	self.shootTimer =0
	self.count=0
	self.shootRate =math.random(1,3)
	setmetatable(self , _mt)
	return self
end

function Enemy:destroy()
	self.removed=true
end

function Enemy:setKeys(keys)
self.keys=keys
end
function Enemy:update(dt)
anim:update(dt)
	self.tweentimer =self.tweentimer+ dt
	self.y =self.y +math.sin(self.tweentimer *8) *79 *dt
	self.x =self.x -self.speed *dt
	if self.x <-self.w then self:destroy() end

	self.shootTimer =self.shootTimer +dt
	if self.shootTimer>self.shootRate then
		BulletManager:addBullet("enemy",self.x + self.w,self.y+ self.h/2,"left")
		self.shootTimer =0
		self.shootRate =math.random(1,3)
	end

for i,bullet in ipairs (BulletManager:getArray()) do
			if bullet.owner =="player" and collision (self,bullet) then
				
				bullet.destroy()

				self:destroy()
				self.count=self.count+100


			end
		end

end
function Enemy:draw()
	
	
	--love.graphics.draw(self.image,self.x,self.y)
	anim:draw(self.x,self.y)
	love.graphics.print(self.count,100,100)
end

return Enemy