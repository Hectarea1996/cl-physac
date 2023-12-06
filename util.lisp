
(in-package #:physac)

;; MIT License

;; Copyright (c) 2017 cl-raylib project (https://github.com/longlene/cl-raylib/tree/master)

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(defmacro define-conversion-into-foreign-memory (lambda-list &body body)
  (let ((unquoted (mapcar (lambda (x)
                            (etypecase x
                              (symbol x)
                              (list (car x))))
                          (list (first lambda-list) (third lambda-list)))))
    (labels ((walk-and-quote (form)
               "A simple code walker that works fine without symbol shadowing"
               (typecase form
                 (list (cond
                         ((eql (first form) 'quote) `(quote ,form))
                         ((eql form body) `(list 'progn . ,(mapcar #'walk-and-quote form)))
                         (t `(list . ,(mapcar #'walk-and-quote form)))))
                 (t (if (member form unquoted) form `(quote ,form))))))
      `(progn
         (eval-when (:compile-toplevel :load-toplevel :execute)
           (defmethod expand-into-foreign-memory ,lambda-list
             ,(walk-and-quote body)))
         (defmethod translate-into-foreign-memory ,lambda-list
           ,@body)))))

(defmacro define-conversion-from-foreign (lambda-list &body body)
  (let ((unquoted (let ((arg1 (first lambda-list)))
                    (etypecase arg1
                      (symbol arg1)
                      (list arg1)))))
    (labels ((walk-and-quote (form)
               "A simple code walker that works fine without symbol shadowing"
               (typecase form
                 (list (cond
                         ((eql (first form) 'quote) `(quote ,form))
                         ((eql form body) `(list 'progn . ,(mapcar #'walk-and-quote form)))
                         (t `(list . ,(mapcar #'walk-and-quote form)))))
                 (t (if (eql form unquoted) form `(quote ,form))))))
      `(progn
         (eval-when (:compile-toplevel :load-toplevel :execute)
           (defmethod expand-from-foreign ,lambda-list
             ,(walk-and-quote body)))
         (defmethod translate-from-foreign ,lambda-list
           ,@body)))))
