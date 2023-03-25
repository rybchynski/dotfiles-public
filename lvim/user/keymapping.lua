-- custom keymappings:
lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.normal_mode["H"] = ":bprev<cr>"
lvim.keys.normal_mode["L"] = ":bnext<cr>"

-- spliting
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode['-'] = ":split<CR>"
