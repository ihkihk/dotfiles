(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "localhost:3128")
     ("https" . "localhost:3128")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(toggle-tool-bar-mode-from-frame 0)
(setq-default c-basic-offset 4
	      tab-width 4
		  vhdl-basic-offset 4
	      indent-tabs-mode t)

(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)

