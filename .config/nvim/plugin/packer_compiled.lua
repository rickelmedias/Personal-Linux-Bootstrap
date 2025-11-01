-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/r1ddax/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?.lua;/home/r1ddax/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?/init.lua;/home/r1ddax/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?.lua;/home/r1ddax/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/r1ddax/.cache/nvim/packer_hererocks/2.1.1703358377/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["monokai-pro.nvim"] = {
    config = { "\27LJ\2\n×\4\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\25\0005\4\24\0=\4\26\0035\4\27\0=\4\28\3=\3\29\2B\0\2\1K\0\1\0\fplugins\21indent_blankline\1\0\2\28context_start_underline\1\22context_highlight\fdefault\15bufferline\1\0\0\1\0\2\23underline_selected\1\22underline_visible\1\21background_clear\1\5\0\0\15toggleterm\14telescope\frenamer\vnotify\vstyles\18tag_attribute\1\0\1\vitalic\2\15annotation\1\0\1\vitalic\2\14parameter\1\0\1\vitalic\2\14structure\1\0\1\vitalic\2\17storageclass\1\0\1\vitalic\2\ttype\1\0\1\vitalic\2\fkeyword\1\0\1\vitalic\2\fcomment\1\0\0\1\0\1\vitalic\2\1\0\4\27transparent_background\1\vfilter\bpro\rdevicons\2\20terminal_colors\2\nsetup\16monokai-pro\frequire\0" },
    loaded = true,
    path = "/home/r1ddax/.local/share/nvim/site/pack/packer/start/monokai-pro.nvim",
    url = "https://github.com/loctvl842/monokai-pro.nvim"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÒ\3\0\0\a\0\f\0\0196\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1€K\0\1\0009\2\3\0015\4\5\0005\5\4\0=\5\6\0045\5\a\0004\6\0\0=\6\b\5=\5\t\0045\5\n\0=\5\v\4B\2\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\2\17sync_install\1\17auto_install\1\1!\0\0\blua\bvim\vvimdoc\nquery\thtml\bcss\tscss\15javascript\15typescript\btsx\tjson\tyaml\ttoml\vpython\truby\bphp\ago\trust\tjava\vkotlin\6c\bcpp\fc_sharp\tbash\15dockerfile\rmarkdown\20markdown_inline\bsql\fgraphql\nregex\14gitcommit\14gitignore\nsetup\28nvim-treesitter.configs\frequire\npcall\0" },
    loaded = true,
    path = "/home/r1ddax/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/r1ddax/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/r1ddax/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/r1ddax/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÒ\3\0\0\a\0\f\0\0196\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1€K\0\1\0009\2\3\0015\4\5\0005\5\4\0=\5\6\0045\5\a\0004\6\0\0=\6\b\5=\5\t\0045\5\n\0=\5\v\4B\2\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\fdisable\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\2\17sync_install\1\17auto_install\1\1!\0\0\blua\bvim\vvimdoc\nquery\thtml\bcss\tscss\15javascript\15typescript\btsx\tjson\tyaml\ttoml\vpython\truby\bphp\ago\trust\tjava\vkotlin\6c\bcpp\fc_sharp\tbash\15dockerfile\rmarkdown\20markdown_inline\bsql\fgraphql\nregex\14gitcommit\14gitignore\nsetup\28nvim-treesitter.configs\frequire\npcall\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: monokai-pro.nvim
time([[Config for monokai-pro.nvim]], true)
try_loadstring("\27LJ\2\n×\4\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\25\0005\4\24\0=\4\26\0035\4\27\0=\4\28\3=\3\29\2B\0\2\1K\0\1\0\fplugins\21indent_blankline\1\0\2\28context_start_underline\1\22context_highlight\fdefault\15bufferline\1\0\0\1\0\2\23underline_selected\1\22underline_visible\1\21background_clear\1\5\0\0\15toggleterm\14telescope\frenamer\vnotify\vstyles\18tag_attribute\1\0\1\vitalic\2\15annotation\1\0\1\vitalic\2\14parameter\1\0\1\vitalic\2\14structure\1\0\1\vitalic\2\17storageclass\1\0\1\vitalic\2\ttype\1\0\1\vitalic\2\fkeyword\1\0\1\vitalic\2\fcomment\1\0\0\1\0\1\vitalic\2\1\0\4\27transparent_background\1\vfilter\bpro\rdevicons\2\20terminal_colors\2\nsetup\16monokai-pro\frequire\0", "config", "monokai-pro.nvim")
time([[Config for monokai-pro.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
