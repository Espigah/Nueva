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

---Modulo para criacao de loops constantes.
-- Auxilia o desenho e update do jogo gerando taxas de
-- FPSs(Frames per Second)e UPSs(Updates per Second) constantes.
--<br>
--<b>Tal modulo foi inspirado no livro: "Killer Game Programming in Java".</b>

module ('nueva.athus.core.animation', package.seeall)

Animation = {}
Class_Metatable = { __index = Animation }

local tween;

---Construtor da do Modulo Animation.
function Animation:new ()
	local temp = {};
	setmetatable ( temp, Class_Metatable );
	
	--Variaveis de configuracao;
	temp.config = {
				funcUpdate = nil,					--Variavel para guardar a funcao de update;
				funcDraw = nil,						--Variavel para guardar a funcao de desenho;
				running = false,					--Variavel para pausar ou rodar o loop;
				NO_DELAYS_PER_YIELD = math.huge,	--Maximo de atrasos suportados pelo algoritmo;
				MAX_FRAME_SKIPS = 5,				--No. de frames que podem ser pulados na animcao;
			};
			
	--Variaveis auxiliares para calculos do algoritmo; 
	temp.times = {
				before = 0,
				timeDiff = 0,
				sleep = 0,
				after = 0,
				overSleep = 0,
				delays = 0,
				period = 100,
				excess = 0,
			};
    return temp;
end

---Funcao para iniciar o loop.
--@param update funcao para controle das atualizacões logicas do jogo.   
--@param draw funcao para controle das atualizacões de tela do jogo.
--@usage apos criada uma instancia da animacao, e necessario inicia-la atraves do comando strat passando 
--as funcoes de atualizacao e desenho da aplicacao principal. 
function Animation:start(update,draw)
	self.config.funcUpdate = update;
	self.config.funcDraw = draw;
	self.config.running = true;
	self.times.before = event.uptime();
	self:run();
end

---Funcao para pausar o loop.
--@usage apos iniciada uma animacao, a chamada desta funcao ira pausar a sua execucao.
function Animation:pause()
	self.config.running = false;
	self:run();
end

---Funcao para retornar o loop;
--@usage uma execucao pausada da animacao pode ser retomada com a chamada desta funcao.
function Animation:resume()
	self.config.running = true;
	self.times.before = event.uptime();
	self:run();
end

---Funcao para definir o periodo de tempo entre cada repeticao do loop.
--@param time numero que representa em milisegundos o intervalo de tempo.
--@usage esta funcao ira modificar o periodo de execucao de cada ciclo, que e inicialmente 0,1s, 
--correspondendo a 10 fps. 
function Animation:setPeriod(time)
	self.times.period = time;
	timeTween = time;
end

--Funcao de chamada do parametro(funcao) Update da animacao.
function Animation:gameUpdate()
	self.config.funcUpdate();
end

---Funcao de chamada do parametro(funcao) Draw da animacao.
function Animation:gameBuffer()
	self.config.funcDraw();
end

function Animation:setTween(___tween, ___time)	
	timeTween = ___time
	tween = ___tween;	
end

--Abaixo o algoritmo de loop adaptado do livro: "Killer Game Programming in Java";
function Animation:run()
	if self.config.running then
		
		
		if tween then		
			tween.update(timeTween)
		else
			print('tween not identified--->',tween)
		end
		
		self:gameUpdate();
		self:gameBuffer();

		self.times.after = event.uptime();
		self.times.timeDiff = self.times.after - self.times.before;
		self.times.sleep = (self.times.period - self.times.timeDiff) - self.times.overSleep;

		if self.times.sleep > 0 then
			event.timer(self.times.sleep, function() self:runAux2(); end);
		else
			self.times.overSleep = 0;
			self.times.delays = self.times.delays + 1;
			if self.times.delays >= self.config.NO_DELAYS_PER_YIELD then
				self.times.delays = 0;
				
				event.timer(self:run(),self.times.period);
			else
				event.timer(0, function() self:runAux(); end);				
			end		
		end

	end
end

function Animation:runAux2()
	self.times.excess = self.times.excess - self.times.sleep;
	self.times.overSleep = (event.uptime() - self.times.after) - self.times.sleep;
	self:runAux();
end

function Animation:runAux()
	self.times.before = event.uptime();

	local skips = 0;
	while((self.times.excess > self.times.period) and (skips < self.config.MAX_FRAME_SKIPS)) do
		self.times.excess = self.times.excess - self.times.period;
		self.gameUpdate();
		skips= skips + 1;
	end

	self:run();
end

