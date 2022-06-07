{config, pkgs, ...}:
{
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  programs = {
    git = {
      enable = true;
      userName = "hariamoor-mlabs";
      userEmail = "hari@mlabs.city";
    };
  
    htop = {
      enable = true;
      package = pkgs.htop-vim;
    };
  
    home-manager.enable = true;
  
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
  
      extraConfig = ''
        set relativenumber
        set mouse=a
      '';
  
      withPython3 = true;
      withNodeJs = true;
      withRuby = true;
  
      plugins = with pkgs; [
        { plugin = vimPlugins.nightfox-nvim;
	  config = "colorscheme nightfox";
        }
        { plugin = vimPlugins.FixCursorHold-nvim;
	  config = "let g:cursorhold_updatetime = 100";
        }
        (vimUtils.buildVimPlugin {
          name = "nerdfont-vim";
          src = fetchFromGitHub {
            owner = "lambdalisue";
            repo = "nerdfont.vim";
            rev = "b7dec1f9798470abf9ef877d01e4415d72f792be";
            sha256 = "NYonYP54PVUwHbU+Q/D7MqhVh+IB0B17KaHtkg19PaI=";
          };
        })
	{ plugin = vimUtils.buildVimPlugin {
	    name = "fern-renderer-nerdfont-vim";
	    src = fetchFromGitHub {
              owner = "lambdalisue";
              repo = "fern-renderer-nerdfont.vim";
              rev = "1a3719f226edc27e7241da7cda4bc4d4c7db889c";
              sha256 = "rWsTB5GkCPqicP6zRoJWnwBUAPDklGny/vjeRu2e0YY=";
            };
	    deps = [ "nerdfont-vim" ];
	  };
	  config = "let g:fern#renderer = 'nerdfont'";
	}
        (vimUtils.buildVimPlugin {
	  name = "fern-hijack-vim";
	  src = fetchFromGitHub {
            owner = "lambdalisue";
            repo = "fern-hijack.vim";
            rev = "5989a1ac6ddffd0fe49631826b6743b129992b32";
            sha256 = "zvTTdkyywBl0U3DdZnzIXunFTZR9eRL3fJFWjAbb7JI=";
          };
	})
	vimPlugins.fern-vim
	vimPlugins.vim-sensible
	vimPlugins.vim-surround
	vimPlugins.vim-repeat
	vimPlugins.fugitive
	{ plugin = fetchFromGitHub {
            owner = "rinx";
            repo = "nvim-ripgrep";
            rev = "7a1b0a4da8858e3501b593c25d7ed66bc91a221d";
            sha256 = "c1fHP0JZIDSakrP5d8pOf6jjspAnRyjvJmv+QeWdIrc=";
          };
	  config = "command! Rg lua require'nvim-ripgrep'.grep()";
	}
        { plugin = vimPlugins.nvim-treesitter;
	  config = ''
	    require'nvim-treesitter.configs'.setup {
	      -- Install parsers synchronously (only applied to `ensure_installed`)
	      sync_install = false,
	      ensure_installed = "all",
  
	      highlight = {
	        -- `false` will disable the whole extension
	        enable = true,
	       	      
	        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	        -- Using this option may slow down your editor, and you may see some duplicate highlights.
	        -- Instead of true it can also be a list of languages
	        additional_vim_regex_highlighting = false,
	      },
            }
	  '';
	  type = "lua";
        }
	{ plugin = vimPlugins.lualine-nvim;
	  config = "require('lualine').setup()";
	  type = "lua";
	}
        { plugin = vimPlugins.nvim-lspconfig;
	  config = ''
            -- Mappings.
            local opts = { noremap=true, silent=true }
            vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
              -- Enable completion triggered by <c-x><c-o>
              vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            end
            
            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
	    local default = { on_attach = on_attach, }
	    local lspconfig = require('lspconfig')
	    
	    lspconfig.rnix.setup(default)
	    lspconfig.rust_analyzer.setup(default)
	    lspconfig.purescriptls.setup(default)
	    lspconfig.hls.setup { on_attach = on_attach, cmd = { "haskell-language-server", }, }
	  '';
	  type = "lua";
	}
      ];
    };
  
    xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.conf;
    };
  };
}
