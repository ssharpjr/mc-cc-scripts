rednet.open("back")
mon = peripheral.wrap("left")
 
mon.clear()
rs.setOutput("bottom", true)
 
while true do
  id, message = rednet.receive()
  if message == "movie" then
    mon.clear()
    mon.write("Loading Movie...")
    sleep(3)
    shell.run("monitor left disk/alongtimeago")
  elseif message == "test" then
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Testing")
  elseif message == "clear" then
    mon.clear()
  elseif message == "load" then
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Loading.  Please Wait....")
  elseif message == "open" then
    rs.setOutput("bottom", false)
  elseif message == "close" then
    rs.setOutput("bottom", true)
  elseif message == "reboot" then
    shell.run("reboot")
  end
end
