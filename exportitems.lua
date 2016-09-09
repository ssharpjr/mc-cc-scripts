me = peripheral.wrap("right")
exportDir = "SOUTH"

stone = "minecraft:stone"

meList = me.getAvailableItems()

print("Stone Exporter 3000\n")

for number, item in pairs(meList) do
  if item.fingerprint.id == stone then
    print("\nI have "..item.size.." stone.")
    print("How many would you like exported?")
    input = tonumber(read())
    if input > item.size then
      print("\nSorry, I only have "..item.size.." stone.")
    else 
      me.exportItem(meList[number].fingerprint, exportDir, input, 0)
      print("\nExported: "..input.."  stone.")
      print("Now I have "..item.size - input.." stone left.")
    end
  --else
    --print("\nLooks like I'm out of stone.\nPlease come back later.")
    --break
  end
end

print()
print("Goodbye")
