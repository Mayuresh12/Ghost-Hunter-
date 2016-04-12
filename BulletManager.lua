local BulletManager = {}
local _bulletArray = {}
function BulletManager:addBullet(owner,x,y,direction)
	local bullet = {}
	bullet.owner =owner
	bullet.image=love.graphics.newImage("Bullet.png")
	bullet.w =bullet.image:getWidth()
	bullet.h=bullet.image:getHeight()
	bullet.x =x
	bullet.y =y
	bullet.direction =direction
	bullet.speed =800
    bullet.removed = false
    bullet.destroy = function () bullet.removed=true end
    _bulletArray[#_bulletArray+1] =bullet

end

function BulletManager:getArray()
	return _bulletArray
end

function BulletManager:clear()
	_bulletArray={}
end

function BulletManager:update(dt)
	
	for i,bullet in ipairs(_bulletArray)do
        if not bullet.removed then

	        if bullet.direction =="left" then bullet.x =bullet.x - bullet.speed *dt
	        else bullet.x =bullet.x +bullet.speed*dt
	        end	

	        if bullet.x < -bullet.w or bullet.x >love.window.getWidth() then bullet.destroy() end
	    else
	    	table.remove(_bulletArray,i)
	    end
	end
end

function BulletManager:draw( ... )
	for i,bullet in ipairs(_bulletArray)do
          love.graphics.draw(bullet.image,bullet.x,bullet.y)
	end
end

return BulletManager