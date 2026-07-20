-- Neovim Keybindings Cheatsheet Picker
-- Opens a searchable keybinding reference menu using Snacks.picker
-- Keybinding: <leader>K
-- Format: [Mode] [Category] keys → description

return {
  -- Register the keybinding and which-key label
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>K", desc = "Keybindings Cheatsheet", icon = "⌨" },
      },
    },
  },

  -- The actual cheatsheet picker using Snacks
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>K",
        function()
          -- Load the cheatsheet data
          local ok, cheatsheet = pcall(require, "config.keybindings-cheatsheet")
          if not ok then
            vim.notify("Keybindings cheatsheet not found!", vim.log.levels.ERROR)
            return
          end

          local items = {}
          for i, entry in ipairs(cheatsheet.keybindings) do
            -- Format: [Normal] [Navigation] gg → Go to first line
            local text = string.format(
              "[%-8s] [%-14s] %-30s → %s",
              entry.mode,
              entry.category,
              entry.keys,
              entry.desc
            )
            items[#items + 1] = {
              idx = i,
              text = text,
              -- Make all fields searchable
              mode = entry.mode,
              category = entry.category,
              keys = entry.keys,
              desc = entry.desc,
            }
          end

          Snacks.picker({
            title = "Neovim Keybindings",
            items = items,
            format = function(item, _ctx)
              local ret = {}
              -- Parse the formatted text to apply highlights
              local mode_color = ({
                Normal = "DiagnosticInfo",
                Insert = "DiagnosticOk",
                Visual = "DiagnosticWarn",
                Command = "DiagnosticHint",
                Operator = "DiagnosticError",
              })[item.mode] or "Comment"

              table.insert(ret, { "[" .. item.mode .. "]", mode_color })
              table.insert(ret, { " " })
              table.insert(ret, { "[" .. item.category .. "]", "Special" })
              table.insert(ret, { " " })
              table.insert(ret, { item.keys, "Title" })
              table.insert(ret, { " → ", "Comment" })
              table.insert(ret, { item.desc })
              return ret
            end,
            layout = {
              preset = "select",
              layout = {
                width = 0.7,
                height = 0.6,
              },
            },
            -- Display only - no action on confirm
            confirm = function() end,
          })
        end,
        desc = "Keybindings Cheatsheet",
      },
    },
  },
}
