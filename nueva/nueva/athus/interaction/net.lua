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

---Modulo de controle de conexoes remotas.
--Este modulo pode ser ativo ou passivo, ou seja, voce pode registrar uma funcao para ser
-- chamada ao chegar um evento, ou passivamente chamar o modulo e pegar o proximo evento
-- enviado da fila.
module ('nueva.athus.interaction.net', package.seeall)

Net = {
	ip = nil;
	port = nil;
	status = 'off';
	
	dataFunc = nil;
	mngFunc = nil;
	
	buffer = nil;
	id = nil;
}

Class_Metatable = { __index = Net }

---Construtor do modeulo Net.
--@param ip string com o Ip ou Host da maquina remota.
--@param port numero com a porta da maquina remota.
function Net:new (ip, port)
	local temp = {};
	setmetatable ( temp, Class_Metatable );
	
	temp.ip = ip;
	temp.port = port;
	temp.buffer = {};
	
	event.register(function(evt) temp:listener(evt) end)
	
    return temp;
end

---Funcao que faz o pedido de conexao com a maquina remota.
function Net:connect()	
	if self.ip ~= nil and self.port ~= nil then 
		event.post {
	        class = 'tcp',
	        type  = 'connect',
	        host  = self.ip,
	        port  = self.port,
	    }
		self.status = 'connecting';
		if self.mngFunc ~= nil then
			self.mngFunc('connecting');
		end
	else
		print('ERROR : Host Invalido.');
		self.status = 'ERROR - Host Invalido.';
		if self.mngFunc ~= nil then
			self.mngFunc('error');
		end
	end
end

---Funcao para desconectar a conexao com a maquina remota.
function Net:disconnect()
	if id ~= nil then
		event.post {
			class      = 'tcp',
			type       = 'disconnect',
	    	connection = self.id,
		}
		if self.mngFunc ~= nil then
			self.mngFunc('off');
		end
	else
	 	print('ERROR : Nao conectado.');
	end
end

---Funcao de consulta do status da conexao.
--@return string com o status da conexao que podem ser<br>
--<ol>
--	<li>'off' - nao houve tentativa de conexao ou a conexao foi fechada com sucesso.</li>
--	<li>'connecting' - aguardando confirmacao de conexao.</li>
--	<li>'conected' - conectado com sucesso.</li>
--	<li>'error' - aconteceu algum erro na conexao.</li>
--</ol>
function Net:getStatus()
	return self.status;
end

---Funcao de envio de uma mensgem para a maquina remota.
--@param msg string contendo a mensagem a ser enviada.
function Net:send(msg)
	if self.id ~= nil and msg ~= nil then
		event.post {
	        class      = 'tcp',
	        type       = 'data',
	        connection = self.id,
	        value      = msg,
	    }
	 else
	 	print('ERROR : Sem Conexao');
	 end
end

---Funcao para registrar uma funcao para receber pacotes de dados.
--@param func funcao a ser chamada quando um pacote de dados chegar. Deve receber
-- uma string como parametro.
function Net:registerData(func)
	self.dataFunc = func;
end


---Funcao para registrar uma funcao para receber pacotes de comunicacao.
--@param func funcao a ser chamada quando um pacote de comunicacao chegar. Deve receber
-- uma string como parametro. Pode receber os seguintes valores:
----<ol>
--	<li>'off' - a conexao foi desligada.</li>
--	<li>'connecting' - aguardando confirmacao de conexao.</li>
--	<li>'conected' - conectado com sucesso.</li>
--	<li>'error' - aconteceu algum erro na conexao.</li>
--</ol>
function Net:registerMng(func)
	self.mngFunc = func;
end

---Funcao para pegar o proximo pacote da fila de dados que chegarao da maquina remota.
--@return string com a proxima mensagem da fila vinda da maquina remota. Retorna nill se nao houver nada.
function Net:getBuffer()
	local data = self.buffer[1];
	if data == nil then
		return nil;
	else
		table.remove(self.buffer, 1);
		return data;
	end	
end

--Listener de eventos LuaNcl.
--Problema esta que as variavaeis no lsitener na veem as do objeto
function Net:listener(evt)
	if evt.class ~= 'tcp' then return end
		
	if evt.type == 'connect' then	
		print('casa1');				
		if evt.error ~= nil then	
			print('casa2');		
			if self.mngFunc ~= nil then
				self.mngFunc('error');
				print('casa3');	
			end
		else
			self.id = evt.connection;
			print('casa4');
			if self.mngFunc ~= nil then
				print('casa5');
				self.mngFunc('connected');
			end
		end
	end

	if evt.type == 'data' then
		if evt.connection == self.id then
			if self.dataFunc ~= nil then
				self.dataFunc(evt.value);
			else
				table.insert(self.buffer, evt.value);
			end
			
		elseif evt.error ~= nil then 
			print('ERROR' .. evt.error);
			if self.mngFunc ~= nil then
				self.mngFunc('error');
			end
		end
	end

end

