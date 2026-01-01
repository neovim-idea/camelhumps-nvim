local l = require("camelhumps.logic")

local function char_under_cursor()
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
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

  -- NOTE: 1-based, not 0-based !
  local function read_nth_line(line_nr)
    return vim.api.nvim_buf_get_lines(buf, line_nr - 1, line_nr, false)[1]
  end

  it("repeatedly left_jump() should stop on the expected characters", function()
    -- local line = read_nth_line(1)
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { 1, (vim.str_utfindex(line)) })
    local expected_stops = " ]BS[O:Bs,S:f CCWMccf   "
    -- first "jump" isn't actually a jump. We're just fetching the character at the END of the line where the cursor is.
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(start, "")
    expected_stops:foldLeft({}, function(ch, acc)
      l.left_camel_hump()
      assert.are.equal(char_under_cursor(), ch)
    end)
  end)
end)
