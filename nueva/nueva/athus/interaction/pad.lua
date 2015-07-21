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


---Modulo criado para abstrair a interacao como o controle remoto. <br>
--O programador deve pegar o estado de uma tecla que desejar. Cada tecla possui tres estados:<br>
--<ol> 
--<li>free: indica que nada ocorreu com a tecla.</li>
--<li>press: indica a tecla esta sendo pressionada no momento da consulta.</li>
--<li>release: indica que a tecla foi pressionada e solta.</li>
--</ol>
--E recomendado a cada ciclo/leitura das teclas desejadas a limpeza dos estados para
-- que um novo estado seja lido no proximo cicLo.
--<br><br>
--As Teclas disponibilizadas neste modulo sao as mesmas permitidas pela norma NCL: <br>
--<dl>
--	<dt>Teclas Coloridas</dt>
--		<dd>RED, GREEN, BLUE, YELLOW</dd>
--	<dt>Teclas NUmericas</dt>
--		<dd>0,1,2,3,4,5,6,7,8,9</dd>
--	<dt>Setas</dt>
--		<dd>CURSOR_DOWN, CURSOR_UP, CURSOR_LEFT, CURSOR_RIGHT</dd>
--	<dt>Teclas de Configuracao:</dt>
--		<dd>MENU, INFO, ENTER</dd>
--</dl>
--<br><br>
---Este modulo pode ser ativo ou passivo, ou seja, voce pode registrar uma funcao para ser
-- chamada ao chegar um evento de teclado, ou passivamente chamar o modulo e pegar o proximo evento
-- o status das teclas.
module ('nueva.athus.interaction.pad', package.seeall)	

Pad = {
	keys = {
		RED = 'free',
		GREEN = 'free',
		BLUE = 'free',
		YELLOW = 'free',
		['0'] = 'free',
		['1'] = 'free',
		['2'] = 'free',
		['3'] = 'free',
		['4'] = 'free',
		['5'] = 'free',
		['6'] = 'free',
		['7'] = 'free',
		['8'] = 'free',
		['9'] = 'free',
		MENU = 'free',
		INFO = 'free',
		CURSOR_DOWN = 'free',
		CURSOR_UP = 'free',
		CURSOR_LEFT = 'free',
		CURSOR_RIGHT = 'free',
		ENTER = 'free',
	},
	evtFunc = nil;
}
Class_Metatable = { __index = Pad }

---Construtor do modulo Pad.
function Pad:new()
	local temp = {};
	setmetatable ( temp, Class_Metatable );
	
	event.register(function(evt) temp:keyListener(evt) end)

	return temp;
end

---Funcao para registrar uma funcao para receber evts de teclado.
--@param func funcao a ser chamada quando um pacote de dados chegar. Deve receber
-- uma uma tabela com duas strings como parametro. Uma com a tecla, e a outra com
-- o status. {key,status}.
function Pad:registerEvt(func)
	self.evtFunc = func;
end

-- Verifica se a tecla e compativel com o sistema;
function Pad:keyValidate(key)
	if key == 'ENTER' or key == 'CURSOR_RIGHT' or key == 'CURSOR_LEFT' or key == 'CURSOR_UP'
		or key == 'CURSOR_DOWN' or key == 'INFO' or key == 'ENTER' or key == 'MENU'
		or key == '9' or key == '8' or key == '7' or key == '6' or key == '5'
		or key == '4' or key == '3' or key == '2' or key == '1' or key == '0'
		or key == 'RED' or key == 'GREEN' or key == 'YELLOW' or key == 'BLUE'
		--or tecla == 'x' or tecla == 'c' or tecla == 'v' or tecla == 'b'
	then
		return true
	else
		return false
	end
end

--- Funcao para limpar todos estados das teclas, colocando-as no estado free.
function Pad:cleanStates()
	for i = 1,#self.keys do
		keys[i] = 'free';
	end
end

--- Funcao para consultar o estado de uma tecla.
--@param key string como o nome da tecla desejada.
--@return retorna uma string com o estado da tecla (free, release ou press).
function Pad:getKey(key)
	local aux = self.keys[key];
	
	if aux == 'release' then
		self.keys[key] = 'free';
	end
	
	return aux;
end

-- Funcao de tratamento de eventos nativo do ncLua;
function Pad:keyListener(evt)
	if evt.class == 'key' and self:keyValidate(evt.key) then
		if self.evtFunc == nil then
			if evt.type == 'press' then
				self.keys[evt.key] = 'press';
			end
			if evt.type == 'release'then
				self.keys[evt.key] = 'release';
			end
		else
			self.evtFunc({ evt.key , evt.type });
		end
		
	end
end
