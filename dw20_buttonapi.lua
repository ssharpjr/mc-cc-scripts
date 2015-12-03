local mon = peripheral.wrap("right")
mon.setTextScale(1)
mon.setTextColor(colors.white)
local button={}
mon.setBackgroundColor(colors.black)
     
function setTable(name, func, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
end
 
function funcName()
   print("You clicked buttonText")
end
       
function fillTable()
   setTable("ButtonText", funcName, 5, 25, 4, 8)
   setTable("OtherButton is COOL!", funcName, 5, 35, 10, 12)
end    
 
function fill(text, color, bData)
   mon.setBackgroundColor(color)
   local yspot = math.floor((bData["ymin"] + bData["ymax"]) /2)
   local xspot = math.floor((bData["xmax"] - bData["xmin"] - string.len(text)) /2) +1
   for j = bData["ymin"], bData["ymax"] do
      mon.setCursorPos(bData["xmin"], j)
      if j == yspot then
         for k = 0, bData["xmax"] - bData["xmin"] - string.len(text) +1 do
            if k == xspot then
               mon.write(text)
            else
               mon.write(" ")
            end
         end
      else
         for i = bData["xmin"], bData["xmax"] do
            mon.write(" ")
         end
      end
   end
   mon.setBackgroundColor(colors.black)
end
     
function screen()
   local currColor
   for name,data in pairs(button) do
      local on = data["active"]
      if on == true then currColor = colors.lime else currColor = colors.red end
      fill(name, currColor, data)
   end
end
     
function checkxy(x, y)
   for name, data in pairs(button) do
      if y>=data["ymin"] and  y <= data["ymax"] then
         if x>=data["xmin"] and x<= data["xmax"] then
            data["func"]()
            data["active"] = not data["active"]
            print(name)
         end
      end
   end
end
     
function heading(text)
   w, h = mon.getSize()
   mon.setCursorPos((w-string.len(text))/2+1, 1)
   mon.write(text)
end
     
fillTable()
while true do
   mon.clear()
   heading("Heading Goes Here")
   screen()
   local e,side,x,y = os.pullEvent("monitor_touch")
   print(x..":"..y)
   checkxy(x,y)
   sleep(.1)
end
