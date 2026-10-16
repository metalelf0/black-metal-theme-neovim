# name: WINDIR LIGHT ALT colors for Fish
# url: https://fishshell.com/docs/current/index.html
# upstream: https://github.com/metalelf0/black-metal.nvim/raw/main/extras/fish/windir-light-alt.fish
# author: Andrea Schiavini (original code by Casey Miller)

# use in ~/.config/fish/conf.d/

# preferred bg: bfdeb5
# alt background: bfdeb5

### Full palette. 
### Colors defined in neomdern/palette/WINDIR LIGHT ALT.lua
set -g alt 634436 
set -g constant 423b7d 
set -g comment 506049 
set -g fg 172112 
set -g func 344d79 
set -g keyword 5e5e26 
set -g number 735431 
set -g operator 4d6043 
set -g property 172112 
set -g str 5e5e12 
set -g type 3e5b8e 

# Syntax Highlighting Colors
set -g fish_color_normal 172112
set -g fish_color_command 344d79
set -g fish_color_keyword 5e5e26
set -g fish_color_quote 5e5e12
set -g fish_color_redirection 423b7d
set -g fish_color_end 4d6043
set -g fish_color_error a13b3b
set -g fish_color_param 172112
set -g fish_color_valid_path 3e5b8e
set -g fish_color_option 634436
set -g fish_color_comment 506049
set -g fish_color_selection --background=bfdeb5
set -g fish_color_operator 4d6043
set -g fish_color_escape 5e5e26
set -g fish_color_autosuggestion 506049
set -g fish_color_cwd 5e5e12
set -g fish_color_hostname 735431
set -g fish_color_status a13b3b
set -g fish_color_cancel 735431
set -g fish_color_search_match --background=bfdeb5

# Completion Pager Colors
set -g fish_pager_color_progress 634436
set -g fish_pager_color_prefix 3e5b8e
set -g fish_pager_color_completion 172112
set -g fish_pager_color_description 506049
set -g fish_pager_color_selected_prefix 634436
set -g fish_pager_color_selected_completion 634436
set -g fish_pager_color_selected_background --background=bfdeb5
