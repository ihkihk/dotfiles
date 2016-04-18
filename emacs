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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   (quote
	("/cygdrive/c/Windows/system32" "/cygdrive/c/Windows" "/cygdrive/c/Windows/System32/Wbem" "/cygdrive/c/IBM/RationalSDLC/ClearCase/bin" "/cygdrive/c/IBM/RationalSDLC/common" "/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0" "/cygdrive/c/Program Files (x86)/IBM/gsk8/lib" "/cygdrive/c/Program Files (x86)/IBM/gsk8/bin" "/cygdrive/c/IBM/RationalSDLC/ClearCase/RemoteClient/cteapis" "/cygdrive/c/Users/ch5983/.dnx/bin" "/cygdrive/c/Program Files/Microsoft DNX/Dnvm" "/cygdrive/c/Program Files (x86)/Windows Kits/8.1/Windows Performance Toolkit" "/cygdrive/c/work/out/lib/v40/w32/dll" "/cygdrive/c/Altera/13.0sp1/modelsim_ase/win32aloem" "/cygdrive/c/altera/14.1/modelsim_ase/win32aloem" "/cygdrive/c/altera/14.1/modelsim_ae/win32aloem" "/usr/libexec/emacs/24.5/x86_64-unknown-cygwin" "/home/ch5983/bin"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
