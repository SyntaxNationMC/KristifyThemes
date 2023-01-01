local ctx = ({ ... })[1]
local base = ({ ... })[2]
local basalt = ctx.basalt

local index = base:addFrame("_app")
  :setSize("parent.w","parent.h")
  :addLayout(fs.combine(ctx.path.page, "index.xml"))

basalt.onEvent(function(event)
  if event == "kristify:IndexLoaded" then
    local category = index:getDeepObject("__category")
    if category then
      local color = category:getForeground()
      local nW,_ = index:getSize()
      local nW = nW/3.3
      category:addLabel()
        :setText("Product")
        :setPosition(2,1)
        :setForeground(color)
      category:addLabel()
        :setText("Amount")
        :setPosition(nW,1)
        :setForeground(color)
      category:addLabel()
        :setText("Name")
        :setPosition(nW*2,1)
        :setForeground(color)
      category:addLabel()
        :setText("Price")
        :setPosition(nW*3,1)
        :setForeground(color)
    end
  elseif event == "kristify:CatalogUpdated" then
    local nCategoryW = 10
    local category = index:getDeepObject("__category")
    if category then
      local nW,_ = index:getSize()
      nCategoryW = nW/3.3
    end

    -- Modify widgets
    local body = index:getDeepObject("_body")
    local obj = body:getObject("_widget_1")
    local i=1
    repeat
      if i%2 == 1 then
        obj:setBackground(body:getForeground())
      end
      local function repos(name, pos)
        local sub = obj:getDeepObject(name)
        if not sub then return end
        local _,nY = sub:getPosition()
        sub:setPosition(pos,nY)
        return sub
      end

      repos("_name", 2)
      local sub = repos("_stock", 1+nCategoryW)
      if sub then
        local amount = tonumber(sub:getValue()) or 0
        sub:setText(amount.." ("..math.floor(amount/64)..")")
      end
      local meta = repos("_metaname", 1+nCategoryW*2)
      if meta then
        local name = meta:getValue()
        meta:setText(name..'@')
      end

      i = i+1
      obj = body:getDeepObject("_widget_"..i)
    until obj == nil
    basalt.drawFrames()
  end
end)

return index