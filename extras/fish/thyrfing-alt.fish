# name: THYRFING ALT colors for Fish
# url: https://fishshell.com/docs/current/index.html
# upstream: https://github.com/metalelf0/black-metal.nvim/raw/main/extras/fish/thyrfing-alt.fish
# author: Andrea Schiavini (original code by Casey Miller)

# use in ~/.config/fish/conf.d/

# preferred bg: 31120a
# alt background: 31120a

### Full palette. 
### Colors defined in neomdern/palette/THYRFING ALT.lua
set -g alt 5f8787 
set -g constant aaaaaa 
set -g comment 505050 
set -g fg f1f1f1 
set -g func 888888 
set -g keyword 999999 
set -g number aaaaaa 
set -g operator 9b99a3 
set -g property c1c1c1 
set -g str B04024 
set -g type AF4C35 

# Syntax Highlighting Colors
set -g fish_color_normal f1f1f1
set -g fish_color_command 888888
set -g fish_color_keyword 999999
set -g fish_color_quote B04024
set -g fish_color_redirection aaaaaa
set -g fish_color_end 9b99a3
set -g fish_color_error 5f8787
set -g fish_color_param f1f1f1
set -g fish_color_valid_path AF4C35
set -g fish_color_option 5f8787
set -g fish_color_comment 505050
set -g fish_color_selection --background=31120a
set -g fish_color_operator 9b99a3
set -g fish_color_escape 999999
set -g fish_color_autosuggestion 505050
set -g fish_color_cwd B04024
set -g fish_color_hostname aaaaaa
set -g fish_color_status 5f8787
set -g fish_color_cancel aaaaaa
set -g fish_color_search_match --background=31120a

# Completion Pager Colors
set -g fish_pager_color_progress 5f8787
set -g fish_pager_color_prefix AF4C35
set -g fish_pager_color_completion f1f1f1
set -g fish_pager_color_description 505050
set -g fish_pager_color_selected_prefix 5f8787
set -g fish_pager_color_selected_completion 5f8787
set -g fish_pager_color_selected_background --background=31120a
