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
    local start = char_under_cursor()

    l.left_camel_hump()
    local jump_01 = char_under_cursor()
    l.left_camel_hump()
    local jump_02 = char_under_cursor()
    l.left_camel_hump()
    local jump_03 = char_under_cursor()
    l.left_camel_hump()
    local jump_04 = char_under_cursor()
    l.left_camel_hump()
    local jump_05 = char_under_cursor()
    l.left_camel_hump()
    local jump_06 = char_under_cursor()
    l.left_camel_hump()
    local jump_07 = char_under_cursor()
    l.left_camel_hump()
    local jump_08 = char_under_cursor()
    l.left_camel_hump()
    local jump_09 = char_under_cursor()
    l.left_camel_hump()
    local jump_10 = char_under_cursor()
    l.left_camel_hump()
    local jump_11 = char_under_cursor()
    l.left_camel_hump()
    local jump_12 = char_under_cursor()
    l.left_camel_hump()
    local jump_13 = char_under_cursor()
    l.left_camel_hump()
    local jump_14 = char_under_cursor()
    l.left_camel_hump()
    local jump_15 = char_under_cursor()
    l.left_camel_hump()
    local jump_16 = char_under_cursor()
    l.left_camel_hump()
    local jump_17 = char_under_cursor()
    l.left_camel_hump()
    local jump_18 = char_under_cursor()
    l.left_camel_hump()
    local jump_19 = char_under_cursor()
    l.left_camel_hump()
    local jump_20 = char_under_cursor()
    l.left_camel_hump()
    local jump_21 = char_under_cursor()
    l.left_camel_hump()
    local jump_22 = char_under_cursor()
    -- these remaining ones are just to demostrate that we can't back anymore, if we're already at the beginning of the
    -- very first line; therefore, no matter how many times we try to jump left, we will stay in the same place
    l.left_camel_hump()
    local jump_23 = char_under_cursor()
    l.left_camel_hump()
    local jump_24 = char_under_cursor()

    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character
    assert.are.equal(start, "")
    -- check all jumps are going to the expected character
    assert.are.equal(jump_01, " ")
    assert.are.equal(jump_02, "]")
    assert.are.equal(jump_03, "B")
    assert.are.equal(jump_04, "S")
    assert.are.equal(jump_05, "[")
    assert.are.equal(jump_06, "O")
    assert.are.equal(jump_07, ":")
    assert.are.equal(jump_08, "B")
    assert.are.equal(jump_09, "s")
    assert.are.equal(jump_10, ",")
    assert.are.equal(jump_11, "S")
    assert.are.equal(jump_12, ":")
    assert.are.equal(jump_13, "f")
    assert.are.equal(jump_14, " ")
    assert.are.equal(jump_15, "C")
    assert.are.equal(jump_16, "C")
    assert.are.equal(jump_17, "W")
    assert.are.equal(jump_18, "M")
    assert.are.equal(jump_19, "c")
    assert.are.equal(jump_20, "c")
    assert.are.equal(jump_21, "f")
    assert.are.equal(jump_22, " ")
    assert.are.equal(jump_23, " ")
    assert.are.equal(jump_24, " ")
  end)
end)
