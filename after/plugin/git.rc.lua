local status, git = pcall(require, "git")
if (not status) then return end

git.setup({
  keymaps = {
    -- Open blame window
    blame = "<Leader>gb",
    -- Close blame window
    quit_blame = 'q',
    -- Open file/folder in git repository
    browse = "<Leader>go",
    -- Opens a new diff that compares against the current index
    diff = '<Leader>gd',
    -- Close diff
    diff_close = 'q'
  }
})
