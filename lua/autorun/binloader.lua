local DATA = "binloader.json"
if (!file.Exists(DATA, "DATA")) then
  file.Append(DATA, "[]")
end

local binloaderColor = Color(151, 40, 249)
local greyColor = Color(200, 200, 200)

---@param msg string
local function log(msg)
  MsgC(binloaderColor, "[binLoader] ", greyColor, msg)
  MsgN()
end

---@param name string
---@return boolean Is module loaded
local function req(name)
  local suc, err = pcall(require, name)

  if (!suc) then
    log(("Unable to load module \"%s\""):format(name))
    return false
  end

  log(("Loaded module \"%s\""):format(name))
  return true
end

local commands = {
  ---@param tab string[]
  add = function(tab)
    local name = tab[1]
    local loaded = req(name)

    if (!loaded) then
      return
    end

    local content = util.JSONToTable(file.Read(DATA, "DATA"))
    content[#content+1] = name
    file.Write(DATA, util.TableToJSON(content))
  end,
  ---@param tab string[]
  remove = function(tab)
    local content = util.JSONToTable(file.Read(DATA, "DATA"))
    local name = tab[1]
    local ind;

    for i, v in ipairs(content) do
      if (v == name) then
        ind = i
        break
      end
    end

    if (!ind) then
      return log(("no \"%s\" in \"%s\""):format(name, DATA))
    end

    table.remove(content, ind)

    file.Write(DATA, util.TableToJSON(content))

    log(("\"%s\" removed from dependencies"):format(name))
  end,
  list = function()
    local content = util.JSONToTable(file.Read(DATA, "DATA"))

    log("loaded modules")
    for _, module in ipairs(content) do
      MsgC(binloaderColor, "    • ", greyColor, module)
      MsgN()
    end
  end
}

---@param player Player
---@param msg string
local say = function(player, msg)
  if IsValid(player) then
    return player:ChatPrint(msg)
  end

  log(msg)
end

concommand.Add("bin", function(ply, _, args)
  if (IsValid(ply) && !ply:IsSuperAdmin()) then
    return ply:ChatPrint("Sosi hui")
  end

  local cmd = args[1]

  if (!cmd) then
    return say(player, "no command provided")
  end

  local command = commands[cmd]

  if (!command) then
    return say(player, "command not found")
  end

  table.remove(args, 1)

  command(args)
end)

-- module loading
if (!BINLOADER_INITIALIZED) then
  BINLOADER_INITIALIZED = true

  local content = util.JSONToTable(file.Read(DATA, "DATA"))

  for _, module in ipairs(content) do
    req(module)
  end
end