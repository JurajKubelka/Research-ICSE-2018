;;; GNU/Emacs scripts to code questions
(global-set-key [(alt b)] 'dabbrev-expand)

(defun jk:keyword-insert (keyword-name)
  "Insert c\"`KEYWORD-NAME'\"."
  (insert " c\"" keyword-name "\" "))

(defun jk:question-answered ()
  "Add answered-question keyword."
  (interactive)
  (jk:keyword-insert "answered-question"))

(defun jk:question-wrongly-answered ()
  "Add answered-question keyword."
  (interactive)
  (jk:keyword-insert "wrongly-answered-question"))

(defun jk:question-abandoned ()
  "Add answered-question keyword."
  (interactive)
  (jk:keyword-insert "abandoned-question"))

(defun jk:question-unanswered ()
  "Add answered-question keyword."
  (interactive)
  (jk:keyword-insert "unanswered-question"))

(defun jk:question-unknown-response ()
  "Add answered-question keyword."
  (interactive)
  (jk:keyword-insert "unknown-response"))

(local-set-key [(alt ctrl ?y)] 'jk:question-answered)
(local-set-key [(alt ctrl ?x)] 'jk:question-wrongly-answered)
(local-set-key [(alt ctrl ?c)] 'jk:question-unanswered)
(local-set-key [(alt ctrl ?v)] 'jk:question-abandoned)
(local-set-key [(alt ctrl ?b)] 'jk:question-unknown-response)
