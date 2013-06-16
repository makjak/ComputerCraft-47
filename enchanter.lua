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

bookSlot = 1
enchantingLevel = 30

while true do
	while turtle.getItemCount(bookSlot) == 0 do
		while not turtle.suckUp() do
			sleep(0.5)
		end
		sleep(1)
	end

	while xp.getLevel() < enchantingLevel do
		if not turtle.attack() then
			sleep(0.5)
		end

		xp.collect()

		for i = 2, 16 do
			turtle.select(i)
			turtle.dropDown()
		end
	end


end
