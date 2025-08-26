_G.codecompanion_adapters = {}

function _G.toggle_venice_web_search()
    if not _G.codecompanion_adapters or not _G.codecompanion_adapters.venice then
        vim.notify("Venice adapter not initialized or stored", vim.log.levels.ERROR)
        return
    end

    local adapter = _G.codecompanion_adapters.venice
    local params = adapter.schema.venice_parameters.default
    params.enable_web_search = (params.enable_web_search == 'on') and 'off' or 'on'

    vim.notify("Venice web search: " .. params.enable_web_search, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ToggleVeniceWebSearch", function()
    _G.toggle_venice_web_search()
end, {})

function _G.toggle_venice_reasoning()
    if not _G.codecompanion_adapters or not _G.codecompanion_adapters.venice then
        vim.notify("Venice adapter not initialized or stored", vim.log.levels.ERROR)
        return
    end

    local adapter = _G.codecompanion_adapters.venice
    local params = adapter.schema.venice_parameters.default
    params.disable_thinking = (params.disable_thinking == true) and false or true

    vim.notify("Venice reasoning: " .. params.disable_thinking, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ToggleVeniceReasoning", function()
    _G.toggle_venice_reasoning()
end, {})

return {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        display = {
            chat = {
                intro_message = "Sup bruv",
                show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
                separator = "─", -- The separator between the different messages in the chat buffer
                show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
                show_settings = false, -- Show LLM settings at the top of the chat buffer?
                show_token_count = true, -- Show the token count for each response?
                start_in_insert_mode = false, -- Open the chat buffer in insert mode?
            },
        },
        adapters = {
            Venice = function()
                local env_loader = require('env').load_env()
                if env_loader.validate({ "VENICE_API_KEY" }) then
                    local adapter = require("codecompanion.adapters").extend("openai_compatible", {
                        name = "venice",
                        formatted_name = "Venice",
                        roles = {
                            llm = "assistant",
                            user = "user",
                        },
                        opts = {
                            stream = true,
                        },
                        features = {
                            text = true,
                            tokens = true,
                            vision = false,
                        },
                        env = {
                            url = "https://api.venice.ai/api",
                            chat_url = "/v1/chat/completions",
                            api_key = env_loader.env.VENICE_API_KEY,
                        },
                        schema = {
                            model = {
                                default = "qwen3-235b",
                                -- Other models available:
                                --   llama-3.1-405b
                                --   llama-3.2-3b
                                --   llama-3.3-70b
                                --   dolphin-2.9.2-qwen2-72b
                                --   deepseek-r1-llama-70b
                                --   deepseek-r1-671b
                                --   qwen2.5-coder-32b
                                --   qwen-2.5-vl
                            },
                            temperature = {
                                order = 2,
                                mapping = "parameters",
                                type = "number",
                                optional = true,
                                default = 0.8,
                                desc =
                                "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
                                validate = function(n)
                                    return n >= 0 and n <= 2, "Must be between 0 and 2"
                                end,
                            },
                            max_completion_tokens = {
                                order = 3,
                                mapping = "parameters",
                                type = "integer",
                                optional = true,
                                default = nil,
                                desc = "An upper bound for the number of tokens that can be generated for a completion.",
                                validate = function(n)
                                    return n > 0, "Must be greater than 0"
                                end,
                            },
                            presence_penalty = {
                                order = 4,
                                mapping = "parameters",
                                type = "number",
                                optional = true,
                                default = 0,
                                desc =
                                "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.",
                                validate = function(n)
                                    return n >= -2 and n <= 2, "Must be between -2 and 2"
                                end,
                            },
                            top_p = {
                                order = 5,
                                mapping = "parameters",
                                type = "number",
                                optional = true,
                                default = 0.9,
                                desc =
                                "A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. (Default: 0.9)",
                                validate = function(n)
                                    return n >= 0 and n <= 1, "Must be between 0 and 1"
                                end,
                            },
                            stop = {
                                order = 6,
                                mapping = "parameters",
                                type = "string",
                                optional = true,
                                default = nil,
                                desc =
                                "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
                                validate = function(s)
                                    return s:len() > 0, "Cannot be an empty string"
                                end,
                            },
                            frequency_penalty = {
                                order = 8,
                                mapping = "parameters",
                                type = "number",
                                optional = true,
                                default = 0,
                                desc =
                                "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.",
                                validate = function(n)
                                    return n >= -2 and n <= 2, "Must be between -2 and 2"
                                end,
                            },
                            venice_parameters = {
                                order = 9,
                                mapping = "parameters",
                                type = "object",
                                optional = true,
                                default = {
                                    disable_thinking = true,
                                    enable_web_search = 'off',
                                },
                                desc =
                                "Options to enable web search and disable think",
                            },
                            logit_bias = {
                                order = 10,
                                mapping = "parameters",
                                type = "map",
                                optional = true,
                                default = nil,
                                desc =
                                "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
                                subtype_key = {
                                    type = "integer",
                                },
                                subtype = {
                                    type = "integer",
                                    validate = function(n)
                                        return n >= -100 and n <= 100, "Must be between -100 and 100"
                                    end,
                                },
                            },
                        },
                    })
                    -- ✅ Store reference globally
                    _G.codecompanion_adapters.venice = adapter

                    return adapter
                else
                    vim.notify("Plugin setup failed: Missing API key", vim.log.levels.ERROR)
                end
            end,
        },

        -- Perplexity = function()
        --     local env_loader = require('env').load_env()
        --     if env_loader.validate({ "PERPLEXITY_API_KEY" }) then
        --         return require("codecompanion.adapters").extend("openai_compatible", {
        --             name = "perplexity",
        --             formatted_name = "Perplexity",
        --             roles = {
        --                 llm = "assistant",
        --                 user = "user",
        --             },
        --             opts = {
        --                 stream = true,
        --             },
        --             features = {
        --                 text = true,
        --                 tokens = true,
        --                 vision = false,
        --             },
        --             env = {
        --                 url = "https://api.perplexity.ai",
        --                 chat_url = "/chat/completions",
        --                 api_key = env_loader.env.PERPLEXITY_API_KEY,
        --             },
        --             schema = {
        --                 model = {
        --                     default = "sonar",
        --                     -- sonar
        --                     -- sonar-pro
        --                     -- sonar-reasoning
        --                     -- sonar-reasoning-pro
        --                     -- sonar-deep-research
        --                     -- r1-1776
        --                 },
        --                 temperature = {
        --                     order = 2,
        --                     mapping = "parameters",
        --                     type = "number",
        --                     optional = true,
        --                     default = 0.8,
        --                     desc =
        --                     "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
        --                     validate = function(n)
        --                         return n >= 0 and n <= 2, "Must be between 0 and 2"
        --                     end,
        --                 },
        --                 max_completion_tokens = {
        --                     order = 3,
        --                     mapping = "parameters",
        --                     type = "integer",
        --                     optional = true,
        --                     default = nil,
        --                     desc = "An upper bound for the number of tokens that can be generated for a completion.",
        --                     validate = function(n)
        --                         return n > 0, "Must be greater than 0"
        --                     end,
        --                 },
        --                 presence_penalty = {
        --                     order = 4,
        --                     mapping = "parameters",
        --                     type = "number",
        --                     optional = true,
        --                     default = 0,
        --                     desc =
        --                     "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.",
        --                     validate = function(n)
        --                         return n >= -2 and n <= 2, "Must be between -2 and 2"
        --                     end,
        --                 },
        --                 top_p = {
        --                     order = 5,
        --                     mapping = "parameters",
        --                     type = "number",
        --                     optional = true,
        --                     default = 0.9,
        --                     desc =
        --                     "A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. (Default: 0.9)",
        --                     validate = function(n)
        --                         return n >= 0 and n <= 1, "Must be between 0 and 1"
        --                     end,
        --                 },
        --                 stop = {
        --                     order = 6,
        --                     mapping = "parameters",
        --                     type = "string",
        --                     optional = true,
        --                     default = nil,
        --                     desc =
        --                     "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
        --                     validate = function(s)
        --                         return s:len() > 0, "Cannot be an empty string"
        --                     end,
        --                 },
        --                 frequency_penalty = {
        --                     order = 8,
        --                     mapping = "parameters",
        --                     type = "number",
        --                     optional = true,
        --                     default = 0,
        --                     desc =
        --                     "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.",
        --                     validate = function(n)
        --                         return n >= -2 and n <= 2, "Must be between -2 and 2"
        --                     end,
        --                 },
        --                 logit_bias = {
        --                     order = 9,
        --                     mapping = "parameters",
        --                     type = "map",
        --                     optional = true,
        --                     default = nil,
        --                     desc =
        --                     "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
        --                     subtype_key = {
        --                         type = "integer",
        --                     },
        --                     subtype = {
        --                         type = "integer",
        --                         validate = function(n)
        --                             return n >= -100 and n <= 100, "Must be between -100 and 100"
        --                         end,
        --                     },
        --                 },
        --             },
        --         })
        --     else
        --         vim.notify("Plugin setup failed: Missing API key", vim.log.levels.ERROR)
        --     end
        -- end,
        -- },
        strategies = {
            agent = { adapter = "copilot" },
            chat = { adapter = "copilot" },
            inline = { adapter = "copilot" },
        },
    },
}
