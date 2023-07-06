require('flit').setup {
  keys = { f = 'f', F = 't', t = 'F', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "nvo",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}
