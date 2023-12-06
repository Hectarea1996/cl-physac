
(defsystem "cl-physac"
  :author "Héctor Galbis Sanchis"
  :mailto "hectometrocuadrado@gmail.com"
  :licence "MIT"
  :description "Physac bindings for Common Lisp"
  :depends-on ("3d-vectors" "3d-matrices" "cffi-libffi")
  :components ((:file "package")
               (:file "library")
               (:file "util")
               (:file "physac")
               (:file "macros")))
