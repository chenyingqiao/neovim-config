require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "nvo",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {
    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = true,
    max_highlighted_traversal_targets = 50,
    case_sensitive = false,
    equivalence_classes = { ' \t\r\n', },
    special_keys = {
      repeat_search = '<enter>',
      next_phase_one_target = '<enter>',
      next_target = {'<enter>', ';'},
      prev_target = {'<tab>', ','},
      next_group = '<space>',
      prev_group = '<tab>',
      multi_accept = '<enter>',
      multi_revert = '<backspace>',
    }
  }
}
