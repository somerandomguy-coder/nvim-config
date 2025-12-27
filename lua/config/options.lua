-- Save undo history to a file so it persists after closing nvim
local undodir = vim.fn.stdpath("data") .. "/undo"

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.undofile = true
