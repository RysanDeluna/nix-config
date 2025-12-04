local definitions = require("definitions")

if definitions.colorscheme ~= "nordic" then
    return false
end

require('nordic').colorscheme({})
