# dotFiles - Configurations
## Alacritty 
- Website - [Alacritty](https://alacritty.org)
- Color Schemes - [Alacritty-Theme](https://github.com/alacritty/alacritty-theme)
- Configuration - 
    - [GitHub Wiki](https://github.com/alacritty/alacritty/wiki)
    - File: ``[Project-Location]/config/alacritty/alacritty.yml``

## Fish 
- Requierments:
    - [Fish](https://fishshell.com)
    - [Starship](https://starship.rs) 
- Configuration file: ``[Project-Location]/config/fish/config.fish``
- Has vi key bindings:
    - The Mode is Shown in the prompt like  '[Mode] ❯' signe.
        - 'I ❯' - i - Insert mode.
        - 'R ❯' - r - Replace mode.
        - 'V ❯' - v - Visual Mode.
        - 'N ❯' - Normal Mode.
    - ESC - Exit to Normal mode

## Tmux
- The default leader binding changed from ``C-b`` to ``C-s``.
- Using vi key bindings in the select mode.
- Configuration File: ``[Project-Location]/tmux.conf``
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
        
## MyCli
- [GitHub](https://github.com/dbcli/mycli)
- [Website](https://www.mycli.net)
- [DBCli Tools](https://www.dbcli.com)
- vi keybinding configured.
- Configuration File: ``[Project-Location]/myclirc``
- DSN configuration example
```
//dsn = "<driver>://<username>:<password>@<host>:<port>/<database>";
  dsn = "mysql://john:pass@localhost:3306/my_db";
```

## Nvim
The nvim Documentation is in nvim's [README](/config/nvim/README.md) file.

## Deploy Configuration:
```bash 
ln -s [Project-Location]/config/alacritty ~/.config/alacritty
ln -s [Project-Location]/config/fish ~/.config/fish
ln -s [Project-Location]/config/nvim ~/.config/nvim
ln -s [Project-Location]/config/starship.toml ~/.config/starship.toml
ln -s [Project-Location]/tmux.conf ~/.tmux.conf
ln -s [Project-Location]/myclirc ~/.myclirc
```

## Todo
- Need to move Tmux IP query into seperate a script.
