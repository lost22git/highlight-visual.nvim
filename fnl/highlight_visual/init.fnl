(fn get_visual_range []
  (local mode (vim.fn.mode))
  ;; N MODE
  (when (= :n mode) (lua "return"))
  ;; V MODES
  (case mode
    ;; V-LINE MODE
    :V
    (let [cl (vim.fn.line ".") ;; current line
          pl (vim.fn.line "v") ;; peer line
          ]
      (if (< cl pl)
          [[(- cl 1) 0] [(- pl 1) vim.v.maxcol]]
          [[(- pl 1) 0] [(- cl 1) vim.v.maxcol]]))
    ;; V MODE OR V-BLOCK MODE
    _
    (let [cp (vim.fn.getpos ".")
          pp (vim.fn.getpos "v")
          [_ cl cc _] cp ;; current pos
          [_ pl pc _] pp ;; peer pos
          ]
      (if (or (< cl pl) (and (= cl pl) (< cc pc)))
          [[(- cl 1) (- cc 1)] [(- pl 1) pc]]
          [[(- pl 1) (- pc 1)] [(- cl 1) cc]]))))

(fn back_to_normal_mode []
  (vim.cmd "exe \"normal \\<Esc>\""))

(local M {})
(local default_config {:hl_group :Visual :key :<Leader>v})

(local nsid (vim.api.nvim_create_namespace :zz_highlight_visual))
(fn M.highlight_visual []
  (vim.api.nvim_buf_clear_namespace 0 nsid 0 -1)
  (case (get_visual_range)
    [from to] (vim.hl.range 0 nsid M.config.hl_group from to))
  (back_to_normal_mode)
  nil)

(fn create_keymaps []
  (vim.keymap.set [:n :v] M.config.key M.highlight_visual
                  {:desc "Highlight Visual"}))

(fn M.setup [config]
  (set M.config (vim.tbl_deep_extend :force default_config (or config {})))
  (create_keymaps)
  nil)

M
