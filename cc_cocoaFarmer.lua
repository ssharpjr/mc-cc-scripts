-- File: cc_cocoaFarmer.lua
-- ComputerCraft Program
-- Mining Turtle
-- Farms cocoa beans
-- http://pastebin.com/stjpCFT6
-- Rev: 2015.08.26
 
-- set variables
local distToFarm = 21 -- blocks away
local treeHeight = 4 -- height-1
local mins = 15 -- time to wait
local time = mins * 60 -- seconds
local daiPad = 0 -- CC ID
local gateKeeper = 22 -- CC ID
 
 
-- Gate Controls    
rednet.open("left")
 
function openGate()
  print("Opening Gate")
  rednet.send(gateKeeper, "open")
  os.sleep(1)
end
 
function closeGate()
  print("Closing Gate")
  rednet.send(gateKeeper, "close")
  os.sleep(1)
end
     
function enterGate()
  openGate()
  turtle.forward()
  turtle.forward()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  closeGate()
end
 
function exitGate()
  openGate()
  turtle.forward()
  turtle.forward()
  turtle.forward()
  closeGate()
end
 
-- move to farm
function moveToFarm()
  print("Moving to farm")
  for i = 0, distToFarm do
    turtle.forward()
  end
end
 
-- farm cocoa beans up
function farmUp()
  turtle.select(1)
  for i = 0, treeHeight do
    turtle.dig()
    turtle.place()
    turtle.up()
  end  
end
 
-- round the corner
function roundCorner()
  turtle.turnLeft()
  turtle.forward()
  turtle.forward()
  turtle.turnRight()
  turtle.forward()
  turtle.forward()
  turtle.turnRight()
end
 
-- farm cocoa beans down
function farmDown()
  while not turtle.detectDown() do
    turtle.dig()
    turtle.place()
    turtle.down()
  end
  turtle.dig()
  turtle.place()
end
 
function goHome()
  print("Returning home")
  turtle.turnLeft()
  turtle.turnLeft()
  for i = 0, distToFarm do
    turtle.forward()
  end
end
 
function countCocoa()
  local count = 0
  sum = 0
  for i = 1, 16 do
    count = turtle.getItemCount(i)
    sum = sum + count
  end
  print(sum.." Cocoa collected")
  rednet.send(daiPad, sum.."  Cocoa collected")
end
   
-- drop everything into chest
function dropCocoa()
  print("Dropping cocoa beans")
  for i = 1, 16 do
    turtle.select(i)
    turtle.dropDown()
  end
  turtle.select(1)
end
 
-- begin program
while true do
 
shell.run("clear")
print("cocoaFarmer Program Loaded")
 
print("Program started")
rednet.send(daiPad, "started")
 
-- check alignment
print("Starting Self-Alignment...")
 
local isBlock, block = turtle.inspect()
  if block.name == "minecraft:stone" then
    print("Rotating Left")
    turtle.turnLeft()
  elseif block.name == "minecraft:cobblestone" then
    print("Spinning Around")
    turtle.turnLeft()
    turtle.turnLeft()
  elseif block.name == "minecraft:stonebrick" then
    print("Rotating Right")
    turtle.turnRight()
  elseif block.name == "chisel:marble" then
    print("Aligned")
  else
    print("Alignment Failed")
    print("Gate may be open")
    print("Exiting")
    rednet.send(daiPad, "alignFailed")
    break
  end
print("Alignment Complete")
 
openGate()
exitGate()
moveToFarm()
 
-- Check if at farm
print("Checking for cocoa...")
local isBlock, block = turtle.inspect()
 
if isBlock then
  if not block.name == "minecraft:cocoa" then
    print("Cocoa not found")
    rednet.send(daiPad, "noCocoa")
    goHome()
    enterGate()
    closeGate()
    break
  end
else
  print("Nothing detected.")
  rednet.send(daiPad, "nothing")
  goHome()
  enterGate()
  closeGate()
  break
end
   
-- farm 3 sides of 1st tree
print("Farming...")
farmUp()
roundCorner()
farmDown()
roundCorner()
farmUp()
 
-- farm 3 sides of 2nd tree
turtle.turnLeft()
turtle.turnLeft()
farmDown()
roundCorner()
farmUp()
roundCorner()
farmDown()
 
-- farm 3 sides of 3rd tree
turtle.turnLeft()
turtle.turnLeft()
farmUp()
roundCorner()
farmDown()
roundCorner()
farmUp()
roundCorner()
farmDown()
 
-- farm 4th sides of all trees
turtle.turnLeft()
turtle.forward()
turtle.forward()
turtle.forward()
turtle.forward()
turtle.turnRight()
farmUp()
turtle.turnLeft()
turtle.forward()
turtle.forward()
turtle.forward()
turtle.forward()
turtle.turnRight()
farmDown()
 
-- return to front of 1st tree
print("Farming done")
roundCorner()
 
 
-- return home
goHome()
enterGate()
countCocoa()
 
-- check for chest, drop cocoa
local isBlock, block = turtle.inspectDown()
if block.name == "EnderStorage:enderChest" then
  dropCocoa()
else
  print("Ender Chest not found")
  print("Exiting")
  rednet.send(daiPad, "noChest")
end
 
closeGate()
 
-- sleep 5 min
--print("Program waiting " ..mins.." minutes")
--os.sleep(time)
print("Done")
print("Exiting")
rednet.send(daiPad, "done")
break
end --program
