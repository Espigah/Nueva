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

---Modulo de controle de sincronizacao e tratamento de eventos vindos da emissora.
--Este modulo pode ser ativo ou passivo, ou seja, voce pode registrar uma funcao para ser
-- chamada ao chegar um evento, ou passivamente chamar o modulo e pegar o proximo evento
-- enviado da fila.<br><br>
--<b> ATENCAO, MODULO NAO IMPLEMENTADO.</b>
module ('nueva.athus.interaction.tv', package.seeall)

Tv = {
	evtFunc = nil;	
	buffer = nil;
	evts = nil;
	loop = false;
}

Class_Metatable = { __index = Tv }

---Construtor do modulo Tv.
function Tv:new ()
	local temp = {};
	setmetatable ( temp, Class_Metatable );
	
	temp.buffer = {};
	temp.evts = {};
	
    return temp;
end

---Funcao para registrar uma funcao para receber os eventos.
--@param func funcao a ser chamada quando um evento chegar. Deve receber
-- duas strings(em tabela) como parametro, uma para o id do evento e outra para o seu valor.
--{id,value}
function Tv:registerEvt(func)
	self.loop = true;
	self.evtFunc = func;
end

---Funcao para pegar o proximo evento da fila vindo da emissora
--@return tabela com o proximo evento da fila vindo da emissora. Retorna nil se estiver vazia.{id, value}.
function Tv:getBuffer()
	local data = {self.buffer[1][1],self.buffer[1][2]};
	if data[1] == nil then
		return nil;
	else
		table.remove(self.buffer, 1);
		return data;
	end	
end

---Funcao para adicionar um listener de evento. Este evento ira sera procurado a cada update
-- e se encontrado sera colocado no buffer ou enviado a funcao registrada.
--@param id nome do evento a ser procurado. Deve ser igual a propriedade que sera modificada pela emissora.
function Tv:addEvt(id)
	table.insert(self.evts, id);
end

---Funcao manual para procurar se houve mudancas algum evento.
--@return booleano treu se houve algo novo, falso se nao houve nada.
function Tv:update()
	local change;
	--aqui faz a consulta a tabela de propriedades e compara com os evts,
	--vendo se houve mudança.
	if change == true then
		if self.loop == false then
			--Havendo mudança adiciona em buffer{id,value}.
		else
			self.evtFunc({id,value});
		end
		return true;
	else
		return false;
	end
end

--Loop interno a cada 1s.
function Tv:loop()
	if self.loop == true then
		evt.timer(1000,self:loop);
		self:update();
	end
end

