--[[	
	Athus, a framework for Ginga based applications.
Copyright (C) 2011, Ricardo Mendes Costa Segundo

	This file is part of Athus.

	Athus is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or any later version.

	Athus is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
along with Athus.  If not, see <http://www.gnu.org/licenses/>.
]]--

---Modulo para tratamento de colisoes entre objetos do jogo.
module ('nueva.athus.core.colision', package.seeall)

Colision = {}

Class_Metatable = { __index = Colision }

---Construtor do modulo Colision.
function Colision:new ()
    return setmetatable ( {}, Class_Metatable )
end

--- Funcao de deteccao de colisao simples por comparacao de retangulos dois a dois.
--@param obj1 objeto do tipo gameObject ou suas generalizacoes.
--@param obj2 objeto do tipo gameObject ou suas generalizacoes.
--@return true se houve colisao, false caso contrario.
function Colision:boxColisionByPair(obj1, obj2)
	
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
