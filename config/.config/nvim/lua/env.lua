local M = {}

function M.load_env()
	local env_file = vim.fn.stdpath("config") .. "/.env"
	local f = io.open(env_file, "r")
	local loaded_vars = {}

	if f then
		for line in f:lines() do
			local key, value = line:match("^([^=]+)=(.+)$")
			if key and value then
				-- Set environment variable
				vim.env[key] = value
				loaded_vars[key] = true
			end
		end
		f:close()
	else
		vim.notify("Warning: .env file not found at " .. env_file, vim.log.levels.WARN)
		return vim.env
	end

	-- Return the loaded environment with validation function
	return {
		env = vim.env,
		validate = function(required_keys)
			local missing = {}
			for _, key in ipairs(required_keys) do
				if not loaded_vars[key] or vim.env[key] == "" then
					table.insert(missing, key)
				end
			end

			if #missing > 0 then
				vim.notify(
					"Missing required environment variables: " .. table.concat(missing, ", "),
					vim.log.levels.ERROR
				)
				return false
			end
			return true
		end,
	}
end

return M
