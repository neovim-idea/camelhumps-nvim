local l = require("camelhumps.logic")

describe("Logic", function()
  describe("jump_left", function()
    it("should return `(0, -1)` in case the line is nil", function()
      assert.are.same(l.jump_left(nil), { cursor_col = 0, cursor_line = -1 })
    end)

    it("should return `(0, -1)` in case the line is empty", function()
      assert.are.same(l.jump_left(""), { cursor_col = 0, cursor_line = -1 }) -- TODO: in case we jump line, cursor_col should be nil
    end)

    it("should return `(0, -1)` in case the line has only blank characters", function()
      assert.are.same(l.jump_left("     "), { cursor_col = 0, cursor_line = -1 })
    end)

    it("should return `(0, 0)` for input string 'abcdef   '", function()
      assert.are.same(l.jump_left("abcdef   "), { cursor_col = 1, cursor_line = 0 })
    end)

    it("should return `(7, 0)` for input string 'abcdefGhi   '", function()
      assert.are.same(l.jump_left("abcdefGhi   "), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(7, 0)` for input string 'abcdEFGhi   '", function()
      assert.are.same(l.jump_left("abcdEFGhi   "), { cursor_col = 5, cursor_line = 0 })
    end)

    it("should return `(7, 0)` for input string 'abcdefGhi'", function()
      assert.are.same(l.jump_left("abcdefGhi"), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(5, 0)` for input string 'abcdEFGhi'", function()
      assert.are.same(l.jump_left("abcdEFGhi"), { cursor_col = 5, cursor_line = 0 }) -- NOTE: check different behavior from IJ
    end)

    it("should return `(0, 0)` for input string 'ABCDEFGhi'", function()
      assert.are.same(l.jump_left("ABCDEFGhi"), { cursor_col = 1, cursor_line = 0 }) -- NOTE: check different behavior from IJ
    end)

    it("should return `(17, 0)` for input string 'Option[SomeBaz]) {'", function()
      assert.are.same(l.jump_left("Option[SomeBaz]) {"), { cursor_col = 17, cursor_line = 0 })
    end)

    it("should return `(15, 0)` for input string 'Option[SomeBaz]) '", function()
      assert.are.same(l.jump_left("Option[SomeBaz]) "), { cursor_col = 15, cursor_line = 0 })
    end)

    it("should return `(12, 0)` for input string 'Option[SomeBaz'", function()
      assert.are.same(l.jump_left("Option[SomeBaz"), { cursor_col = 12, cursor_line = 0 })
    end)
  end)

  describe("jump_right", function()
    it("should return `(0, 1)` in case the line is nil", function()
      assert.are.same(l.jump_right(nil), { cursor_col = 0, cursor_line = 1 })
    end)

    it("should return `(0, 1)` in case the line is empty", function()
      assert.are.same(l.jump_right(""), { cursor_col = 0, cursor_line = 1 }) -- TODO: in case we jump line, cursor_col should be nil
    end)

    it("should return `(0, 1)` in case the line has only blank characters", function()
      assert.are.same(l.jump_right("     "), { cursor_col = 0, cursor_line = 1 })
    end)

    it("should return `(7, 0)` for input string 'abcdef   '", function()
      assert.are.same(l.jump_right("abcdef   "), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(7, 0)` for input string 'abcdefGhi   '", function()
      assert.are.same(l.jump_right("abcdefGhi   "), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(5, 0)` for input string 'abcdEFGhi   '", function()
      assert.are.same(l.jump_right("abcdEFGhi   "), { cursor_col = 5, cursor_line = 0 })
    end)

    it("should return `(7, 0)` for input string 'abcdefGhi'", function()
      assert.are.same(l.jump_right("abcdefGhi"), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(5, 0)` for input string 'abcdEFGhi'", function()
      assert.are.same(l.jump_right("abcdEFGhi"), { cursor_col = 5, cursor_line = 0 }) -- NOTE: check different behavior from IJ
    end)

    it("should return `(8, 0)` for input string 'ABCDEFGhi'", function()
      assert.are.same(l.jump_right("ABCDEFGhi"), { cursor_col = 8, cursor_line = 0 }) -- NOTE: check different behavior from IJ
    end)

    it("should return `(7, 0)` for input string 'Option[SomeBaz]) {'", function()
      assert.are.same(l.jump_right("Option[SomeBaz]) {"), { cursor_col = 7, cursor_line = 0 })
    end)

    it("should return `(2, 0)` for input string '[SomeBaz])'", function()
      assert.are.same(l.jump_right("[SomeBaz]) "), { cursor_col = 2, cursor_line = 0 })
    end)

    it("should return `(5, 0)` for input string 'SomeBaz])'", function()
      assert.are.same(l.jump_right("SomeBaz])"), { cursor_col = 5, cursor_line = 0 })
    end)
  end)
end)
