;;; GNU/Emacs configuration settings used to display a session transcript file.

(defface font-lock-general-question-face
  ((((class color) (background dark)) (:foreground "Turquoise"))))

(custom-set-faces
   "custom-set-faces was added by Custom.
   If you edit it by hand, you could mess it up, so be careful.
   Your init file should contain only one such instance.
   If there is more than one, they won't work right."
  '(font-lock-general-question-face ((((class color) (background dark)) (:foreground "Turquoise")))))
  '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
  '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
  '(font-lock-doc-string-face ((t (:foreground "green2"))))
  '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
  '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
  '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
  '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
  '(font-lock-string-face ((t (:foreground "LimeGreen"))))

(font-lock-add-keywords 
 'org-mode
 '(
   ; screen cast transcriptions
   ("\\<GQ[0-9]*\"[^\"]+\"" . font-lock-warning-face)         ; general question
   ("\\<Q[0-9]+"            . font-lock-warning-face)         ; general question
   ("\\<Q[ecur][0-9]+"      . font-lock-warning-face)         ; general question
   ("\\<c[0-9]*\"[^\"]+\""  . font-lock-keyword-face)         ; code

   ))



(font-lock-add-keywords 
 'org-mode
 '(
   ; screen cast transcriptions
   ("\\<Q[0-9]*\"[^\"]+\""  . font-lock-warning-face)         ; specific question
   ("\\<GQ[0-9]*\"[^\"]+\"" . font-lock-variable-name-face)   ; general question
   ("\\<Q[0-9]+"            . font-lock-warning-face)         ; general question
   ("\\<Q[ecur][0-9]+"      . font-lock-warning-face)         ; general question
   ("\\<Qx\"[^\"]+\""       . font-lock-warning-face)         ; ignored question
   ("\\<C[0-9]*\"[^\"]+\""  . font-lock-keyword-face)         ; consider
   ("\\<c[0-9]*\"[^\"]+\""  . font-lock-keyword-face)         ; code
   ("\\<S[0-9]*\"[^\"]+\""  . font-lock-keyword-face)         ; statement

   ))
