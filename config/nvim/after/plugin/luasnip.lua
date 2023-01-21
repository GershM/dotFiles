local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


ls.add_snippets("php", {
    s("<?", fmt("<?php\n", {})),
    s("func", fmt("function {}({} ${}) {{\n{}\n}}", { i(1, "func_name"), i(2, "type"), i(3, "value"), i(0) })),
    s("if", fmt("if({}) {{\n{}\n}}", { i(1, "condition"), i(0) })),
    s("for", fmt("for(${} = 0; ${} < ${}; ${}++) {{\n{}\n}}", { i(1, "i"), rep(1), i(2, "data"), rep(1), i(0) })),
    s("class", fmt("class {} {{\n{}}}", { i(1, "name"), i(0) })),
    s("__const", fmt("function __construct({}) {{\n {} \n }}", { i(1, "args"), i(0) })),
    s("req", fmt("require __DIR__ . \"\\{}\"; ", { i(1, "path")})),
    s("grp", fmt("$this->group('{}', function () {{\n{}\n }}", { i(1, "path"), i(0) })),
    s("route",
        fmt("$this->{}('{}', function (Request $req, Response $res): Response {{\n return {}($req, $res);\n}});",
            { i(1, "get"), i(2, "path"), i(3, "func") })),
    s("rfunc",
        fmt("function {}(Request $req, Response $res):Response {{\n{}\n return $res->withJson(${}); \n}}",
            { i(1, "func_name"), i(0), i(2, "Response") }))
})

ls.add_snippets("javascript", {
    s("func", fmt("{}({}) {{\n{}\n}}", { i(1, "func_name"), i(2, "value"), i(0) })),
    s("if", fmt("if({}) {{\n{}\n}}", { i(1, "condition"), i(0) })),
    s("for", fmt("for(let {}=0; {} < {}; {}++) {{\n{}\n}}", { i(1, "i"), rep(1), i(2, "data"), rep(1), i(0) })),
})
