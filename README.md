# dotFiles - Configurations
## Fish 
- Requierments:
    - [Fish](https://fishshell.com)
    - [Starship](https://starship.rs) 
- Has vi key bindings:
    - i - Start in insert mode.
    - ESC - change to Normal mode
    - etc..

## Tmux
- The default leader binding changed from ``C-b`` to ``C-s``.
- Using vi key bindings in the select mode.
- Update before use:
    - Need to Edit the IP queries i order to get the requied IP address.
    - Change the default shell in:
    ```
        set-option -g default-command fish # <- change the fish to favorite shell
    ```
- All the Key can be found in ``C-s ?`` 
    - ``C-r`` - Reload the tmux configurations.
    - Move between pains(in Circle)h
        - ``C-j`` - Move Down
        - ``C-k`` - Move Up 
        - ``C-h`` - Move Left
        - ``C-l`` - Move Right

## Nvim
- Plugins:
    - 
- Key Bindings:
    - 

## Deploy Configuration:
```bash 
ln -s [Project-Location]/tmux.conf ~/.tmux.conf
ln -s [Project-Location]/config/fish ~/.config/fish
ln -s [Project-Location]/config/nvim ~/.config/nvim
```

## Todo
- Need to move Tmux IP query into seperate a script.
