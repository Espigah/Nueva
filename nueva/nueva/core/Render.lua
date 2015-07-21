module ('Render', package.seeall)

require ('nueva/utils/BaseClass');
Render =
{		
	functionTable = nill;
	bufferTable = nill;
}

local concreteClass = BaseClass.create(Render);
local groupRendering = {};

function Render:new()
  return setmetatable({}, concreteClass)
end


---Funcao que bufferiza o grafico a ser desenhado no buffer da aplicacao.
--@usage um objeto bufferizado primeiro, sera sobreposto pelos objetos bufferizados por ultimo.
--@param obj objeto que contem a imagem a ser desenhada na tela, sendo este objeto do tipo gameObjeto ou herdeiro deste.
--@see athus.view.gameObject
function Render:buffer(obj)
	if obj:isAlive() == true then
		local temp = obj:getPosition();
		canvas:compose(temp[1],temp[2],obj:getImg());
	end
end

--Funcao
function Render:createGroup(__groupName, __intervalRendering)
	local group = {groupName=__groupName, intervalRendering =__intervalRendering, sprites={}};
	groupRendering[__groupName] = group
end
--Funcao
function Render:addSpriteInGroup(__sprite, __groupName)
	table.insert(groupRendering[__groupName].sprites, __sprite);
end
--Funcao
--function Render:addSpritesInGroup(__sprites, __groupName)
--	table.insert(groupRendering[__groupName].objects, __sprites);
--end
function Render:getGroup(__groupName)
	return groupRendering[__groupName];
end
--Funcao que limpa toda a tela, para que a nova tela seja posteriormente desenhada.
function Render:clean()
	canvas:clear();
end

--Funcao que atualiza a tela, desenhando na mesma tudo que esta retido no buffer.
function Render:refresh()
	canvas:flush();
end


function Render:updateByGroup()
	local currentPosition = nil;
	local isAlive = false;
	local currentGroup = nil;
	local isRedering = -1;
	canvas:clear();
	for index,currentGroup in pairs(groupRendering) do		
		
		interval = currentGroup.intervalRendering
		
		for i,sprite in pairs(currentGroup.sprites) do
			
			isAlive = sprite:isAlive();	
			if isAlive == true then				
				currentPosition = sprite:getPosition();
				canvas:compose(currentPosition[1],currentPosition[2],sprite:getImg());
			end
			
			-- renderizar no intervalo $intervalRendering
			isRedering = i%interval;
			if(isRedering == 0 ) then				
				canvas:flush();
			end
				
			
		end
		-- rederizar a sobra
		if(not(isRedering == 0) ) then
			canvas:flush();
		end
	end
end

--==========================================================================================================By athus
---Funcao que bufferiza o grafico a ser desenhado no buffer da aplicacao.
--@usage um objeto bufferizado primeiro, sera sobreposto pelos objetos bufferizados por ultimo.
--@param obj objeto que contem a imagem a ser desenhada na tela, sendo este objeto do tipo gameObjeto ou herdeiro deste.
--@see athus.view.gameObject
function Render:buffer(obj)
	if obj:isAlive() == true then
		local temp = obj:getPosition();
		canvas:compose(temp[1],temp[2],obj:getImg());
	end
end

--Funcao que limpa toda a tela, para que a nova tela seja posteriormente desenhada.
function Render:clean()
	canvas:clear();
end

--Funcao que atualiza a tela, desenhando na mesma tudo que esta retido no buffer.
function Render:refresh()
	canvas:flush();
end

--_functionTable é executado no prerrender;
function Render:updateDraw()
	--por que 'self' nao funciona? =/
	Render:clean();
	
	local index,value;	
	
	for index,value in ipairs(functionTable) do	
		 value();
	end	
	for index,value in ipairs(bufferTable) do
		Render:buffer(value);
	end		
	
	Render:refresh();
end
