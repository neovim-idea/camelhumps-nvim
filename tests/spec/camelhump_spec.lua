local l = require("camelhumps.logic")

local function char_under_cursor()
  local _, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  return line:sub(col + 1, col + 1)
end

describe("Logic sanity check", function()
  local buf

  before_each(function()
    vim.cmd("enew!")
    buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      "  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {",
      "    for {",
      "      a <----- myWonderfulConfigClass.doSomethingCool     (    withIt,      but { beeeee VeryCareful } )",
      "      _ = otherwiseBadThings.couldBe[ HappeningWihtTypes ] ( butIhopeNotTough )",
      "      _ <- I_DUNNO_WHAT_IM_DOING_IN_HERE",
      "    } yield new Something { override def foo: unit = ??? } test??",
      "  }",
    })

    vim.cmd("startinsert")
  end)

  it("repeatedly left_jump() should stop on the expected characters", function()
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { 1, (vim.str_utfindex(line)) })
    local expected_stops = " ]BS[O:Bs,S:f CCWMccf   "
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(start, "")
    expected_stops:foldLeft({}, function(ch, _)
      l.left_camel_hump()
      assert.are.equal(char_under_cursor(), ch)
    end)
  end)
end)
