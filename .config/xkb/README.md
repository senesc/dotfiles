# My XKB config
This is my XKB config. Here's what i modified:
- `Caps Lock` becomes a `Level3 Shift`;
- Pressing both `Shift` keys together toggles `Caps Lock`;
- `Level3 + hjkl` are mapped to arrow keys;
- `Level3 + 4` is mapped to `€`;
- `Level3 + p` is mapped to `+`;
- `Level3 + m` is mapped to `-`;
- `Level3 + aeqiou` are mapped respectively to `àèéìòù` (for Italian accents);

## Other stuff i do
Other than using a custom xkb layout, I map short presses of some modifier keys with the [dual function keys](https://gitlab.com/interception/linux/plugins/dual-function-keys) interception plugin:
- `Caps Lock` to `Esc`;
- `Left Alt` to `F12` (for Tmux);
- `Right Alt` to `F11` (for Tmux inside SSH sessions).

## Compatibility
Putting user layouts in `$XDG_CONFIG_HOME/xkb` is supported only on Wayland, and only with _non-ancient_ versions of libxkbcommon.  
Also, I'm not really sure about whether my config is done correctly, but it seems to be working. There's not much documentation online on integrating custom layouts in the user config folder, and even less regarding how to do it with custom types.

