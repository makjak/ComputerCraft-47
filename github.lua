-- To download for first time to computer:
-- pastebin get g49Fbtc6 github

local tArgs = { ... }

if (#tArgs ~= 3) then
	print( "USAGE: "..fs.getName(shell.getRunningProgram()).." get <GITHUB-RAW-URL> <PROGRAM-NAME>" )
	return
end

local action = tArgs[1]
local github_url = tArgs[2]
local program = tArgs[3]

if "get" ~= action then
	print( "Only 'get' is supported right now" )
	return
end

if fs.exists( program ) then
	print( "File "..program.." already exists" )
	return
end

local request = http.get( github_url )
local response = request.readAll()
request.close()

local file = fs.open( program, "w" )
file.write( response )
file.close()
