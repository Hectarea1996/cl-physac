
(in-package #:physac)


;; // Vector2 type
;; typedef struct Vector2 {
;;   float x;
;;   float y;
;; } Vector2;
(defcstruct (%vector2 :class vector2-type)
  (x :float)
  (y :float))

(define-conversion-into-foreign-memory ((object 3d-vectors:vec2) (type vector2-type) pointer)
  (with-foreign-slots ((x y) pointer (:struct %vector2))
    (setf x (3d-vectors:vx2 object)
          y (3d-vectors:vy2 object))))

(define-conversion-from-foreign (pointer (type vector2-type))
  (with-foreign-slots ((x y) pointer (:struct %vector2))
    (3d-vectors:vec2 x y)))


;; typedef enum PhysicsShapeType { PHYSICS_CIRCLE, PHYSICS_POLYGON } PhysicsShapeType;
(defcenum PhysicsShapeType
  :physics-circle
  :physics-polygon)


;; // Previously defined to be used in PhysicsShape struct as circular dependencies
;; typedef struct PhysicsBodyData *PhysicsBody;
(define-foreign-type physics-body-type ()
  ()
  (:actual-type :pointer)
  (:simple-parser PhysicsBody))

(defstruct physics-body
  physics-body-data)

(defmethod translate-to-foreign ((object physics-body) (type physics-body-type))
  (physics-body-physics-body-data object))

(defmethod expand-to-foreign ((object physics-body) (type physics-body-type))
  `(physics-body-physics-body-data ,object))

(defmethod translate-from-foreign (pointer (type physics-body-type))
  (make-physics-body :physics-body-data pointer))

(defmethod expand-from-foreign (pointer (type physics-body-type))
  `(make-physics-body :physics-body-data ,pointer))


;; // Mat2 type (used for polygon shape rotation matrix)
;; typedef struct Mat2 {
;;     float m00;
;;     float m01;
;;     float m10;
;;     float m11;
;; } Mat2;
(defcstruct (%mat2 :class mat2-type)
  (m00 :float)
  (m01 :float)
  (m10 :float)
  (m11 :float))

(define-conversion-into-foreign-memory ((object 3d-matrices:mat2) (type mat2-type) pointer)
  (with-foreign-slots ((m00 m01 m10 m11) pointer (:struct %mat2))
    (setf m00 (3d-matrices:miref2 object 0)
          m01 (3d-matrices:miref2 object 1)
          m10 (3d-matrices:miref2 object 2)
          m11 (3d-matrices:miref2 object 3))))

(define-conversion-from-foreign (pointer (type mat2-type))
  (with-foreign-slots ((m00 m01 m10 m11) pointer (:struct %mat2))
    (3d-matrices:mat2 (list m00 m01 m10 m11))))


;; typedef struct PolygonData {
;;     unsigned int vertexCount;                   // Current used vertex and normals count
;;     Vector2 positions[PHYSAC_MAX_VERTICES];     // Polygon vertex positions vectors
;;     Vector2 normals[PHYSAC_MAX_VERTICES];       // Polygon vertex normals vectors
;; } PolygonData;
(defcstruct (%polygon-data :class polygon-data-type)
  (vertex-count :uint)
  (positions (:struct %vector2) :count 24)
  (normals (:struct %vector2) :count 24))

(defstruct polygon-data
  positions
  normals)

(setf (documentation 'make-polygon-data 'function)
      "polygon-data's constructor."
      (documentation 'polygon-data-positions 'function)
      "polygon-data's positions accessor."
      (documentation 'polygon-data-normals 'function)
      "polygon-data's normals accessor.")

(define-conversion-into-foreign-memory ((object polygon-data) (type polygon-data-type) pointer)
  (with-foreign-slots ((vertex-count (:pointer positions) (:pointer normals)) pointer (:struct %polygon-data))
    (let ((vertices-count (min (length (polygon-data-positions object)) (length (polygon-data-normals object)))))
      (setf vertex-count vertices-count)
      (loop for i from 0 below vertices-count
            for position in (polygon-data-positions object)
            for normal in (polygon-data-normals object)
            do (setf (mem-aref positions '(:struct %vector2) i) position
                     (mem-aref normals '(:struct %vector2) i) normal)))))

(define-conversion-from-foreign (pointer (type polygon-data-type))
  (with-foreign-slots ((vertex-count (:pointer positions) (:pointer normals)) pointer (:struct %polygon-data))
    (loop for i from 0 below vertex-count
          collect (mem-aref positions '(:struct %vector2) i) into polygon-positions
          collect (mem-aref normals '(:struct %vector2) i) into polygon-normals
          finally (return (make-polygon-data :positions polygon-positions :normals polygon-normals)))))


;; typedef struct PhysicsShape {
;;     PhysicsShapeType type;                      // Physics shape type (circle or polygon)
;;     PhysicsBody body;                           // Shape physics body reference
;;     float radius;                               // Circle shape radius (used for circle shapes)
;;     Mat2 transform;                             // Vertices transform matrix 2x2
;;     PolygonData vertexData;                     // Polygon shape vertices position and normals data (just used for polygon shapes)
;; } PhysicsShape;
(defcstruct (%physics-shape :class physics-shape-type)
  (type PhysicsShapeType)
  (body PhysicsBody)
  (radius :float)
  (transform (:struct %mat2))
  (vertex-data (:struct %polygon-data)))

(defstruct physics-shape
  type
  body
  radius
  transform
  vertex-data)

(setf (documentation 'make-physics-shape 'function)
      "physics-shape's constructor."
      (documentation 'physics-shape-type 'function)
      "polygon-shape's type accessor."
      (documentation 'physics-shape-body 'function)
      "polygon-shape's body accessor."
      (documentation 'physics-shape-radius 'function)
      "polygon-shape's radius accessor."
      (documentation 'physics-shape-transform 'function)
      "polygon-shape's transform accessor."
      (documentation 'physics-shape-vertex-data 'function)
      "polygon-shape's vertex-data accessor.")

(define-conversion-into-foreign-memory ((object physics-shape) (type physics-shape-type) pointer)
  (with-foreign-slots ((type body radius transform vertex-data) pointer (:struct %physics-shape))
    (setf (physics-shape-type object) type
          (physics-shape-body object) body
          (physics-shape-radius object) radius
          (physics-shape-transform object) transform
          (physics-shape-vertex-data object) vertex-data)))

(define-conversion-from-foreign (pointer (type physics-shape-type))
  (with-foreign-slots ((type body radius transform vertex-data) pointer (:struct %physics-shape))
    (make-physics-shape :type type :body body :radius radius :transform transform :vertex-data vertex-data)))


;; typedef struct PhysicsBodyData {
;;     unsigned int id;                            // Reference unique identifier
;;     bool enabled;                               // Enabled dynamics state (collisions are calculated anyway)
;;     Vector2 position;                           // Physics body shape pivot
;;     Vector2 velocity;                           // Current linear velocity applied to position
;;     Vector2 force;                              // Current linear force (reset to 0 every step)
;;     float angularVelocity;                      // Current angular velocity applied to orient
;;     float torque;                               // Current angular force (reset to 0 every step)
;;     float orient;                               // Rotation in radians
;;     float inertia;                              // Moment of inertia
;;     float inverseInertia;                       // Inverse value of inertia
;;     float mass;                                 // Physics body mass
;;     float inverseMass;                          // Inverse value of mass
;;     float staticFriction;                       // Friction when the body has not movement (0 to 1)
;;     float dynamicFriction;                      // Friction when the body has movement (0 to 1)
;;     float restitution;                          // Restitution coefficient of the body (0 to 1)
;;     bool useGravity;                            // Apply gravity force to dynamics
;;     bool isGrounded;                            // Physics grounded on other body state
;;     bool freezeOrient;                          // Physics rotation constraint
;;     PhysicsShape shape;                         // Physics body shape information (type, radius, vertices, normals)
;; } PhysicsBodyData;
(defcstruct %physics-body-data
  (id :int)
  (enabled :boolean)
  (position (:struct %vector2))
  (velocity (:struct %vector2))
  (force (:struct %vector2))
  (angular-velocity :float)
  (torque :float)
  (orient :float)
  (inertia :float)
  (inverse-inertia :float)
  (mass :float)
  (inverse-mass :float)
  (static-friction :float)
  (dynamic-friction :float)
  (restitution :float)
  (use-gravity :boolean)
  (is-grounded :boolean)
  (freeze-orient :boolean)
  (shape (:struct %physics-shape)))

(defmacro define-physics-body-accessor (slot)
  (let ((data (gensym "DATA"))
        (object (make-symbol "BODY"))
        (value (gensym "VALUE"))
        (func-name (intern (concatenate 'string "PHYSICS-BODY-" (string slot)))))
    `(progn
       (defun ,func-name (,object)
         ,(concatenate 'string "physics-body's " (string-downcase (symbol-name slot)) " accessor")
         (let ((,data (physics-body-physics-body-data ,object)))
           (foreign-slot-value ,data '(:struct %physics-body-data) ',slot)))
       (defun (setf ,func-name) (,value ,object)
         (let ((,data (physics-body-physics-body-data ,object)))
           (setf (foreign-slot-value ,data '(:struct %physics-body-data) ',slot) ,value))))))

(defmacro define-physics-body-accessors (&rest slots)
  (let ((exprs (loop for slot in slots
                     collect `(define-physics-body-accessor ,slot))))
    `(progn ,@exprs)))

(define-physics-body-accessors id enabled position velocity force angular-velocity torque orient inertia
  inverse-inertia mass inverse-mass static-friction dynamic-friction restitution use-gravity is-grounded
  freeze-orient shape)


;; // Initializes physics values, pointers and creates physics loop thread
;; void InitPhysics(void);
(defcfun (init-physics "InitPhysics") :void
  "Initializes physics values, pointers and creates physics loop thread")


;; // Returns true if physics thread is currently enabled
;; bool IsPhysicsEnabled(void);
(defcfun (is-physics-enabled "IsPhysicsEnabled") :boolean
  "Returns true if physics thread is currently enabled")


;; // Sets physics global gravity force
;; void SetPhysicsGravity(float x, float y);
(defcfun (set-physics-gravity "SetPhysicsGravity") :void
  "Sets physics global gravity force"
  (x :float) (y :float))


;; // Creates a new circle physics body with generic parameters
;; PhysicsBody CreatePhysicsBodyCircle(Vector2 pos, float radius, float density);
(defcfun (create-physics-body-circle "CreatePhysicsBodyCircle") PhysicsBody
  "Creates a new circle physics body with generic parameters"
  (pos (:struct %vector2)) (radius :float) (density :float))


;; // Creates a new rectangle physics body with generic parameters
;; PhysicsBody CreatePhysicsBodyRectangle(Vector2 pos, float width, float height, float density);
(defcfun (create-physics-body-rectangle "CreatephysicsBodyRectangle") PhysicsBody
  "Creates a new rectangle physics body with generic parameters"
  (pos (:struct %vector2)) (width :float) (height :float) (density :float))


;; // Creates a new polygon physics body with generic parameters
;; PhysicsBody CreatePhysicsBodyPolygon(Vector2 pos, float radius, int sides, float density);
(defcfun (create-physics-body-polygon "CreatePhysicsBodyPolygon") PhysicsBody
  "Creates a new polygon physics body with generic parameters"
  (pos (:struct %vector2)) (radius :float) (sides :int) (density :float))


;; // Adds a force to a physics body
;; void PhysicsAddForce(PhysicsBody body, Vector2 force);
(defcfun (physics-add-force "PhysicsAddForce") :void
  "Adds a force to a physics body"
  (body PhysicsBody) (force (:struct %vector2)))


;; // Adds a angular force to a physics body
;; void PhysicsAddTorque(PhysicsBody body, float amount);
(defcfun (physics-add-torque "PhysicsAddTorque") :void
  "Adds a angular force to a physics body"
  (body PhysicsBody) (amount :float))


;; // Shatters a polygon shape physics body to little physics bodies with explosion force
;; void PhysicsShatter(PhysicsBody body, Vector2 position, float force);
(defcfun (physics-shatter "PhysicsShatter") :void
  "Shatters a polygon shape physics body to little physics bodies with explosion force"
  (body PhysicsBody) (position (:struct %vector2) (force :float)))


;; // Returns the current amount of created physics bodies
;; int GetPhysicsBodiesCount(void);
(defcfun (get-physics-bodies-count "GetPhysicsBodiesCount") :int
  "Returns the current amount of created physics bodies")


;; // Returns a physics body of the bodies pool at a specific index
;; PhysicsBody GetPhysicsBody(int index);
(defcfun (get-physics-body "GetPhysicsBody") PhysicsBody
  "Returns a physics body of the bodies pool at a specific index"
  (index :int))


;; // Returns the physics body shape type (PHYSICS_CIRCLE or PHYSICS_POLYGON)
;; int GetPhysicsShapeType(int index);
(defcfun (get-physics-shape-type "GetPhysicsShapeType") :int
  "Returns the physics body shape type (:physics-circle or :physics-polygon)"
  (index :int))


;; // Returns the amount of vertices of a physics body shape
;; int GetPhysicsShapeVerticesCount(int index);
(defcfun (get-physics-shape-vertices-count "GetPhysicsShapeVerticesCount") :int
  "Returns the amount of vertices of a physics body shape"
  (index :int))


;; // Returns transformed position of a body shape (body position + vertex transformed position)
;; Vector2 GetPhysicsShapeVertex(PhysicsBody body, int vertex);
(defcfun (get-physics-shape-vertex "GetPhysicsShapeVertex") (:struct %vector2)
  "Returns transformed position of a body shape (body position + vertex transformed position)"
  (body PhysicsBody) (vertex :int))


;; // Sets physics body shape transform based on radians parameter
;; void SetPhysicsBodyRotation(PhysicsBody body, float radians);
(defcfun (set-physics-body-rotation "SetPhysicsBodyRotation") :void
  "Sets physics body shape transform based on radians parameter"
  (body PhysicsBody) (radians :float))


;; // Unitializes and destroy a physics body
;; void DestroyPhysicsBody(PhysicsBody body);
(defcfun (destroy-physics-body "DestroyPhysicsBody") :void
  "Unitializes and destroy a physics body"
  (body PhysicsBody) (radians :float))


;; // Unitializes physics pointers and closes physics loop thread
;; void ClosePhysics(void);
(defcfun (close-physics "ClosePhysics") :void
  "Unitializes physics pointers and closes physics loop thread")
