
(in-package #:physac)

(defmacro with-physics (&body body)
  "Encloses the body with the initialization and unitialization of physics simulation."
  `(unwind-protect
        (progn
          (init-physics)
          ,@body)
     (close-physics)))
