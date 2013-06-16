--
-- Main purpose of this program is to enchant books
--
-- With this program turtle kill mobs, drops items
-- from them, collects level and enchant books
-- (or other items) to specified level (default is 30)
-- It takes books/items from top; drops mobs stuff to bottom
-- and kills mobs in front of it.
--

xpSide = "right"
xp = peripheral.wrap(xpSide)

itemSlot = 1
enchantingLevel = 30

function dropItems()
	for i = 1, 16 do
		if i ~= itemSlot then
			turtle.select(i)
			turtle.dropDown()
		end
	end

	if itemSlot ~= 1 then
		turtle.select(1)
	else
		turtle.select(2)
	end
end

while true do
	while turtle.getItemCount(itemSlot) == 0 do
		while not turtle.suckUp() do
			sleep(0.5)
		end
		sleep(1)
	end

	while xp.getLevels() < enchantingLevel do
		if not turtle.attack() then
			sleep(0.5)
		end
		xp.collect()
		print("Current level: "..xp.getLevels())
	end
	dropItems()

	turtle.select(itemSlot)
	xp.enchant(enchantingLevel)
end
