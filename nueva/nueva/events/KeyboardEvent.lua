module ('KeyboardEvent', package.seeall)

--local KeyboardSignals = require("events/KeyboardSignals");
--local AllButtons = require ('events/AllButtons');

--print(KeyboardSignals) PQ -> true ???
--print(KeyboardSignals) PQ -> tabela ???
--print(AllButtons) PQ -> tabela ???
--print(AllButtons) PQ -> nil ???

require("KeyboardSignals");
require ("nueva/events/AllButtons");
print(">>======== KeyboardSignals",KeyboardSignals)
print(">>======== AllButtons",AllButtons)
local hasmapPress =
{
	CURSOR_LEFT = KeyboardSignals.addPressLeft,	
	CURSOR_RIGHT = KeyboardSignals.addPressRight,
	CURSOR_DOWN = KeyboardSignals.addPressDown,
	CURSOR_UP = KeyboardSignals.addPressUp,
	
	GREEN = KeyboardSignals.addPressGreen,
	RED = KeyboardSignals.addPressRed,
	BLUE = KeyboardSignals.addPressBlue,
	YELLOW = KeyboardSignals.addPressYellow,
	
	['0'] = KeyboardSignals.addPress0,
	['1'] = KeyboardSignals.addPress1,
	['2'] = KeyboardSignals.addPress2,
	['3'] = KeyboardSignals.addPress3,
	['4'] = KeyboardSignals.addPress4,
	['5'] = KeyboardSignals.addPress5,
	['6'] = KeyboardSignals.addPress6,
	['7'] = KeyboardSignals.addPress7,
	['8'] = KeyboardSignals.addPress8,
	['9'] = KeyboardSignals.addPress9,	
}

local hasmapRelease =
{
	CURSOR_LEFT = KeyboardSignals.addReleaseLeft,	
	CURSOR_RIGHT = KeyboardSignals.addReleaseRight,
	CURSOR_DOWN = KeyboardSignals.addReleaseDown,
	CURSOR_UP = KeyboardSignals.addReleaseUp,
	
	GREEN = KeyboardSignals.addReleaseGreen,
	RED = KeyboardSignals.addReleaseRed,
	BLUE = KeyboardSignals.addReleaseBlue,
	YELLOW = KeyboardSignals.addReleaseYellow,
	
	['0'] = KeyboardSignals.addRelease0,
	['1'] = KeyboardSignals.addRelease1,
	['2'] = KeyboardSignals.addRelease2,
	['3'] = KeyboardSignals.addRelease3,
	['4'] = KeyboardSignals.addRelease4,
	['5'] = KeyboardSignals.addRelease5,
	['6'] = KeyboardSignals.addRelease6,
	['7'] = KeyboardSignals.addRelease7,
	['8'] = KeyboardSignals.addRelease8,
	['9'] = KeyboardSignals.addRelease9,	
}

-- Funcao de tratamento de eventos:
function keyListener (evt)
		if evt.class == 'key'  then		
			isValidKey = AllButtons.key[evt.key];		
			if isValidKey  then		
				if evt.type == 'press'then						
					isValidKey.pressed = true;	
				end
				if evt.type == 'release'then				
					isValidKey.released = true;
				end		
			end			
		end	
end

-- Funcao que dispara um sinal
-- executa a função
function keyDispatch (evt)
	isValidKey = AllButtons.key[evt.key];
	currentSignals = hasmapPress[evt.key];
	if isValidKey and currentSignals then
		if evt.class == 'key' then	
			if evt.type == 'press'then	
				KeyboardSignals.addPress:dispatch(evt.key);				
				currentSignals:dispatch(evt.key);
				KeyboardSignals.addPressLast:dispatch(evt.key);	
			elseif evt.type == 'release' then			
				KeyboardSignals.addRelease:dispatch(evt.key);		
				currentSignals:dispatch(evt.key);
				KeyboardSignals.addReleaseLast:dispatch(evt.key);			
			end	
						
		end
	end
end

--Limpa o estado atual do controle // Qual o desempenho disso?
function cleanAllState()
	table.foreach(AllButtons.key,cleanState);
end
function cleanState(tabela,valor)
	valor.pressed = false;
	valor.released = false;
end


event.register(keyListener);
event.register(keyDispatch);
