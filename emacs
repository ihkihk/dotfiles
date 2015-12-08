(add-to-list 'load-path "~/.emacs.d/lisp/")

(toggle-tool-bar-mode-from-frame 0)
(setq-default c-basic-offset 4
	      tab-width 4
		  vhdl-basic-offset 4
	      indent-tabs-mode t)

(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)

