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
  local buf

  local test_01_expected_stops = " ]BS[O:Bs,S:f CCWMccf   "
  -- build the other tests as an extension of  the jump from the previous (upper) line;
  local test_02_expected_stops = " f" .. test_01_expected_stops
  local test_03_expected_stops = "  CVb b,Iw CSd.CCWm< " .. test_02_expected_stops
  local test_04_expected_stops = " TNIb  TWH[Bc.TBo  " .. test_03_expected_stops
  local test_05_expected_stops = "H_I_D_I_W_D_ < " .. test_04_expected_stops
  local test_06_expected_stops = "?t ? u:fdo Sny " .. test_05_expected_stops

  before_each(function()
    vim.cmd("enew!")
    buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.cmd("startinsert")
  end)

  it("[line 1] repeatedly left_jump() should stop on the expected characters", function()
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { 1, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[1], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    test_01_expected_stops:foldLeft({}, function(ch, _)
      l.left_camel_hump()
      assert.are.equal(char_under_cursor(), ch)
    end)
  end)

  it("[line 2] repeatedly left_jump() should stop on the expected characters", function()
    local line_under_test = 2
    vim.api.nvim_win_set_cursor(0, { line_under_test, 0 })
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { line_under_test, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[line_under_test], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    test_02_expected_stops:foldLeft(nil, function(ch, acc)
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

  it("[line 3] repeatedly left_jump() should stop on the expected characters", function()
    local line_under_test = 3
    vim.api.nvim_win_set_cursor(0, { line_under_test, 0 })
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { line_under_test, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[line_under_test], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    test_03_expected_stops:foldLeft(nil, function(ch, acc)
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

  it("[line 4] repeatedly left_jump() should stop on the expected characters", function()
    local line_under_test = 4
    vim.api.nvim_win_set_cursor(0, { line_under_test, 0 })
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { line_under_test, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[line_under_test], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    test_04_expected_stops:foldLeft(nil, function(ch, acc)
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

  it("[line 5] repeatedly left_jump() should stop on the expected characters", function()
    local line_under_test = 5
    vim.api.nvim_win_set_cursor(0, { line_under_test, 0 })
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { line_under_test, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[line_under_test], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    test_05_expected_stops:foldLeft(nil, function(ch, acc)
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

  it("[line 6] repeatedly left_jump() should stop on the expected characters", function()
    local line_under_test = 6
    vim.api.nvim_win_set_cursor(0, { line_under_test, 0 })
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { line_under_test, (vim.str_utfindex(line)) })
    -- we are in INSERT mode, meaning the cursor will be positioned AFTER the last character.
    local start = char_under_cursor()

    assert.are.equal(line, lines[line_under_test], "sanity, to make sure we're starting from the expected line")
    assert.are.equal(start, "")
    local res = test_06_expected_stops:foldLeft(nil, function(ch, acc)
      l.left_camel_hump()
      local char = char_under_cursor()
      -- if we get an empty "", it means that we went up one line, with the cursor after the last character: therefore,
      -- we need to trigger an extra fictitious left-jump to align us back
      if char == "" then
        l.left_camel_hump()
        char = char_under_cursor()
      end
      return acc == nil and char or acc .. char
    end)
    assert.are.equal(res, test_06_expected_stops)
  end)
end)
