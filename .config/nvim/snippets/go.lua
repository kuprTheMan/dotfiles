local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

return {
	s(
		"trun",
		fmt(
			[[
        t.Run("{}", func(t *testing.T) {{
            {}
        }})
        ]],
			{
				i(1, "test case"),
				i(0, ""),
			}
		)
	),
}
