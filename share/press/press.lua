-- Turn GitHub alerts (> [!NOTE] etc.) into #callout(kind)[...] for typst
local kinds = { note = true, tip = true, important = true, warning = true, caution = true }

function Div(el)
  local kind = el.classes[1]
  if FORMAT ~= "typst" or not kinds[kind] then return nil end
  local content = el.content
  if content[1] and content[1].t == "Div" and content[1].classes[1] == "title" then
    content:remove(1)
  end
  local out = pandoc.List { pandoc.RawBlock("typst", '#callout("' .. kind .. '")[') }
  out:extend(content)
  out:insert(pandoc.RawBlock("typst", "]"))
  return out
end

-- Tables: left-align default columns; full width, columns sized by content
function Table(tbl)
  if FORMAT ~= "typst" then return nil end
  local n = #tbl.colspecs
  local maxlen = {}
  for i = 1, n do maxlen[i] = 3 end
  local function scan(rows)
    for _, row in ipairs(rows) do
      for i, cell in ipairs(row.cells) do
        if i <= n then
          local len = #pandoc.utils.stringify(cell.contents)
          maxlen[i] = math.max(maxlen[i], math.min(len, 40))
        end
      end
    end
  end
  scan(tbl.head.rows)
  for _, body in ipairs(tbl.bodies) do scan(body.body) end
  local total = 0
  for i = 1, n do total = total + maxlen[i] end
  for i, spec in ipairs(tbl.colspecs) do
    local align = spec[1]
    if align == "AlignDefault" then align = "AlignLeft" end
    tbl.colspecs[i] = { align, maxlen[i] / total }
  end
  return tbl
end

-- Task lists: hide the bullet when every item starts with a checkbox
local function is_task(item)
  local b = item[1]
  return b and (b.t == "Plain" or b.t == "Para") and b.content[1]
    and b.content[1].t == "Str" and (b.content[1].text == "☐" or b.content[1].text == "☒")
end

function BulletList(el)
  if FORMAT ~= "typst" then return nil end
  for _, item in ipairs(el.content) do
    if not is_task(item) then return nil end
  end
  return {
    pandoc.RawBlock("typst", "#[#set list(marker: none, indent: 0.9em, body-indent: 0pt)"),
    el,
    pandoc.RawBlock("typst", "]"),
  }
end
