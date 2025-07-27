-- [nfnl] fnl/highlight_visual/init.fnl
local function get_visual_range()
  local mode = vim.fn.mode()
  if ("n" == mode) then
    return
  else
  end
  if (mode == "V") then
    local cl = vim.fn.line(".")
    local pl = vim.fn.line("v")
    if (cl < pl) then
      return {{(cl - 1), 0}, {(pl - 1), vim.v.maxcol}}
    else
      return {{(pl - 1), 0}, {(cl - 1), vim.v.maxcol}}
    end
  else
    local _ = mode
    local cp = vim.fn.getpos(".")
    local pp = vim.fn.getpos("v")
    local _0 = cp[1]
    local cl = cp[2]
    local cc = cp[3]
    local _1 = cp[4]
    local _2 = pp[1]
    local pl = pp[2]
    local pc = pp[3]
    local _3 = pp[4]
    if ((cl < pl) or ((cl == pl) and (cc < pc))) then
      return {{(cl - 1), (cc - 1)}, {(pl - 1), pc}}
    else
      return {{(pl - 1), (pc - 1)}, {(cl - 1), cc}}
    end
  end
end
local function back_to_normal_mode()
  return vim.cmd("exe \"normal \\<Esc>\"")
end
local M = {}
local default_config = {hl_group = "Visual", key = "<Leader>v"}
local nsid = vim.api.nvim_create_namespace("zz_highlight_visual")
M.highlight_visual = function()
  vim.api.nvim_buf_clear_namespace(0, nsid, 0, -1)
  do
    local _5_ = get_visual_range()
    if ((_G.type(_5_) == "table") and (nil ~= _5_[1]) and (nil ~= _5_[2])) then
      local from = _5_[1]
      local to = _5_[2]
      vim.hl.range(0, nsid, M.config.hl_group, from, to)
    else
    end
  end
  back_to_normal_mode()
  return nil
end
local function create_keymaps()
  return vim.keymap.set({"n", "v"}, M.config.key, M.highlight_visual, {desc = "Highlight Visual"})
end
M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", default_config, (config or {}))
  create_keymaps()
  return nil
end
return M
