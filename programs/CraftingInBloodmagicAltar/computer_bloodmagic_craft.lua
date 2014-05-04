local modemSide = 'left'
local activatorSide = 'top'
local putSide = 'right'
local getSide = 'back'

local blankWait = 10
local reinforcedWait = 21
local imbuedWait = 36
local demonicWait = 56

local running = true
local off = true
local wait = 0
local monitorServer

sendRedstoneSignal = function(side, time)--{{{
   redstone.setOutput(side, true)
   os.sleep(time)
   redstone.setOutput(side, false)
end--}}}

getMonitorServerId = function() --{{{
   rednet.broadcast('PING')
   local eventTable = {os.pullEvent()}
   local event = eventTable[1]

   if (event == 'rednet_message') then
      local sender, msg, distance = eventTable[2], eventTable[3], eventTable[4]

      if (msg == 'PING') then
         monitorServer = sender
      end
   end
end--}}}

rednet.open(modemSide)
while (not monitorServer) do
   getMonitorServerId()
end

while (running) do
   print('New cycle')
   rednet.send(monitorServer, 'slateState')

   local eventTable = {os.pullEvent()}
   local event = eventTable[1]
   local msg

   if (event == 'rednet_message') then
      msg = eventTable[3]
   elseif (event == 'modem_message') then
      msg = eventTable[5]
   end

   if (msg == 0) then
      off = true
      wait = 0
   elseif (msg == 1) then
      off = false
      wait = blankWait
   elseif (msg == 2) then
      off = false
      wait = reinforcedWait
   elseif (msg == 3) then
      off = false
      wait = imbuedWait
   elseif (msg == 4) then
      off = false
      wait = demonicWait
   end

   if (not off) then
      print(' - send to '..putSide)
      sendRedstoneSignal(putSide, 0.3)
      os.sleep(3)
      print(' - send to '..activatorSide)
      sendRedstoneSignal(activatorSide, 0.8)
      print(' - send to '..getSide)
      sendRedstoneSignal(getSide, 0.3)

      print(' - wait '..wait)
      os.sleep(wait)

      print(' - send to '..activatorSide)
      sendRedstoneSignal(activatorSide, 0.8)
      os.sleep(3)
      print(' - send to '..getSide)
      sendRedstoneSignal(getSide, 0.3)
   else
      print(' - turned off')
   end
end

