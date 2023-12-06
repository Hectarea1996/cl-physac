
(defpackage #:physac
  (:use #:cl #:cffi)
  (:export #:polygon-data-positions #:polygon-data-normals 

           #:physics-shape-type #:physics-shape-body #:physics-shape-radius
           #:physics-shape-transform #:physics-shape-vertex-data

           #:physics-body-id #:physics-body-enabled #:physics-body-position #:physics-body-velocity
           #:physics-body-force #:physics-body-angular-velocity #:physics-body-torque #:physics-body-orient
           #:physics-body-static-friction #:physics-body-dynamic-friction #:physics-body-restitution
           #:physics-body-use-gravity #:physics-body-is-grounded #:physics-body-freeze-orient
           #:physics-body-shape

           #:init-physics #:is-physics-enabled #:set-physics-gravity #:create-physics-body-circle
           #:create-physics-body-rectangle #:create-physics-body-polygon #:physics-add-force
           #:physics-add-torque #:physics-shatter #:get-physics-bodies-count #:get-physics-body
           #:get-physics-shape-type #:get-physics-shape-vertices-count #:get-physics-shape-vertex
           #:set-physics-body-rotation #:destroy-physics-body #:close-physics

           #:with-physics))
