;; -*- no-byte-compile: t; -*-
;;; lang/web/packages.el

;; requires js-beautify stylelint stylelint-scss

(package! rainbow-mode)
(when (featurep! :completion ivy)
  (package! counsel-css))

;; +html.el
(package! emmet-mode)
(package! haml-mode)
(package! pug-mode)
(package! slim-mode)
(when (package! web-mode)
  (when (featurep! :completion company)
    (package! company-web)))

;; +css.el
(package! less-css-mode)
(package! sass-mode)
(package! stylus-mode)
(cond ((featurep! +lsp)
       (depends-on! :tools lsp
                    (package! lsp-css
                      :recipe (:fetcher
                               github
                               :repo "emacs-lsp/lsp-css")))))
