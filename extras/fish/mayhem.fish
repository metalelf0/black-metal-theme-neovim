# name: MAYHEM colors for Fish
# url: https://fishshell.com/docs/current/index.html
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

# use in ~/.config/fish/conf.d/

# preferred bg: 000000
# alt background: 4d2020

### Full palette. 
### Colors defined in neomdern/palette/MAYHEM.lua
set -g alt 5f8787 
set -g constant aaaaaa 
set -g comment 505050 
set -g fg c1c1c1 
set -g func 888888 
set -g keyword 999999 
set -g number aaaaaa 
set -g operator 9b99a3 
set -g property c1c1c1 
set -g str f3ecd4 
set -g type eecc6c 

# Syntax Highlighting Colors
set -g fish_color_normal c1c1c1
set -g fish_color_command 888888
set -g fish_color_keyword 999999
set -g fish_color_quote f3ecd4
set -g fish_color_redirection aaaaaa
set -g fish_color_end 9b99a3
set -g fish_color_error 5f8787
set -g fish_color_param c1c1c1
set -g fish_color_valid_path eecc6c
set -g fish_color_option 5f8787
set -g fish_color_comment 505050
set -g fish_color_selection --background=000000
set -g fish_color_operator 9b99a3
set -g fish_color_escape 999999
set -g fish_color_autosuggestion 505050
set -g fish_color_cwd f3ecd4
set -g fish_color_hostname aaaaaa
set -g fish_color_status 5f8787
set -g fish_color_cancel aaaaaa
set -g fish_color_search_match --background=000000

# Completion Pager Colors
set -g fish_pager_color_progress 5f8787
set -g fish_pager_color_prefix eecc6c
set -g fish_pager_color_completion c1c1c1
set -g fish_pager_color_description 505050
set -g fish_pager_color_selected_prefix 5f8787
set -g fish_pager_color_selected_completion 5f8787
set -g fish_pager_color_selected_background --background=000000
