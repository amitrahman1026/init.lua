config = function()
  require("doxygen-nvim").setup({
    author = "Amit Rahman (amit.amit.rahman@gmail.com)",
    copyright = "Copyright (c) Amit Rahman {date}-present",
    args = {
      add_type = true,
      in_out = true,
    },
    fn = {
      type_details = false,
    },
  })
end
