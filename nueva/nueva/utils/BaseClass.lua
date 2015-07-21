module ('BaseClass', package.seeall)

function create(members)
  members = members or {}
  local mt = 
  {
    __metatable = members;
    __index     = members;
  }
  local function new(_, init)
    return setmetatable(init or {}, mt)
  end
  local function copy(obj, ...)  	
    local newobj = obj:new(unpack(arg)) -- clono a instancia
    for n,v in pairs(obj) do newobj[n] = v end -- passo tudo de uma classe para a outra
    return newobj
  end
  members.new  = members.new  or new
  members.copy = members.copy or copy
  return mt
end