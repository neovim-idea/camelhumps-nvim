local CamelHumps = {}

local logic = require("camelhumps.logic")

function CamelHumps.setup()
  return CamelHumps
end

function CamelHumps.left()
  logic.left_camel_hump()
end

function CamelHumps.right()
  logic.right_camel_hump()
end

function CamelHumps.left_delete()
  logic.left_delete()
end

function CamelHumps.right_delete()
  logic.right_delete()
end

return CamelHumps
