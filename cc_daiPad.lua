-- File: cc_daiPad.lua
-- Computer Craft Program
-- Menu for Pocket Computer
 
rednet.open("back")
os.loadAPI("button")
 
local m = term
local menuType = "mainMenu"
local cf = 20 --cocoaFarmer
local gk = 22 --gatekeeper
local wb = 3  --welcomeboard
 
function mainMenu()
  m.clear()
  button.clearTable()
  button.heading("DaiPad Base Controller")
  button.label(1, 3, "Gate Keeper")
  button.setTable("Open Gate", openGate, "", 3, 13, 4, 4)
  button.setTable("Close Gate", closeGate, "", 15, 25, 4, 4)
  button.label(1, 6, "Welcome Board")
  button.setTable("Open WB", openWb, "", 3, 13, 7, 7)
  button.setTable("Close WB", closeWb, "", 15, 25, 7, 7)
  button.label(1, 9, "Turtle Controls")
  button.setTable("CF: Farm", cocoaFarmer, "", 3, 13, 10, 10)
  button.setTable("CF: Locate", cfLocate, "", 15, 25, 10, 10)
  button.screen()
end
 
function displayScreen()
  if menuType == "mainMenu" then
    mainMenu()
  end
  local event, side, x, y
  event, side, x, y = os.pullEvent()
  while event ~= "mouse_click" do
    event, side, x, y = os.pullEvent()
  end
  button.checkxy(x,y)
end
 
function openGate()
  button.flash("Open Gate")
  rednet.send(gk, "open")
end
 
function closeGate()
  button.flash("Close Gate")
  rednet.send(gk, "close")
end
 
function openWb()
  button.flash("Open WB")
  rednet.send(wb, "open")
end
 
function closeWb()
  button.flash("Close WB")
  rednet.send(wb, "close")
end
 
function cocoaFarmer()
  button.flash("CF: Farm")
  rednet.send(cf, "cocoaFarmer")
end
 
function cfLocate()
  button.flash("CF: Locate")
  rednet.send(cf, "cfLocate")
end
 
 
-- begin program
while true do
  displayScreen()
end
