return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate' 
  },
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
    end
  },
  {
    "ms-jpq/coq_nvim",
    lazy=false,
    config = function(plugin)
      vim.cmd([[COQnow --shut-up]])
    end
  },
  {
    'ms-jpq/coq.artifacts',
    lazy=false
  },
  {
    "neovim/nvim-lspconfig",
    lazy=false,
    config = function(plugin)
      local lspc = require('lspconfig')
      local coq = require("coq")
      lspc.pyright.setup(
        coq.lsp_ensure_capabilities()
      )
      lspc.clangd.setup(
        coq.lsp_ensure_capabilities()
      )
      lspc.rust_analyzer.setup(
        coq.lsp_ensure_capabilities()
      )
      lspc.texlab.setup(
        coq.lsp_ensure_capabilities()
      )
      lspc.lua_ls.setup(
        coq.lsp_ensure_capabilities()
      )
    end
  },
  {
    "frabjous/knap",
    lazy=false,
    config = function(plugin)
      local kmap = vim.keymap.set 
      -- F5 processes the document once, and refreshes the view
      kmap({ 'n', 'v', 'i' },'<F5>', function() require("knap").process_once() end)
      -- F6 closes the viewer application, and allows settings to be reset
      kmap({ 'n', 'v', 'i' },'<F6>', function() require("knap").close_viewer() end)
      -- F7 toggles the auto-processing on and off
      kmap({ 'n', 'v', 'i' },'<F7>', function() require("knap").toggle_autopreviewing() end)
      -- F8 invokes a SyncTeX forward search, or similar, where appropriate
      kmap({ 'n', 'v', 'i' },'<F8>', function() require("knap").forward_jump() end)
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    'ecthelionvi/NeoColumn.nvim',
    lazy = false,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = true,
    },
  },
  {
    "NTBBloodbath/galaxyline.nvim",
    -- your statusline
    config = function()
      require("galaxyline.themes.eviline")
    end,
    -- some optional icons
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  },
}
