" Keybindings
nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
      \ "\<Plug>(vimfiler_expand_tree)",
      \ "\<Plug(vimfiler_edit_file)")
nmap <silent><buffer> - <Plug>(vimfiler_switch_to_parent_directory)
