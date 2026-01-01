local CamelHumps = {}

local logic = require("camelhumps.logic")

function CamelHumps.left()
  logic.left_camel_hump()
end

function CamelHumps.setup()
  return CamelHumps
end

function CamelHumps.right()
  logic.right_camel_hump()
end

return CamelHumps
