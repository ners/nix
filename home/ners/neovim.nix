{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ haskellPackages.fourmolu nixfmt ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      coc-clangd
      coc-fzf
      coc-git
      coc-json
      coc-nvim
      delimitMate
      fzf-lsp-nvim
      fzfWrapper
      neoformat
      nerdtree
      nerdtree-git-plugin
      tagbar
      vim-code-dark
      vim-devicons
      vim-nerdtree-syntax-highlight
      vim-nix
      vim-pug
      vim-vue
      vimtex
    ];
    extraConfig = ''
      set mouse=a
      set t_Co=256
      set t_ut=
      colorscheme codedark
      let g:airline_theme = 'codedark'
      set number
      set list listchars=tab:›\ ,trail:~,extends:»,precedes:«,nbsp:_
      set ts=4 sts=4 sw=4 noexpandtab
      set autoindent smartindent
      set incsearch hlsearch
      set ignorecase smartcase
      set splitright splitbelow
      filetype on
      syntax on
      filetype plugin on
      filetype indent on
      set autoread
      au FocusGained * :checktime
      let g:WebDevIconsUnicodeDecorateFolderNodes = 1
      let g:DevIconsEnableFoldersOpenClose = 1
      let g:DevIconsEnableFolderExtensionPatternMatching = 1
      let g:DevIconsDefaultFolderOpenSymbol='ﱮ'
      let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''
      let g:NERDTreeDirArrowExpandable = ""
      let g:NERDTreeDirArrowCollapsible = ""
      let g:NERDTreeAutoDeleteBuffer = 1
      let g:NERDTreeMinimalUI = 1
      let g:NERDTreeDirArrows = 0
      let g:NERDTreeGitStatusUseNerdFonts = 1
      let g:NERDTreeShowHidden=1
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      autocmd BufWritePre * Neoformat

      nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
      nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
      nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
      nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
      nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
      nnoremap <silent> <space>f       :<C-u>CocFzfList gfiles<CR>
      nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
      nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
      nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
      nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>
    '';
  };

  xdg.configFile."nvim/ginit.vim".text = ''
    GuiFont! Cousine Nerd Font:h11
    highlight LineNr guibg=NONE
    " highlight NonText guifg=bg
  '';

  xdg.configFile."nvim/ftplugin/nix.vim".text = ''
    set ts=2 sts=2 sw=2 expandtab
  '';

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON {
    diagnostic = {
      errorSign = "🔥";
      warningSign = "⚠️";
      infoSign = "ℹ️";
    };
    languageserver.haskell = {
      command = "haskell-language-server-wrapper";
      args = [ "--lsp" ];
      rootPatterns =
        [ "*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml" ];
      filetypes = [ "haskell" "lhaskell" ];
      initializationOptions = {
        haskell = { formattingProvider = "fourmolu"; };
      };
    };
  };
}
