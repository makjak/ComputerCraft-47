function testThread1()
	while true do
		os.sleep(2)
		print("Thread 1 (2 second interval)")
	end
end

function testThread2()
	while true do
		os.sleep(3)
		print("Thread 2 (3 second interval)")
	end
end

function threadMain()
	os.startThread(testThread1)
	os.startThread(testThread2)
	sleep(10)
	print("Ten seconds have passed.")
	-- threadMain returns, leaving only the two threads we just created running
	-- Ctrl-T will terminate both of those and then the thread API will exit, as there
	-- are no more threads.
end

shell.run("/thread-api") -- Or however you want to run the API
