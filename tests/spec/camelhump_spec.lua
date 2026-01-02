local l = require("camelhumps.logic")

local function char_under_cursor()
  local _, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  return line:sub(col + 1, col + 1)
end

describe("Logic sanity check:", function()
  local lines = {
    "  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {",
    "    for {",
    "      a <----- myWonderfulConfigClass.doSomethingCool     (    withIt,      but { beeeee VeryCareful } )",
    "      _ = otherwiseBadThings.couldBe[ HappeningWihtTypes ] ( butIhopeNotTough )",
    "      _ <- I_DUNNO_WHAT_IM_DOING_IN_HERE",
    "    } yield new Something { override def foo: unit = ??? } test??",
    "  }",
  }

  local test_01_expected_stops = " ]BS[O:Bs,S:f CCWMccf   "
  -- build the other tests as an extension of the jump from the previous (upper) line; while it's not strictly
  -- necessary, it is still useful for making sure that moving upwards will still place the cursor at the right place,
  -- thus making sure that the other jump will still work as expected
  local test_02_expected_stops = " f" .. test_01_expected_stops
  local test_03_expected_stops = "  CVb b,Iw CSd.CCWm< " .. test_02_expected_stops
  local test_04_expected_stops = " TNIb  TWH[Bc.TBo  " .. test_03_expected_stops
  local test_05_expected_stops = "H_I_D_I_W_D_ < " .. test_04_expected_stops
  local test_06_expected_stops = "?t ? u:fdo Sny " .. test_05_expected_stops

  before_each(function()
    vim.cmd("enew!")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.cmd("startinsert")
  end)

  local function test_line_jump(line_nr, expected_stops)
    it("[line " .. line_nr .. "] repeatedly left_jump() should stop on the expected characters", function()
      vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
      local line = vim.api.nvim_get_current_line()
      vim.api.nvim_win_set_cursor(0, { line_nr, (vim.str_utfindex(line)) })
      -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
      local start = char_under_cursor()

      assert.are.equal(line, lines[line_nr], "sanity, to make sure we're starting from the expected line")
      assert.are.equal(start, "")
      expected_stops:foldLeft("", function(ch, _)
        l.left_camel_hump()
        local char = char_under_cursor()
        -- if we get an empty "", it means that we went up one line, with the cursor after the last character: therefore,
        -- we need to trigger an extra fictitious left-jump to align us back
        if char == "" then
          l.left_camel_hump()
          char = char_under_cursor()
        end
        assert.are.equal(char, ch)
      end)
    end)
  end

  test_line_jump(1, test_01_expected_stops)
  test_line_jump(2, test_02_expected_stops)
  test_line_jump(3, test_03_expected_stops)
  test_line_jump(4, test_04_expected_stops)
  test_line_jump(5, test_05_expected_stops)
  test_line_jump(6, test_06_expected_stops)
end)
