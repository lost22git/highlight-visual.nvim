
# highlight-visual.nvim

A neovim plugin to highlight selection on visual mode.

## Setup

- lua
```lua
{
  "lost22git/highlight-visual.nvim",
  lazy = false,
  opts = {}
}
```

- fennel
```fennel
{1 "lost22git/highlight-visual.nvim" :lazy false :opts {}}
```

## Default Configuration

```lua
{
  hl_group = "Visual",
  key = "<Leader>v"
}
```

## Demo

![demo](./demo.gif)
