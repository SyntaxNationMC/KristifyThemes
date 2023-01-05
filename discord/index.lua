local ctx = ({ ... })[1]
local base = ({ ... })[2]
local basalt = ctx.basalt

local index = base:addFrame("_app")
  :setSize("parent.w","parent.h")
  :addLayout(fs.combine(ctx.path.page, "index.xml"))

local head = index:getDeepObject("_head")
local name = ctx.config.discordTag or "ctx.config.discordTag"
local discord = head:addImage()
  :setPosition("parent.w/2-self.w/2-"..((#name)/2-1),4)
  :setSize(8, 6)
  :loadImage(fs.combine(ctx.path.page, "discord.bimg"))
local dctag = head:addLabel()
  :setText(name)
  :setPosition("parent.w/2-self.w/2+4",6)

local palette = {
    ["black"]     = 0x202124,
    ["blue"]      = 0x5662F6,
    ["gray"]      = 0x282828,
    ["lightGray"] = 0xBFBFBF,
    ["white"]     = 0xFFFFFF,
}

local mon = peripheral.wrap(ctx.config.monSide)
if mon then
  for color, code in pairs(palette) do
      mon.setPaletteColor(colors[color], code)
  end
end

return index