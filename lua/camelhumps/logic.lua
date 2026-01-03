--[[
-- CONVENTIONS:
--  1. the string under test will be checked first in IntelliJ, to ensure the expcted outcome
--    a. when jumping to the left, the cursor in intellij must be placed after the last character of the string
--    b. when jumping to the right, the cursor in intellij must be placed before the first character of the string
--  2. we assume neovim to be in `insert` mode first
--  3. we assume that the `line` being fed to to these methods is properly trimmed, such as:
--    a. when jumping left, `line` will end at the cursor position (included)
--    b. when jumping right, `line` will start from the cursor position (included)
--  4. variations in behavior from IntelliJ are allowed, but must be documented properly in both tests and README
--]]

local Logic = {}

local u = require("camelhumps.utils")

local special_chars = "()[]{},.=~!?|&+-*:/<>@#_"

string.foldRight = function(the_string, zero, op)
  local should_break
  for i = #the_string, 1, -1 do
    zero, should_break = op(the_string:sub(i, i), zero)
    if should_break == true then
      break
    end
  end
  return zero
end

string.foldLeft = function(the_string, zero, op)
  local should_break
  for i = 1, #the_string, 1 do
    zero, should_break = op(the_string:sub(i, i), zero)
    if should_break == true then
      break
    end
  end
  return zero
end

local CharacterType = {
  LOWERCASE = 1,
  UPPERCASE = 2,
  WHITESPACE = 3,
  SPECIAL = 4,
}

local function char_type(ch)
  if special_chars:find(ch, 1, true) then
    return CharacterType.SPECIAL
  elseif ch:match("^%s$") ~= nil then
    return CharacterType.WHITESPACE
  elseif ch:match("%u") then
    return CharacterType.UPPERCASE
  else
    return CharacterType.LOWERCASE
  end
end

--[[ API DEFINITION ]]

--[[
-- Heuristic "jump left" implementation that, assuming `line` is the content of the line where the cursor is located,
-- starting from the beginning, up to the cursor (included):
--    1. first, it will get the rightmost word (sequence of alphanumerical and special characters)
--    2. then, it will tokenize the word based on adjacent alphanumerical or special characters, and return the last one
--    3. then, it will scan the token from last character to first, and try to find a pivot. A pivot is a charater whose
--        type is different from the initial (= last). If there's a pivot, that's where we want to land; otherwise, just
--        land at the beginning of the token itself
--]]
function Logic.jump_left(line)
  if line == nil or line:match("^%s*$") then
    return { cursor_col = 0, cursor_line = -1 }
  end

  local word, pos = u.rightmost_word(line)
  if word ~= nil and #word == 1 then
    -- well, this is just equivalent of moving left by one with either <Left> or <h>, but:
    --    1. hey, IJ does it too
    --    2. if we don't do that, we effectively won't move the cursor at all, resulting in a shitty UX
    return { cursor_col = pos - 1, cursor_line = 0 }
  end

  local token = u.last_token(word)

  local zero = { position = 0, initial_character_type = nil, pivot_character_type = nil }
  -- print("LINE: '" .. line .. "'")
  -- print("WORD: '" .. word .. "'")
  -- print("TOKEN: '" .. token .. "'")
  local result = token:foldRight(zero, function(ch, acc)
    -- print("\t* CH => " .. ch)
    local current_character_type = char_type(ch)
    if acc.initial_character_type == nil then
      acc.initial_character_type = current_character_type
      acc.position = acc.position + 1
      return acc
    elseif acc.initial_character_type ~= current_character_type and acc.pivot_character_type == nil then
      acc.pivot_character_type = current_character_type
      acc.position = acc.position + 1
      return acc
    elseif acc.pivot_character_type ~= nil and acc.pivot_character_type ~= current_character_type then
      -- acc.position = acc.position + 1
      return acc, true
    else
      acc.position = acc.position + 1
      return acc
    end
  end)

  -- print("POS: " .. pos .. ", #WORD: " .. #word .. ", result.position: " .. result.position)
  return { cursor_col = pos + (#word - result.position), cursor_line = 0 }
end

--[[
-- Heuristic "jump right" implementation that, assuming `line` is the content of the line where the cursor is located,
-- starting from the beginning, up to the cursor (included):
--    1. first, it will get the leftmost word (sequence of alphanumerical and special characters)
--    2. then, it will tokenize the word based on adjacent alphanumerical or special characters, returning the first one
--    3. then, it will scan the token from first character to last, and try to find a pivot. A pivot is a charater whose
--        type is different from the initial (= first). If there's a pivot, that's where we want to land; otherwise, just
--        land at the end of the token itself
--]]
function Logic.jump_right(line)
  -- print("------------------------------------")
  if line == nil or line:match("^%s*$") then
    return { cursor_col = 0, cursor_line = 1 }
  end

  local word, pos = u.leftmost_word(line)
  if word ~= nil and #word == 1 then
    -- well, this is just equivalent of moving right by one with either <Right> or <l>, but:
    --    1. hey, IJ does it too
    --    2. if we don't do that, we effectively won't move the cursor at all, resulting in a shitty UX
    return { cursor_col = pos + 1, cursor_line = 0 }
  end

  local token = u.first_token(word)
  -- if the token is composed of one uppercase character follwed by consecutive alphanumerical, lowercase chars: jump to
  -- the end of that subtoken. i.e. `MyCoolClass` -> `CoolClass` -> `Class`
  local start_index, match = word:match("^()(%u[%l%d]+)")
  -- print("LINE: '" .. line .. "'")
  -- print("WORD: '" .. word .. "'")
  -- print("TOKEN: '" .. token .. "'")
  -- print("MATCH: '" .. (match or "N/A") .. "'")
  if match then
    local end_index = start_index + #match - 1
    return { cursor_col = pos + end_index, cursor_line = 0 }
  end

  local zero = { position = 0, initial_character_type = nil, pivot_character_type = nil }
  local result = token:foldLeft(zero, function(ch, acc)
    -- print("\t* CH => " .. ch)
    local current_character_type = char_type(ch)
    if acc.initial_character_type == nil then
      acc.initial_character_type = current_character_type
      acc.position = acc.position + 1
      return acc
    elseif acc.initial_character_type ~= current_character_type then
      acc.pivot_character_type = current_character_type
      -- acc.position = acc.position + 1
      return acc, true
    else
      acc.position = acc.position + 1
      return acc
    end
  end)

  -- print("POS: " .. pos .. ", #WORD: " .. #word .. ", result.position: " .. result.position)
  return { cursor_col = pos + result.position, cursor_line = 0 }
end

-- TODO: should I add special logic to treat enumeration items as a text that can be jumped as a whole?
-- TODO: give the user the ability to enable/disable special behaviours ?
local function setup(opts) end

function Logic.left_camel_hump()
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]
  local left = line:sub(1, col)
  local result = Logic.jump_left(left)

  -- assume the result will return a jump in the same line
  local new_col = result.cursor_col - 1
  local new_row = row
  -- and now, let's handle the case where we have to jump on the line above
  if result.cursor_line == -1 then
    if new_row > 1 then
      new_row = new_row - 1
      local line_above = vim.api.nvim_buf_get_lines(0, new_row - 1, new_row, true)[1]
      new_col = math.max(#line_above, 0)
    else
      new_col = 0
    end
  end
  vim.api.nvim_win_set_cursor(0, { new_row, new_col })
end

function Logic.right_camel_hump()
  right_camel_hump("")
end

return Logic
