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

---Modulo de controle de execucao de medias externas(audio e video).
--Este modulo deve gerar automaticamente todo codigoo NCL quando uma nova midia for instanciada.
--Porem como o modulo NclEdit nao foi criado ate esta data, sao disponibilizadso 3 medias,
-- com identificadores na seguinte forma: 'media' concatenado com um numero de [1-3].<br>
--A primeira media e para videos, e as outras para audios.<br>
--Para tal uso, e necesario colocar o arquivo da media correspondente na pasta 'media', 
-- denominando-o com o id a ser utilizado no construtor e a extensao mp3 ou mp4, para audio
-- e video.
module ('nueva.athus.view.media', package.seeall)

Media = {
			playing = false,
			paused = false,
			muted = false,
			id = ''
		}
Class_Metatable = { __index = Media }

---Construtor do modulo Media.
--@param id string identificando o id da media a ser tocada.
--@param path string com o caminho para a media.
function Media:new (id,path)
    local temp = {};
	setmetatable ( temp, Class_Metatable );

    temp.id = id;
    
    return temp;
end

--- Funcao de pause da media.
function Media:pause()
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'pause',
		}
		self.paused = true;
		self.playing = false;
	end
end

--- Funcao que retorna a execucao da media apos ser pausada.
function Media:resume()
	if self.playing == false and self.paused == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'resume',
		}
		self.paused = false;
		self.playing = true;
	end
end

--Diz a qual audio se refere
--function Media:setAudio(sound)
--	self.id = sound;
--	event.post{
--		class  = 'ncl',
--		type   = 'presentation',
--		label   = self.id ..'Start',
--		action = 'start',
--	}
--end

---Funcao que inicia a execucao da media.
function Media:start()
	if self.playing == false and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'start',
		}
		self.playing = true;
	end
end

---Funcao que interrompe a execucao da media.
function Media:stop()
	if self.playing == true or self.paused == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Play',
			action = 'stop',
		}
		self.playing = false;
		self.paused = false;
	end
end

---Funcao que retira a execucao do audio da media.
function Media:mute()
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'start',
		}
		self.muted = true;
	else
		--print('Audio off');
	end
end

---Funcao que retira a execucao do audio da media durante um intervalo especifico de tempo.
function Media:muteT(tempo)
	if self.playing == true and self.paused == false then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'start',
		}
		self.muted = true;
		event.timer(tempo,
			function ()
				event.post{
					class  = 'ncl',
					type   = 'presentation',
					label   = self.id ..'Mute',
					action = 'stop',
				}
				self.muted = false;
			end

		);
	end
end

---Funcao que retira o audio de mudo.
function Media:unMute()
	if self.muted == true then
		event.post{
			class  = 'ncl',
			type   = 'presentation',
			label   = self.id ..'Mute',
			action = 'stop',
		}
		self.muted = false;
	end
end

---Funcao que consulta se a media esta mute ou nao.
--@return boolean true se verdadeira, false caso contrario.
function Media:isMuted()
	return self.muted;
end

---Funcao que consulta se a media esta sendo executada ou nao.
--@return boolean true se verdadeira, false caso contrario.
function Media:isPlaying()
	return self.playing;
end

---Funcao que consulta se a media esta pausada ou nao.
--@return boolean true se verdadeira, false caso contrario.
function Media:isPaused()
	return self.paused;
end
