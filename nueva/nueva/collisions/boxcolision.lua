
--colision:boxColisionByPair(dragon,eagles2)	
-- noa sei porque colision:boxColisionByPair retorna nill
--solução temporaria 
function checkByPair(obj1, obj2)
	
	if obj1 == nil or obj2 == nil then
		return false;	
	end 
	
	local a = {};
	local b = {};
	local temp;
	temp = obj1:getSize();
	a.w, a.h = temp[1] , temp[2];
	temp = obj1:getPosition();
	a.x, a.y = temp[1] , temp[2]; 
	
	temp = obj2:getSize();
	b.w, b.h = temp[1] , temp[2];
	temp = obj2:getPosition();
	b.x, b.y = temp[1] , temp[2];
	 
	if b.x + b.w < a.x then
		return false;
	elseif b.x > a.x + a.w then
		return false;
	elseif b.y + b.h < a.y then
		return false;
	elseif b.y > a.y + a.h then
		return false;
	end
	return true;
end