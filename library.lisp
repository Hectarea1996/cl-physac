
(in-package #:physac)

(define-foreign-library libphysac
  (:darwin "libphysac.dylib")
  (:unix "libphysac.so")
  (:windows (:or "physac.dll" "libphysac.dll"))
  (t (:default "libphysac")))

(unless (foreign-library-loaded-p 'libphysac)
  (use-foreign-library libphysac))
