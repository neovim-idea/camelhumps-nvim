local u = require("camelhumps.utils")

describe("Utils", function()
  describe("rightmost_word(line) should return the correct word, when:", function()
    it("line = '  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx =
        u.rightmost_word("  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "{", 85 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) '", function()
      local res, idx =
        u.rightmost_word("  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) ")
      assert.are.same({ res, idx }, { "Option[SomeBaz])", 68 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  ( foo: String, someBar: '", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass  ( foo: String, someBar: ")
      assert.are.same({ res, idx }, { "someBar:", 59 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  ( foo: String, '", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass  ( foo: String, ")
      assert.are.same({ res, idx }, { "String,", 51 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  ( foo: '", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass  ( foo: ")
      assert.are.same({ res, idx }, { "foo:", 46 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  ( '", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass  ( ")
      assert.are.same({ res, idx }, { "(", 44 })
    end)

    it("line = '  final case class MyWonderfulConfigClass  '", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass  ")
      assert.are.same({ res, idx }, { "MyWonderfulConfigClass", 20 })
    end)

    it("line = '  final case class MyWonderfulConfigClass'", function()
      local res, idx = u.rightmost_word("  final case class MyWonderfulConfigClass")
      assert.are.same({ res, idx }, { "MyWonderfulConfigClass", 20 })
    end)

    it("line = '  final case class '", function()
      local res, idx = u.rightmost_word("  final case class ")
      assert.are.same({ res, idx }, { "class", 14 })
    end)

    it("line = '      _ <- I_DUNNO_WHAT_IM_DOING_IN_HERE'", function()
      local res, idx = u.rightmost_word("      _ <- I_DUNNO_WHAT_IM_DOING_IN_HERE")
      assert.are.same({ res, idx }, { "I_DUNNO_WHAT_IM_DOING_IN_HERE", 12 })
    end)
  end)

  describe("leftmost_word(line) should return the correct word, when:", function()
    it("line = '  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx =
        u.leftmost_word("  final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "final", 3 })
    end)

    it("line = 'final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx =
        u.leftmost_word("final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "final", 1 })
    end)

    it("line = ' case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx =
        u.leftmost_word(" case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "case", 2 })
    end)

    it("line = 'case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx =
        u.leftmost_word("case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "case", 1 })
    end)

    it("line = ' class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "class", 2 })
    end)

    it("line = 'class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "class", 1 })
    end)

    it("line = ' MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "MyWonderfulConfigClass", 2 })
    end)

    it("line = 'MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "MyWonderfulConfigClass", 1 })
    end)

    it("line = '  ( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("  ( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "(", 3 })
    end)

    it("line = '( foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("( foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "(", 1 })
    end)

    it("line = ' foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "foo:", 2 })
    end)

    it("line = 'foo: String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("foo: String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "foo:", 1 })
    end)

    it("line = ' String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "String,", 2 })
    end)

    it("line = 'String, someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("String, someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "String,", 1 })
    end)

    it("line = ' someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "someBar:", 2 })
    end)

    it("line = 'someBar: Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("someBar: Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "someBar:", 1 })
    end)

    it("line = ' Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word(" Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "Option[SomeBaz])", 2 })
    end)

    it("line = 'Option[SomeBaz]) {  '", function()
      local res, idx = u.leftmost_word("Option[SomeBaz]) {  ")
      assert.are.same({ res, idx }, { "Option[SomeBaz])", 1 })
    end)

    it("line = '{  '", function()
      local res, idx = u.leftmost_word("{  ")
      assert.are.same({ res, idx }, { "{", 1 })
    end)

    it("line = '  '", function()
      local res, idx = u.leftmost_word("  ")
      assert.are.same({ res, idx }, {})
    end)
  end)

  describe("last_token(word) should return the correct, last token identified, when", function()
    it("word = 'Option[SomeBaz])'", function()
      local res = u.last_token("Option[SomeBaz])")
      assert.are.equal(res, "])")
    end)

    it("word = 'Option[SomeBaz'", function()
      local res = u.last_token("Option[SomeBaz")
      assert.are.equal(res, "SomeBaz")
    end)

    it("word = 'Option['", function()
      local res = u.last_token("Option[")
      assert.are.equal(res, "[")
    end)

    it("word = 'Option['", function()
      local res = u.last_token("Option")
      assert.are.equal(res, "Option")
    end)

    it("word = 'Option['", function()
      local res = u.last_token("Option")
      assert.are.equal(res, "Option")
    end)

    it("word = 'someBar:'", function()
      local res = u.last_token("someBar:")
      assert.are.equal(res, ":")
    end)

    it("word = 'someBar'", function()
      local res = u.last_token("someBar")
      assert.are.equal(res, "someBar")
    end)

    it("word = 'String'", function()
      local res = u.last_token("String")
      assert.are.equal(res, "String")
    end)

    it("word = 'foo:'", function()
      local res = u.last_token("foo:")
      assert.are.equal(res, ":")
    end)

    it("word = 'foo'", function()
      local res = u.last_token("foo")
      assert.are.equal(res, "foo")
    end)

    it("word = 'MyWonderfulConfigClass'", function()
      local res = u.last_token("MyWonderfulConfigClass")
      assert.are.equal(res, "MyWonderfulConfigClass")
    end)

    it("word = 'myWonderfulConfigClass.doSomethingCool'", function()
      local res = u.last_token("myWonderfulConfigClass.doSomethingCool")
      assert.are.equal(res, "doSomethingCool")
    end)

    it("word = 'I_DUNNO_WHAT_IM_DOING_IN_HERE'", function()
      local res = u.last_token("I_DUNNO_WHAT_IM_DOING_IN_HERE")
      assert.are.equal(res, "HERE")
    end)

    it("word = '<-'", function()
      local res = u.last_token("<-")
      assert.are.equal(res, "<-")
    end)
  end)

  describe("first_token(word) should return the correct, last token identified, when", function()
    it("word = 'Option[SomeBaz])'", function()
      local res = u.first_token("Option[SomeBaz])")
      assert.are.equal(res, "Option")
    end)

    it("word = '[SomeBaz])'", function()
      local res = u.first_token("[SomeBaz])")
      assert.are.equal(res, "[")
    end)

    it("word = 'SomeBaz])'", function()
      local res = u.first_token("SomeBaz])")
      assert.are.equal(res, "SomeBaz")
    end)

    it("word = '])'", function()
      local res = u.first_token("])")
      assert.are.equal(res, "])")
    end)

    it("word = 'myWonderfulConfigClass.doSomethingCool'", function()
      local res = u.first_token("myWonderfulConfigClass.doSomethingCool")
      assert.are.equal(res, "myWonderfulConfigClass")
    end)

    it("word = 'I_DUNNO_WHAT_IM_DOING_IN_HERE'", function()
      local res = u.first_token("I_DUNNO_WHAT_IM_DOING_IN_HERE")
      assert.are.equal(res, "I")
    end)

    it("word = '<-'", function()
      local res = u.first_token("<-")
      assert.are.equal(res, "<-")
    end)
  end)
end)
