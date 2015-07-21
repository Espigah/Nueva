
module ('Xml', package.seeall)
local resultXMl, errorXml;
local myXmlhandler;
local myXmlparser;
Xml =
{
	path = "nueva/utils/",
	root = "nada",
}
Class_Metatable = { __index = Xml }

function Xml:new ()
	local temp = {}
    setmetatable ( temp, Class_Metatable )
    self = Xml
	return temp;
end

function Xml:open (__url)	
	
	dofile(self.path .. "LuaXML/xml.lua")
	dofile(self.path .. "LuaXML/handler.lua")	
	
	local xmltext = "<null>null<null>";
	myXmlhandler = simpleTreeHandler();	
	resultXMl, errorXml = io.open( __url, "r");		
	if resultXMl then
		xmltext = resultXMl:read("*a");	
		io.close(resultXMl) -- coment?
	else
		error(error)
	end
		
	myXmlparser = xmlParser(myXmlhandler)
	print("xmltext -----",xmltext)
	
	myXmlparser:parse(xmltext)
	
	self.root = myXmlhandler.root;
	
	
	
	--return xmlhandler.root
end


function Xml:getXml ()
	return xmlhandler
end

function Xml:getRoot ()
	return xmlhandler.root
end


