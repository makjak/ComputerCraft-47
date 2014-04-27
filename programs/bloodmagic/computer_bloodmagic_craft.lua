os.unloadAPI('buttons')
os.loadAPI('buttons')

local monSide = 'right'
local deploySide = 'left'
local collectSide = 'back'

local blankWait = 6
local reinforcedWait = 21
local imbuedWait = 36
local demonicWait = 54

local monitor = peripheral.wrap(monSide)
buttons.setDefaultOutput(monitor)

local running = true
local doingStuff = false
local waitInterval = 0

local defaultTextColor = colors.white
local defaultBgColor = colors.red
local defaultBgPressedColor = colors.lime
local allBtns = {}

draw = function()
   buttons.draw()
end

resetColors = function()
   for _, v in pairs(allBtns) do
      buttons.setColor(v, defaultTextColor, defaultBgColor)
   end
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

deploy = function(side)
   redstone.setOutput(side, true)
   os.sleep(0.5)
   redstone.setOutput(side, false)
end

offBtn = function()
   enableBtn(allBtns.off)
   draw()

   doingStuff = false
   waitInterval = 0
end

blankBtn = function()
   enableBtn(allBtns.blank)
   draw()

   doingStuff = true
   waitInterval = blankWait
end

reinforcedBtn = function()
   enableBtn(allBtns.reinforced)
   draw()

   doingStuff = true
   waitInterval = reinforcedWait
end

imbuedBtn = function()
   enableBtn(allBtns.imbued)
   draw()

   doingStuff = true
   waitInterval = imbuedWait
end

demonicBtn = function()
   enableBtn(allBtns.demonic)
   draw()

   doingStuff = true
   waitInterval = demonicWait
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
   buttons.event(eventTable)

   if (doingStuff) then
      deploy(deploySide)
      os.sleep(waitInterval)
      deploy(collectSide)
      os.sleep(2)
   end

   buttons.draw()
end

monitor.clear()
os.unloadAPI('buttons')
