;;; Functions used to export a transcript Ormode file to an HTML file.
;;; The export does not work correctly in some scenarios. Such scenarios are detect by the second function.

(defun jk:retouch-html-export ()
  "Whenever there is a link inside of double-quotes, it fails to replace correctly.
It is neccesary to search for `href=\"</span>', remove `<span>' and put it to a correct place."
  (interactive)
  (let ((query-replace t)
	(case-fold-search nil))
    (replace-regexp "\\<Q[0-9]*\"[^\"]+\"" "<span class=\"specific-question\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<GQ[0-9]*\"[^\"]+\"" "<span class=\"general-question\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<Q[0-9]+" "<span class=\"short-question\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<Q[ecur][0-9]+" "<span class=\"short-question\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<Qx\"[^\"]+\"" "<span class=\"ignored-question\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<C\"[^\"]+\"" "<span class=\"thought\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<D\"[^\"]+\"" "<span class=\"thought\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<S\"[^\"]+\"" "<span class=\"statement\">\\&</span>" nil (point-min) (point-max))
    (replace-regexp "\\<c\"[^\"]+\"" "<span class=\"keyword\">\\&</span>" nil (point-min) (point-max))))

(defun jk:search-for-wrong-span ()
  "It helps to find errors produced by `jk:retouch-html-export' function.
You still have to fix it manually."
  (interactive)
  (search-forward "href=\"</span>" nil t nil))
