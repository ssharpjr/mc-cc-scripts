os.loadAPI("button")
m = peripheral.wrap("right")
m.clear()
 
function fillTable()
   button.setTable("Test1", test1, 10,20,3,5)
   button.setTable("Test2", test2, 22,32,3,5)
   button.setTable("Test3", test3, 10,20,8,10)
   button.setTable("Test4", test4, 22,32,8,10)
   button.setTable("Test5", test5, 34,44,3,5)
   button.setTable("Test6", test6, 34,44,8,10)
   button.screen()
end
 
function getClick()
   event,side,x,y = os.pullEvent("monitor_touch")
   button.checkxy(x,y)
end
 
function test1()
   button.flash("Test1")
   print("Test1")
end
 
function test2()
   button.toggleButton("Test2")
   print("Test2")
end
 
function test3()
   button.toggleButton("Test3")
   print("Test3")
end
 
function test4()
   button.flash("Test4")
   print("Test4")
end
 
fillTable()
button.heading("Demo Button Program")
button.label(1,15,"Demo Label")
 
while true do
   getClick()
end
