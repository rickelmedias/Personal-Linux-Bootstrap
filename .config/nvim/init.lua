-- ==========================================
-- 1. Configurações Básicas (Opções)
-- ==========================================
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = ' '

-- ==========================================
-- 2. Bootstrap do Packer (Instalação Automática)
-- ==========================================
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Clonando Packer... Por favor aguarde.")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- ==========================================
-- 3. Carregamento dos Plugins
-- ==========================================
-- Protege a chamada do packer para não dar erro se não estiver instalado ainda
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  print("Packer não encontrado. Tente reiniciar o Neovim após o clone.")
  return
end

-- Carrega sua lista de plugins do arquivo plugin.lua
local plugins_list = require('plugin')

packer.startup(function(use)
  -- O Packer gerencia a si mesmo
  use 'wbthomason/packer.nvim'

  -- Itera sobre a sua tabela de plugins e carrega um por um
  for _, plugin in ipairs(plugins_list) do
    use(plugin)
  end

  -- Sincroniza automaticamente se for a primeira vez
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- ==========================================
-- 4. Tema e Cores (Safe Load)
-- ==========================================
-- Tentamos carregar o tema. Se falhar (plugin não instalado), não quebra o editor.
local status_theme, _ = pcall(vim.cmd, "colorscheme monokai-pro")
if not status_theme then
  print("Tema monokai-pro não encontrado. Rodando :PackerSync...")
end

-- ==========================================
-- 5. Keymaps e Telescope
-- ==========================================
local status_ok_telescope, builtin = pcall(require, 'telescope.builtin')
if status_ok_telescope then
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end
