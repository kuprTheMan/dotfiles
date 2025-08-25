local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
  s("ctxb", t "ctx := context.Background()"),
  s(
    "ctxb",
    t [[
        ctx, cancel := context.WithCancel(context.Background())
        cancel()
    ]]
  ),
  s(
    "erif",
    fmt(
      [[
        if err != nil {{
            return {}
        }}
        ]],
      {
        i(0, "err"),
      }
    )
  ),
}
