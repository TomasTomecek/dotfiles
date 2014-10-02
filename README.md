dotfiles
========

This is configuration of my system.

installation
============

    curl -sSL https://raw.githubusercontent.com/TomasTomecek/dotfiles/master/bin/install.sh | bash -x

FIXUPS
======

don't forget to apply:

    diff --git a/colors/solarized.vim b/colors/solarized.vim
    index 70f5223..cf739b9 100644
    --- a/colors/solarized.vim
    +++ b/colors/solarized.vim
    @@ -654,7 +654,7 @@ exe "hi! DiffDelete"     .s:fmt_none   .s:fg_red    .s:bg_base02
     exe "hi! DiffText"       .s:fmt_none   .s:fg_blue   .s:bg_base02 .s:sp_blue
         endif
     endif
    -exe "hi! SignColumn"     .s:fmt_none   .s:fg_base0
    +exe "hi! SignColumn"     .s:fmt_none   .s:fg_base0  .s:bg_none
     exe "hi! Conceal"        .s:fmt_none   .s:fg_blue   .s:bg_none
     exe "hi! SpellBad"       .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_red
     exe "hi! SpellCap"       .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_violet
