module ('NCLEvents', package.seeall)


NCLEvents = {	};
Class_Metatable = { __index = NCLEvents }

function NCLEvents:new ()
	local temp = {}
    setmetatable ( temp, Class_Metatable )
    self = NCLEvents
	return temp;
end

function NCLEvents:post (__class, __type, __label, __action)
	event.post {
				class = __class,
				type = __type,
				label = __label,
				action = __action,
				}
end


function NCLEvents:timer (__timer, __function)
	event.timer (__timer,__function)
end