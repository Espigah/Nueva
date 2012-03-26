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

---Modulo com funcoes auxiliares para o desenvolvimento das aplicacoes.
module ('nueva.athus.core.tools', package.seeall)

Tools = {}
Class_Metatable = { __index = Tools }

---Construtor do Modulo Tools.
function Tools:new ()
	local temp = {}
	setmetatable ( temp, Class_Metatable )
    return temp;
end

---Funcao para consultar a altura do canvas de desenho da tela.
--@return numero com a altura da tela que esta sendo utilizada pelo jogo.
function Tools:getScreenHeigth()
	local w,h = canvas:attrSize();
	return h;
end

---Funcao para consultar a largura do canvas de desenho da tela.
--@return numero com a largura da tela que esta sendo utilizada pelo jogo.
function Tools:getScreenWidth()
	local w,h = canvas:attrSize();
	return w;
end

---Funcao para definir o tamanho do canvas de desenho da aplicacao. 
--Caso seja passado um valor maior qu o suportado pelo sistema, o valor maximo sera configurado.
--@usage 2Do.
--@param width numero com o valor da nova largura a ser utilizada.
--@param height numero com o valor da nova altura a ser utilizada.
--@return tabela com os valores da nova altura e largura.
function Tools:setCanvasSize()
	--@2Do.
end

---Funcao temporizadora. Ela faz a chamada de uma funcao apos um tempo especifico.
--@param time numero com o tempo em milisegundos que se passarao para haver a chamada a funcao.
--@param func funcao a ser chamada apos o tempo desejado.
function Tools:timer(time,func)
	event.timer(time,func);
end

---Funcao para exibir textos na tela, limpando e atualizando a tela imediatamente.
--@usage utilizada para testes, servindo como saida para exibir variaveis e logs.
--@param x numero com o valor da posicao no eixo X para desenho do texto.
--@param y numero com o valor da posicao no eixo Y para desenho do texto.
--@param texto string a ser exbido na tela.
--@param size numero com o valor do tamanho da fonte do texto.
--@param color string com a cor do texto a ser exibido.
function Tools:exibeTexto(x, y, texto, size, color)
	canvas:clear();
	local R, G, B, A = canvas:attrColor();
	canvas:attrColor(color);
	canvas:attrFont('vera', size, 'bold');
	canvas:drawText(x, y, texto);
	canvas:attrColor(R, G, B, A);
	canvas:flush();
end
