;;; Scripts to insert a timestamp from a Apple QuickTime Player movie (session video recording) to a transcript file (Orgmode)
;;; It also includes commands to control the Apple QuickTime Player, and to code static and dynamic tool usage.

(global-set-key [(alt b)] 'dabbrev-expand)

(defvar thing-at-point-session-time-regexp
  "[0-9][0-9]:[0-9][0-9]"
  "A regular expression matching to session time.")

(put 'session-time 'bounds-of-thing-at-point
     (lambda ()
       (let ((thing (thing-at-point-looking-at thing-at-point-session-time-regexp 500)))
	 (if thing
	     (let ((beginning (match-beginning 0))
		   (end (match-end 0)))
	       (cons beginning end))))))

(put 'session-time 'thing-at-point
     (lambda ()
       (let ((boundary-pair (bounds-of-thing-at-point 'session-time)))
	 (if boundary-pair
	     (buffer-substring-no-properties
	      (car boundary-pair) (cdr boundary-pair))))))

(defun jk:qt-session-time-at-point ()
  (interactive)
  (message "Time at point is %s." (thing-at-point 'session-time)))

(defun jk:qt-session-seconds-at-point ()
  (let ((time-string (thing-at-point 'session-time)))
    (if time-string
	(let ((minutes (string-to-number (first (split-string time-string ":"))))
	      (seconds (string-to-number (second (split-string time-string ":")))))
	  (cons time-string (+ (* minutes 60) seconds))))))

(when (featurep 'ns)
  (defun jk:qt-current-time ()
    "Get current time of QuickTime Player's front movie."
    (ns-do-applescript "
tell application \"QuickTime Player\"
	set theMovie to front document
	tell theMovie
		current time
	end tell
end tell"))

  (defun jk:qt-duration ()
    "Get duration of QuickTime Player's front movie in seconds."
    (ns-do-applescript "
tell application \"QuickTime Player\"
	set theMovie to front document
	tell theMovie
		duration
	end tell
end tell"))

  (defun jk:qt-formatted-time (time)
    "Format `TIME' as mm:ss."
    (format-seconds "%02m:%02s" time))

  (defun jk:qt-formatted-current-time ()
    "Format current time as mm:ss."
    (jk:qt-formatted-time (jk:qt-current-time)))

  (defun jk:qt-formatted-duration ()
    "Format duration time as mm:ss."
    (jk:qt-formatted-time (jk:qt-duration)))

  (defun jk:qt-display-current-time ()
    "Display current time of QuickTime Player's front movie 
in the status bar."
    (interactive)
    (message "Current time is %s of %s." (jk:qt-formatted-current-time) (jk:qt-formatted-duration)))

  (defun jk:qt-insert-current-time ()
    "Insert current time of QuickTime Player's front movie 
into current buffer."
    (interactive)
    (insert (jk:qt-formatted-current-time)))

  (defun jk:qt-insert-start-time ()
    "Insert current time in a form 'mm:ss-'. 
And store cursor position."
    (interactive)
    (jk:qt-insert-current-time)
    (insert "-")
    (point-to-register ?t)
    (insert " "))

  (defun jk:qt-insert-end-time ()
    "Jump to position of register 't' and write current time."
    (interactive)
    (let ((current-position (point-marker)))
      (jump-to-register ?t)
      (jk:qt-insert-current-time)
      (goto-char current-position)
      (org-meta-return)
      (jk:qt-insert-start-time)))

  (defun jk:qt-move-n-seconds (n)
    "Move current QuickTime Player's front movie 
by N seconds backward or forward."
    (interactive "nNumber of seconds to move: ")
    (ns-do-applescript  (mapconcat 'identity (list "
tell application \"QuickTime Player\"
	set theMovie to front document
	tell theMovie
		set current time to (current time + " (number-to-string n) ")
	end tell
end tell") ""))
    (message "Movie was moved by %d seconds." n))
  
  (defun jk:qt-back-1-second ()
    (interactive)
    (jk:qt-move-n-seconds -1))
  
  (defun jk:qt-back-3-seconds ()
    (interactive)
    (jk:qt-move-n-seconds -3))
  
  (defun jk:qt-back-10-seconds ()
    (interactive)
    (jk:qt-move-n-seconds -10))
  
  (defun jk:qt-forward-1-second ()
    (interactive)
    (jk:qt-move-n-seconds 1))
  
  (defun jk:qt-forward-3-seconds ()
    (interactive)
    (jk:qt-move-n-seconds 3))
  
  (defun jk:qt-forward-10-seconds ()
    (interactive)
    (jk:qt-move-n-seconds 10))

  (defun jk:qt-set-current-time (seconds)
    "Move current QuickTime Player's front movie to SECONDS."
    (interactive "nNumber of seconds to move: ")
    (ns-do-applescript  (mapconcat 'identity (list "
tell application \"QuickTime Player\"
	set theMovie to front document
	tell theMovie
		set current time to " (number-to-string seconds) "
	end tell
end tell") "")))

  (defun jk:qt-set-time-at-point ()
    "Move current QuickTime Player's front movie to the position
written at current buffer's cursor position."
    (interactive)
    (let ((time-string-and-seconds (jk:qt-session-seconds-at-point)))
      (if time-string-and-seconds
	  (progn
	    (jk:qt-set-current-time (cdr time-string-and-seconds))
	    (message "Set current time to %s." (car time-string-and-seconds)))
	(message "Current time is missing."))))

  (defun jk:qt-insert-tool (tool-name)
    "Insert live tool usage in a form 'mm:ss c\"`TOOL-NAME'\"<enter>'."
    (jk:qt-insert-current-time)
    (insert " c\"" tool-name "\"")
    (org-meta-return))

  (defun jk:qt-insert-dynamic-tool ()
    (interactive)
    (jk:qt-insert-tool "dynamic-tool"))

  (defun jk:qt-insert-static-tool ()
    (interactive)
    (jk:qt-insert-tool "static-tool"))

  (defun jk:qt-insert-example-tool ()
    (interactive)
    (jk:qt-insert-tool "example-tool"))

  (defun jk:qt-insert-testing-behavior ()
    (interactive)
    (jk:qt-insert-tool "testing-behavior"))

  (defun jk:qt-insert-other-tool ()
    (interactive)
    (jk:qt-insert-tool "other-tool"))

  (defun jk:qt-insert-rest ()
    (interactive)
    (jk:qt-insert-tool "rest-time"))

  (defun jk:qt-play-rate (rate)
    "Play current QuickTime Player's front movie with `RATE' speed."
    (interactive "nPlayback speed: ")
    (ns-do-applescript  (mapconcat 'identity (list "
tell application \"QuickTime Player\"
	set theMovie to front document
	tell theMovie
		set rate to " (number-to-string rate) "
	end tell
end tell") ""))
    (message "Playing at %f speed." rate))

  (defun jk:qt-play-15-rate ()
    "Play current QuickTime movie at 1.5 speed."
    (interactive)
    (jk:qt-play-rate 1.5))

  (defun jk:qt-play-20-rate ()
    "Play current QuickTime movie at double speed."
    (interactive)
    (jk:qt-play-rate 2.0))

  (defun jk:qt-play-30-rate ()
    "Play current QuickTime movie at triple speed."
    (interactive)
    (jk:qt-play-rate 3.0))

  (defun jk:qt-play-40-rate ()
    "Play current QuickTime movie four time faster."
    (interactive)
    (jk:qt-play-rate 4.0))

  (defun jk:qt-play-50-rate ()
    "Play current QuickTime movie five time faster."
    (interactive)
    (jk:qt-play-rate 5.0))

  (defun jk:qt-play-80-rate ()
    "Play current QuickTime movie eight time faster."
    (interactive)
    (jk:qt-play-rate 8.0))

  (defun jk:qt-play-normal-rate ()
    "Play current QuickTime movie at normal speed."
    (interactive)
    (jk:qt-play-rate 1.0))

  (defun jk:qt-session-root-directory ()
    "Return `nil' or root directory with session files."
    (let ((dir1 (org-entry-get (point) "RootDir1" t))
	  (dir2 (org-entry-get (point) "RootDir2" t))
	  (dir3 (org-entry-get (point) "RootDir3" t))
	  actual-directory)
      (dolist (each-directory (list dir1 dir2 dir3) actual-directory)
	(message "Checking %s" each-directory)
	(if (and (null actual-directory)
		 (not (null each-directory))
		 (file-accessible-directory-p each-directory))
	    (setq actual-directory each-directory)))))
  
  (defun jk:qt-session-screencast-file ()
    "Return empty string or session screencast file."
    (let ((root-dir (jk:qt-session-root-directory))
	  (filename (org-entry-get (point) "VideoFile" t)))
	  (concat root-dir filename)))
  
  (defun jk:qt-open-movie (unix-filename)
    "Open a movie"
    (interactive "fMovie filename: ")
    (if (file-exists-p unix-filename)
	(progn
	  (ns-do-applescript  (mapconcat 'identity (list "
set unixFile to \"" unix-filename "\"
set macFile to POSIX file unixFile
set fileRef to (macFile as alias)

tell application \"QuickTime Player\"
        open fileRef
end tell") ""))
	  (message "Opening screencast name %s." unix-filename))
      (message "File '%s' does not exist." unix-filename)))

  (defun jk:qt-open-session-movie ()
    "Open session's movie."
    (interactive)
    (jk:qt-open-movie (jk:qt-session-screencast-file)))
  
  (defun jk:qt-set-local-keys ()
    "It sets local keys for tool usage."
    (interactive)
    (local-set-key [?q] 'jk:qt-insert-dynamic-tool)
    (local-set-key [?w] 'jk:qt-insert-static-tool)
    (local-set-key [?e] 'jk:qt-insert-example-tool)
    (local-set-key [?r] 'jk:qt-insert-other-tool)
    (local-set-key [?t] 'jk:qt-insert-testing-behavior)
    (local-set-key [?z] 'jk:qt-insert-rest)

    (local-set-key [?a] 'org-metaleft)
    (local-set-key [?s] 'org-metaright)

    (local-set-key [?y] 'jk:qt-play-normal-rate)
    (local-set-key [?x] 'jk:qt-play-15-rate)
    (local-set-key [?c] 'jk:qt-play-20-rate)
    (local-set-key [?v] 'jk:qt-play-30-rate)
    (local-set-key [?b] 'jk:qt-play-40-rate)
    (local-set-key [?n] 'jk:qt-play-50-rate)
    (local-set-key [?m] 'jk:qt-play-80-rate)

    (local-set-key [?h] 'jk:qt-unset-local-keys)
    (message "Local key bindings are ready for tool usage transcript.")
    )
  
  (defun jk:qt-unset-local-keys ()
    "It unsets local keys for tool usage."
    (interactive)
    (local-set-key [?q] 'org-self-insert-command)
    (local-set-key [?w] 'org-self-insert-command)
    (local-set-key [?e] 'org-self-insert-command)
    (local-set-key [?r] 'org-self-insert-command)
    (local-set-key [?t] 'org-self-insert-command)
    (local-set-key [?z] 'org-self-insert-command)

    (local-set-key [?a] 'org-self-insert-command)
    (local-set-key [?s] 'org-self-insert-command)

    (local-set-key [?y] 'org-self-insert-command)
    (local-set-key [?x] 'org-self-insert-command)
    (local-set-key [?c] 'org-self-insert-command)
    (local-set-key [?v] 'org-self-insert-command)
    (local-set-key [?b] 'org-self-insert-command)
    (local-set-key [?n] 'org-self-insert-command)
    (local-set-key [?m] 'org-self-insert-command)

    (local-set-key [?h] 'org-self-insert-command)
    (message "Unset local key bindings of tool usage trancript.")
    )

  (global-set-key [(alt ctrl ?o)] 'jk:qt-open-session-movie)
  (global-set-key [(alt ctrl ?p)] 'jk:qt-set-time-at-point)
  (global-set-key [(alt shift ?d)] 'jk:qt-display-current-time)

  (global-set-key [(alt f8)] 'jk:qt-insert-start-time)
  (global-set-key [(alt ctrl f8)] 'jk:qt-insert-end-time)
  (global-set-key [(alt shift f8)] 'jk:qt-insert-current-time)
  (global-set-key [(alt f7)] 'jk:qt-back-1-second)
  (global-set-key [(alt f6)] 'jk:qt-back-3-seconds)
  (global-set-key [(alt f5)] 'jk:qt-back-10-seconds)
  (global-set-key [(alt f9)] 'jk:qt-forward-1-second)
  (global-set-key [(alt f10)] 'jk:qt-forward-3-seconds)
  (global-set-key [(alt f11)] 'jk:qt-forward-10-seconds)

  (global-set-key [(alt shift f9)] 'jk:qt-play-15-rate)
  (global-set-key [(alt shift f10)] 'jk:qt-play-20-rate)
  
  (global-set-key [(alt f4)] 'jk:qt-set-local-keys)

  )
