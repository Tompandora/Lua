module ( "T",package.seeall)

local globalTable = {}

function serialize (o,newIndent)
	local newIndent = newIndent or 0
	local indent = newIndent or 0
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
	elseif type(o) == "function" then
		io.write("function")
	elseif type(o) == "boolean" then
		io.write(tostring(o))
	elseif type(o) == "userdata" then
		io.write("userdata")
	elseif type(o) == "table" then
		local tableAddress = tostring(o)
		if globalTable[tableAddress] == nil then 
			globalTable[tableAddress] = true
			io.write("\n")
			for val = 1, indent do io.write("\t") end
			indent = indent + 1
			io.write("{\n")
			for k,v in pairs(o) do
				for val = 1, indent do io.write("\t") end
				io.write("[" .. string.format("%q", k) .. "] = ")
				serialize(v,indent)
				io.write(", \n")	
			end
			indent = indent - 1
			for val = 1, indent do io.write("\t") end
			io.write("}")
			if indent == 0 then print("\n") end
		else
			io.write(tostring(o))
		end
	else
		error("cannot serialize a " .. type(o))
	end
end
