vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo)"} )

vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackAdd user/repo)"} )

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if opts.args:match("%S") then
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
        vim.pack.update(plugins)
    else
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

vim.api.nvim_create_user_command("BlinkBuild", function()
    local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
    local sysname = (vim.uv.os_uname() or {}).sysname or ""
    local lib_ext = sysname == "Darwin" and "dylib" or (sysname == "Windows_NT" and "dll" or "so")
    local src = pack_dir .. "/target/release/libblink_cmp_fuzzy." .. lib_ext
    local lib_dir = pack_dir .. "/lib"

    vim.notify("Building blink.cmp...", vim.log.levels.INFO)
    vim.system(
        { "cargo", "build", "--release" },
        { cwd = pack_dir, text = true },
        function(out)
            if out.code ~= 0 then
                vim.schedule(function()
                    vim.notify("blink.cmp build failed:\n" .. (out.stderr or ""), vim.log.levels.ERROR)
                end)
                return
            end

            vim.uv.fs_mkdir(lib_dir, 493)

            -- get commit hash for versioned copy
            local hash_out = vim.system({ "git", "rev-parse", "HEAD" }, { cwd = pack_dir }):wait()
            local commit = (hash_out.stdout or ""):match("^(%x+)")
            local short = commit and commit:sub(1, 7) or nil

            local dst = lib_dir .. "/libblink_cmp_fuzzy." .. lib_ext
            vim.uv.fs_copyfile(src, dst)
            if short then
                vim.uv.fs_copyfile(src, dst .. "." .. short)
            end

            vim.schedule(function()
                vim.notify("blink.cmp built successfully", vim.log.levels.INFO)
            end)
        end
    )
end, { desc = "Build blink.cmp native library from source" })

vim.api.nvim_create_user_command("FormatToggle", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"), vim.log.levels.INFO)
end, { desc = "Toggle format-on-save globally" })
