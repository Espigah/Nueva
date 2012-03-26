module ('BuildClass', package.seeall)
function new (__className, __path) 
	local newClass, className = findClassName(__className,__path);	
	return newClass
end

local singletonInstance = {}

function getSingleton (__className) 

	local newClass, className = findClassName(__className);	
	print ("getSingleton -> ", className , " newClass -> ", newClass) ;
 	print(singletonInstance[className])
	if not (singletonInstance[className]) then
		singletonInstance[className] = newClass;
	end	
 	return singletonInstance[className];
end

--require (classPath .. className);
-- __className == table
function getClassNameOfPath (__className,__path) 	
	local className = __className;
	local classPath = __path;
	local imported = require (classPath.."."..className); -- not "true" please =/
	if(type(a) == "boolean")then
		imported = require (classPath.."/"..className)
	end
	print ("BuildClass -> ", classPath, className, " Imported -> ", imported) ;--imported not "true" please =/
	return imported[className]:new() , className;
end

-- __className == string
function getClassNameOfString (__className) 
	local imported = require (__className);
	print ("BuildClass -> ", __className , " Imported -> ", imported) ; --imported not "true" please =/
 	return imported[__className]:new(), __className; 
end

--~ facade?
function findClassName (__className,__path) 
	local newClass;
	local className;
	if (__path) then	
		newClass,className = getClassNameOfPath (__className,__path);
	else
		newClass,className = getClassNameOfString(__className);
	end
	return newClass,className;
end