--20120131-v0.2
module ('TextureAtlas', package.seeall)

require ('nueva/utils/BuildClass');
require ("nueva/utils/Xml")


local _myPath="";
local mTextureRegions = {} --1,1 ->HashMap:new();->1,n
local mTextureFrames = {} -- 1,1 ->HashMap:new();->1,n
local mTextureIndex = {}
local textureIndex = 0;
local xmltext = ""

local xml = BuildClass.new("Xml");

TextureAtlas = 
{
	image = "s";
	xml = "";
};

Class_Metatable = { __index = TextureAtlas }


function TextureAtlas:new ()
	local temp = {}
    setmetatable ( temp, Class_Metatable )
    self = TextureAtlas
	return temp;

end

 
function TextureAtlas:open (__xmlAtlas) 	
	xml:open (__xmlAtlas)
	self.xml = xml.root
	ParseAtlasXml(xml.root);	
 end
 
function ParseAtlasXml(__xmltext)
textureIndex = 0;
	local subTexture = __xmltext.TextureAtlas.SubTexture
	local region = 
	{
		x =  0,
		y = 0,
		width =  0,
		height =  0,
	}
	local frame  = 
	{
		x = 0,
		y =  0,		
		width =  0,
		height =  0,
	}
	
	
	for property, content in pairs(__xmltext.TextureAtlas._attr) do 
		TextureAtlas.image = content;
	end
	
	for property, content in pairs(subTexture) do	  			
  	 	name = subTexture[property]._attr.name
  	 	region.x  = subTexture[property]._attr.x
  		region.y = 	subTexture[property]._attr.y
  	 	region.width = subTexture[property]._attr.width
  	 	region.height = subTexture[property]._attr.height
  	 	
  		if subTexture[property]._attr.frameY then	  	
  			frame.x = subTexture[property]._attr.frameX
  			frame.y = subTexture[property]._attr.frameY
  			frame.width = subTexture[property]._attr.frameWidth
  			frame.height = subTexture[property]._attr.frameWidth
  		end
  	 
  	 	addRegion (name,region,frame)
	end
 end
 
function addRegion(name, region, frame)
		mTextureIndex [textureIndex] = {frame = frame , region = region, name = name}
		mTextureRegions[name] = region;
		mTextureFrames[name] = frame;
		textureIndex = textureIndex+1; 
		    
end
 
 function TextureAtlas:dispose ()
        --remover @2Do
 end
 
function TextureAtlas:getTextures (name)
      
 end
 
function TextureAtlas:getTexture (name)
         --  local region  = mTextureRegions:get(name);
            local region  = mTextureRegions[name]; 
            if (region) then
				return nil;
            else
				return region; --Texture.fromTexture(mAtlasTexture, region, mTextureFrames[name]);
			end
 end
 
 function TextureAtlas:removeRegion (name)
         
 end
                
