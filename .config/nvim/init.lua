 -- 1. Configurações Básicas e Tema

vim.cmd("set expandtab")

vim.cmd("set tabstop=2")

vim.cmd("set softtabstop=2")

vim.cmd("set shiftwidth=2")

vim.cmd [[colorscheme monokai-pro]]


-- 1.1 Definindo <leader> como SPACE

vim.g.mapleader = ' '


local plugin_list = require('plugin')


-- 2. Bootstrap Packer

local ensure_packer = function()

  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then

    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

    vim.cmd [[packadd packer.nvim]]

    return true

  end

  return false

end


local packer_bootstrap = ensure_packer()


-- 3. Inicialização do Packer

local status_ok, packer = pcall(require, 'packer')

if status_ok then

  packer.startup(function(use)

    -- O plugin do Packer deve vir primeiro na lista para o bootstrap funcionar

    use 'wbthomason/packer.nvim'

    

    -- Carrega o conteúdo do arquivo plugin.lua (que deve retornar a tabela)

    use(require('plugin'))

    

    if packer_bootstrap then

      require('packer').sync()

    end

  end)

end



-- 4. Keymaps e Configurações Telescope

local status_ok_telescope, builtin = pcall(require, 'telescope.builtin')

if status_ok_telescope then

  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

end


