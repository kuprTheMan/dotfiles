local ls = require("luasnip")
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local f = ls.function_node
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

return {
	s(
		"for",
		fmt(
			[[
        for({} {} = {}; {} {}; {}++ ) {{
            {}
        }}
        ]],
			{
				i(1, "size_t"),
				i(2, "i"),
				i(3, "0"),
				rep(2, "i"),
				i(4, "<= some_item"),
				rep(2, "i"),
				i(0, ""),
			}
		)
	),
	s(
		"foreach",
		fmt(
			[[
      for({} : {}){{
        {}
      }}
      ]],
			{
				i(1, "auto var"),
				i(2, "some_collection"),
				i(0, ""),
			}
		)
	),
	s(
		"cls",
		fmt(
			[[
  class {} {{
    private:
      {}
    public:
      {}();
      {}({}{});
      ~{}();
      {}(const {}& other);
      {}& operator=(const {}& other);
      {}
  }};
  ]],
			{
				i(1, "className"),
				i(2),
				rep(1, "className"),
				rep(1, "className"),
				c(3, { t("const "), t("") }),
				i(4, "std::string& name"),
				rep(1, "className"),
				rep(1, "className"),
				rep(1, "className"),
				rep(1, "className"),
				rep(1, "className"),
				i(5),
			}
		)
	),
	s(
		"ttype",
		fmt(
			[[
      template <typename {}>
      ]],
			{
				i(1, "Name"),
			}
		)
	),
	treesitter_postfix({
		trig = ".mv",
		matchTSNode = {
			query = [[
            [
              (call_expression)
              (identifier)
              (template_function)
              (subscript_expression)
              (field_expression)
              (user_defined_literal)
            ] @prefix
        ]],
			query_lang = "cpp",
		},
	}, {
		f(function(_, parent)
			local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
			local replaced_content = ("std::move(%s)"):format(node_content)
			return vim.split(replaced_content, "\n", { trimempty = false })
		end),
	}),
}
