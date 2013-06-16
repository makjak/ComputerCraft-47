--
-- Main purpose of this program is to enchant books
--
-- With this program turtle kill mobs, drops items
-- from them, collects level and enchant books
-- (or other items) to specified level (default is 30)
-- It takes books/items from top; drops mobs stuff to bottom
-- and kills mobs in front of it.
--

local xpSide = "right"
local xp = peripheral.wrap(xpSide)

local itemSlot = 1
local enchantingLevel = 30

function dropItems()
	for i = 1, 16 do
		if i ~= itemSlot then
			turtle.select(i)
			turtle.dropDown()
		end
	end

	turtle.select(1)
end

while true do
	while turtle.getItemCount(itemSlot) == 0 do
		while not turtle.suckUp() do
			sleep(0.5)
		end
		sleep(1)
	end

	local firstDrop = false
	local secondDrop = false
	local thirdDrop = false
	local prevLevel = -1

	while xp.getLevels() < enchantingLevel do
		if not turtle.attack() then
			sleep(0.5)
		end

		xp.collect()
		local currLevel = xp.getLevels()

		if currLevel > prevLevel then
			print("Current level: "..currLevel)
			prevLevel = currLevel
		end

		if (currLevel == 10) and (not firstDrop) then
			dropItems()
			firstDrop = true
		elseif (currLevel == 20) and (not secondDrop) then
			dropItems()
			secondDrop = true
		elseif (currLevel == 30) and (not thirdDrop) then
			dropItems()
			thirdDrop = true
		end
	end

	print("Enchanting time!")
	turtle.select(itemSlot)
	if itemSlot ~= 16 then
		turtle.transferTo(itemSlot + 1, 1)
		turtle.select(itemSlot + 1)
	else 
		turtle.transferTo(itemSlot - 1, 1)
		turtle.select(itemSlot - 1)
	end
	xp.enchant(enchantingLevel)
	turtle.dropDown()
	turtle.select(1)
end
