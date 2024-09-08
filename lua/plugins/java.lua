return {
  {
    "mfussenegger/nvim-jdtls",
    ft = {"java"},
    lazy = false,
    config = function()
      local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
      local home = os.getenv("HOME")
      local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
      local lombok_path = home .. "/Downloads/lombok.jar"
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local ws_folders_jdtls = {}
      if root_dir then
        local file = io.open(root_dir .. "/.bemol/ws_root_folders")
        if file then
          for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
          end
          file:close()
        end
      end

      local config = {
        -- cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xms1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-javaagent:' .. lombok_path,
          '-jar', vim.fn.glob(mason_path .. '/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration', mason_path .. '/packages/jdtls/config_mac',
          '-data', eclipse_workspace,
        },
        root_dir = root_dir,
        init_options = {
          workspaceFolders = ws_folders_jdtls,
        },
        settings = {
          java = {
            configuration = {
              runtimes = {
                -- Add other Java versions if needed
                {
                  name = "JavaSE-21",
                  path = "/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home",
                },
                {
                  name = "JavaSE-11",
                  path = "/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home",
                },
              },
            },
          },
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname:match("%.java$") then
            print("Attaching JDTLS to Java file: " .. bufnr)
            local current_buffer = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = current_buffer })
            local jdtls_client = vim.tbl_filter(function(client)
              return client.name == "jdtls"
            end, clients)[1]

            if not jdtls_client then
              require('jdtls').start_or_attach(config)
            -- else
            --   print("JDTLS is already attached java lua")
            end
          end
        end,
      })
      -- -- print("JDTLS setup complete")
      local current_buffer = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = current_buffer })
      local jdtls_client = vim.tbl_filter(function(client)
        return client.name == "jdtls"
      end, clients)[1]

      if not jdtls_client then
        require('jdtls').start_or_attach(config)
      -- else
      --   print("JDTLS is already attached")
      end
    end,
    -- config.on_attach = function(client, bufnr)
    --   print("JDTLS attached to buffer: " .. bufnr)
    -- end,
  }
}
