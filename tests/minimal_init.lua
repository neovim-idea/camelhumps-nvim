vim.cmd("set rtp^=.")
-- vim.cmd("set rtp+=./tests") -- optional, if you keep helpers here
vim.o.swapfile = false
vim.o.shadafile = "NONE"
vim.opt.rtp:prepend(vim.fn.getcwd())
