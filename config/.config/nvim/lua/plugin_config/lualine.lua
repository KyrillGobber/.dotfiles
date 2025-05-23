return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    event = "VeryLazy",
    config = function()
        local colors = {
            red = "#ca1243",
            grey = "#303030",
            black = "#383a42",
            white = "#f3f3f3",
            light_green = "#83a598",
            orange = "#fe8019",
            green = "#8ec07c",
            transparent = nil,
        }

        local theme = {
            normal = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.black, bg = colors.transparent },
                z = { fg = colors.white, bg = colors.black },
            },
            insert = { a = { fg = colors.black, bg = colors.light_green } },
            visual = { a = { fg = colors.black, bg = colors.orange } },
            replace = { a = { fg = colors.black, bg = colors.green } },
        }

        local empty = require("lualine.component"):extend()
        function empty:draw(default_highlight)
            self.status = ""
            self.applied_separator = ""
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end

        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < "x"
                for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.black } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= "table" then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = "" } or { left = "" }
                end
            end
            return sections
        end

        local function search_result()
            if vim.v.hlsearch == 0 then
                return ""
            end
            local last_search = vim.fn.getreg("/")
            if not last_search or last_search == "" then
                return ""
            end
            local searchcount = vim.fn.searchcount({ maxcount = 9999 })
            return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
        end

        local function modified()
            if vim.bo.modified then
                return "+"
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return "-"
            end
            return ""
        end

        -- Codecompanion
        local M = require("lualine.component"):extend()

        M.processing = false
        M.spinner_index = 1

        local spinner_symbols = {
            "⠋",
            "⠙",
            "⠹",
            "⠸",
            "⠼",
            "⠴",
            "⠦",
            "⠧",
            "⠇",
            "⠏",
        }
        local spinner_symbols_len = 10

        -- Initializer
        function M:init(options)
            M.super.init(self, options)

            local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "CodeCompanionRequest*",
                group = group,
                callback = function(request)
                    if request.match == "CodeCompanionRequestStarted" then
                        self.processing = true
                    elseif request.match == "CodeCompanionRequestFinished" then
                        self.processing = false
                    end
                end,
            })
        end

        -- Function that runs every time statusline is updated
        function M:update_status()
            if self.processing then
                self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
                return spinner_symbols[self.spinner_index]
            else
                return nil
            end
        end

        require("lualine").setup({
            options = {
                theme = theme,
                component_separators = "",
                section_separators = { left = " ", right = " " },
            },
            sections = process_sections({
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                    {
                        "diagnostics",
                        source = { "nvim" },
                        sections = { "error" },
                        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
                    },
                    {
                        "diagnostics",
                        source = { "nvim" },
                        sections = { "warn" },
                        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
                    },
                    { "filename", file_status = false,        path = 1 },
                    { modified,   color = { bg = colors.red } },
                    {
                        "%w",
                        cond = function()
                            return vim.wo.previewwindow
                        end,
                    },
                    {
                        "%r",
                        cond = function()
                            return vim.bo.readonly
                        end,
                    },
                    {
                        "%q",
                        cond = function()
                            return vim.bo.buftype == "quickfix"
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {M},
                lualine_y = { search_result, "filetype" },
                lualine_z = { "%l:%c", "%p%%/%L" },
            }),
            inactive_sections = {
                lualine_c = { "%f %y %m" },
                lualine_x = {},
            },
            tabline = {
                lualine_a = {
                    {
                        'buffers',
                        mode = 2,
                        max_length = vim.o.columns,
                        filetype_names = {
                            TelescopePrompt = 'Telescope',
                            dashboard = 'Dashboard',
                            packer = 'Packer',
                            fzf = 'FZF',
                            alpha = 'Alpha'
                        },
                        buffers_color = {
                            active = { fg = colors.white, bg = colors.light_green },
                            inactive = { fg = colors.white, bg = colors.grey },
                        },
                        use_mode_colors = false,
                        symbols = {
                            modified = ' ●',
                            alternate_file = '#',
                            directory = '',
                        },
                    }
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        })
    end
}
