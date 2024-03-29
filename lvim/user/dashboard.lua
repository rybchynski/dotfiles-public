--
-- Dashboard configuration file
--

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.header.val = {
  [[                  Welcome back to the dark side of the moon!                  ]],
}

local text = require "lvim.interface.text"
lvim.builtin.alpha.dashboard.section.footer.val = text.align_center({ width = 0 }, {
  "",
  "",
  "",
  "",
  "Talk is cheap. Show me the code! - Linus Torvalds",
}, 0.5)
