os.unloadAPI('buttons')
os.loadAPI('buttons')

-- Specifies which slate is supposed to be doing
-- 0 - off
-- 1 - blank
-- 2 - reinforced
-- 3 - imbued
-- 4 - demonic
local slateState = 0
local running = true

local modemSide = 'left'
rednet.open(modemSide)

local monSide = 'bottom'
local monitor = peripheral.wrap(monSide)
buttons.setDefaultOutput(monitor)

local defaultTextColor = colors.white
local defaultBgColor = colors.red
local defaultBgPressedColor = colors.lime
local allBtns = {}

draw = function()
   buttons.draw()
end

enableBtn = function(id)
   for _, v in pairs(allBtns) do
      if (v == id) then
         buttons.setColor(v, defaultTextColor, defaultBgPressedColor)
      else
         buttons.setColor(v, defaultTextColor, defaultBgColor)
      end
   end
end

offBtn = function()
   enableBtn(allBtns.off)

   slateState = 0
end

blankBtn = function()
   enableBtn(allBtns.blank)

   slateState = 1
end

reinforcedBtn = function()
   enableBtn(allBtns.reinforced)

   slateState = 2
end

imbuedBtn = function()
   enableBtn(allBtns.imbued)

   slateState = 3
end

demonicBtn = function()
   enableBtn(allBtns.demonic)

   slateState = 4
end

allBtns.off = buttons.register(2, 2, 3, 2, defaultTextColor, defaultBgColor, 'Off', offBtn)
allBtns.blank = buttons.register(13, 2, 5, 2, defaultTextColor, defaultBgColor, 'Blank', blankBtn)
allBtns.reinforced = buttons.register(5, 6, 10, 2, defaultTextColor, defaultBgColor, 'Reinforced', reinforcedBtn)
allBtns.imbued = buttons.register(2, 10, 6, 2, defaultTextColor, defaultBgColor, 'Imbued', imbuedBtn)
allBtns.demonic = buttons.register(11, 10, 7, 2, defaultTextColor, defaultBgColor, 'Demonic', demonicBtn)

enableBtn(allBtns.off)
draw()
while (running) do
   local eventTable = {os.pullEvent()}
   local event = eventTable[1]
   
   if (event == 'rednet_message') then
      local sender, msg, distance = eventTable[2], eventTable[3], eventTable[4]

      if (msg == 'PING') then
         rednet.send(sender, 'PING')
      elseif (msg == 'slateState') then
         rednet.send(sender, slateState)
      end
   elseif (event == 'monitor_touch') then
      buttons.event(eventTable)
      buttons.draw()
   end
end

monitor.clear()
os.unloadAPI('buttons')
