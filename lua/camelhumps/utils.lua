local Utils = {}

--[[
-- Given a non-empty string parameter called `line`, it tries to fetch the rightmost, non-whitespace word available and
-- return it, along with its starting index.
--]]
function Utils.rightmost_word(line)
  local start_index, word = line:match("()(%S+)%s*$")
  return word, start_index
end

--[[
-- Given a non-empty string parameter called `word`, it will try to tokenize it according two categories: alphanumerical
-- and special character words, and return the last token found. This token will become the possible candidate where we
-- will search the exact place to camel-hump from right to left direction.
--]]
function Utils.last_token(word)
  local token
  local i = 1
  local len = #word

  while i <= len do
    local c = word:sub(i, i)
    local j = i

    if c:match("%w") then
      -- alphanumerical run
      while j <= len and word:sub(j, j):match("%w") do
        j = j + 1
      end
    else
      -- non-alphanumerical run
      while j <= len and not word:sub(j, j):match("%w") do
        j = j + 1
      end
    end

    token = word:sub(i, j - 1)
    i = j
  end

  return token
end

return Utils

