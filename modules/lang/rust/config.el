;;; lang/rust/config.el -*- lexical-binding: t; -*-

(after! rust-mode
  (set-env! "RUST_SRC_PATH")
  (set-docsets! 'rust-mode "Rust")
  (setq rust-indent-method-chain t)

  (map! :map rust-mode-map
        :localleader
        :prefix "b"
        :desc "cargo build" "b" (λ! (compile "cargo build --color always"))
        :desc "cargo check" "c" (λ! (compile "cargo check --color always"))
        :desc "cargo run"   "r" (λ! (compile "cargo run --color always"))
        :desc "cargo test"  "t" (λ! (compile "cargo test --color always"))))


(def-package! racer
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (set-lookup-handlers! 'rust-mode
    :definition #'racer-find-definition
    :documentation #'racer-describe))


(def-package! flycheck-rust
  :when (featurep! :feature syntax-checker)
  :after rust-mode
  :config (add-hook 'rust-mode-hook #'flycheck-rust-setup))

(when (featurep! +lsp)
       (depends-on! :tools lsp)
       (lsp-register-client
        (make-lsp-client :new-connection (lsp-stdio-connection
                                          '("rustup" "run" "nightly" "rls")
                                          )
                         :major-modes '(rust-mode rustic-mode)
                         :priority -1
                         :server-id 'rls
                         :notification-handlers (lsp-ht ("window/progress" 'lsp-clients--rust-window-progress)))))
