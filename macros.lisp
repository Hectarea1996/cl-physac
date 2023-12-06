
(in-package #:physac)

(defmacro with-physics (&body body)
  `(unwind-protect
        (progn
          (init-physics)
          ,@body)
     (close-physics)))
