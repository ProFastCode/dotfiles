return {
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      local present, alpha = pcall(require, "alpha")
      if not present then
        return
      end

      local dashboard = require("alpha.themes.dashboard")
      local if_nil = vim.F.if_nil

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Header                                                   │
      -- ╰──────────────────────────────────────────────────────────╯

      local header = {
        "███████╗ █████╗ ███████╗████████╗     ██████╗ ██████╗ ██████╗ ███████╗",
        "██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝",
        "█████╗  ███████║███████╗   ██║       ██║     ██║   ██║██║  ██║█████╗  ",
        "██╔══╝  ██╔══██║╚════██║   ██║       ██║     ██║   ██║██║  ██║██╔══╝  ",
        "██║     ██║  ██║███████║   ██║       ╚██████╗╚██████╔╝██████╔╝███████╗",
        "╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝",
      }

      dashboard.section.header.type = "text"
      dashboard.section.header.val = header
      dashboard.section.header.opts = {
        position = "center",
        hl = "NeovimHeader",
      }

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Heading Info                                             │
      -- ╰──────────────────────────────────────────────────────────╯

      local thingy =
        io.popen('echo "$(LANG=en_us_88591; date +%a) $(date +%d) $(LANG=en_us_88591; date +%b)" | tr -d "\n"')
      if thingy == nil then
        return
      end
      local date = thingy:read("*a")
      thingy:close()

      local datetime = os.date(" %H:%M")

      local hi_top_section = {
        type = "text",
        val = "┌────────────   Today is "
          .. date
          .. " ────────────┐",
        opts = {
          position = "center",
          hl = "NeovimHeaderInfo",
        },
      }

      local hi_middle_section = {
        type = "text",
        val = "│                                                │",
        opts = {
          position = "center",
          hl = "NeovimHeaderInfo",
        },
      }

      local hi_bottom_section = {
        type = "text",
        val = "└───══───══───══───  "
          .. datetime
          .. "  ───══───══───══────┘",
        opts = {
          position = "center",
          hl = "NeovimHeaderInfo",
        },
      }

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Buttons                                                  │
      -- ╰──────────────────────────────────────────────────────────╯
      -- Copied from Alpha.nvim source code

      local leader = "SPC"

      --- @param sc string
      --- @param txt string
      --- @param keybind string optional
      --- @param keybind_opts table optional
      local function button(sc, txt, keybind, keybind_opts)
        local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

        local opts = {
          position = "center",
          shortcut = sc,
          cursor = 5,
          width = 50,
          align_shortcut = "right",
          hl_shortcut = "NeovimPrimary",
        }
        if keybind then
          keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
          opts.keymap = { "n", sc_, keybind, keybind_opts }
        end

        local function on_press()
          local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
          vim.api.nvim_feedkeys(key, "t", false)
        end

        return {
          type = "button",
          val = txt,
          on_press = on_press,
          opts = opts,
        }
      end

      dashboard.section.buttons.val = {
        button("r", "Recents", "<cmd>Telescope oldfiles hidden=true<CR>", {}),
        button("f", "Find File", "<cmd>Telescope find_files<CR>", {}),
        button("u", "Update Plugins", "<cmd>Lazy update<CR>", {}),
        button("m", "Manage Plugins", "<cmd>Lazy<CR>", {}),
        button("s", "Settings", "<cmd>e $MYVIMRC<CR>", {}),
        button("q", "Quit", "<cmd>exit<CR>", {}),
      }

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Footer                                                   │
      -- ╰──────────────────────────────────────────────────────────╯

      local function footer()
        return string.format("А вам куда?")
      end

      dashboard.section.footer.val = {
        footer(),
      }
      dashboard.section.footer.opts = {
        position = "center",
        hl = "Footer",
      }

      local section = {
        header = dashboard.section.header,
        hi_top_section = hi_top_section,
        hi_middle_section = hi_middle_section,
        hi_bottom_section = hi_bottom_section,
        buttons = dashboard.section.buttons,
        footer = dashboard.section.footer,
      }

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Setup                                                    │
      -- ╰──────────────────────────────────────────────────────────╯

      local opts = {
        layout = {
          { type = "padding", val = 8 },
          section.header,
          { type = "padding", val = 2 },
          section.hi_top_section,
          section.hi_middle_section,
          section.hi_bottom_section,
          { type = "padding", val = 2 },
          section.buttons,
          { type = "padding", val = 8 },
          section.footer,
        },
        opts = {
          margin = 5,
        },
      }

      alpha.setup(opts)

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ Hide tabline and statusline on startup screen            │
      -- ╰──────────────────────────────────────────────────────────╯
      vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        command = "set showtabline=0 laststatus=0 noruler",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        callback = function()
          vim.api.nvim_create_autocmd("BufUnload", {
            group = "alpha_tabline",
            buffer = 0,
            command = "set showtabline=2 ruler laststatus=3",
          })
        end,
      })
    end,
  },
}
