<a id="header-adp-github-reference"></a>
# cl\-physac reference

<a id="function-physac-close-physics"></a>
#### Function: physac:close-physics nil

`````text
Unitializes physics pointers and closes physics loop thread
`````

<a id="function-physac-create-physics-body-circle"></a>
#### Function: physac:create-physics-body-circle (pos radius density)

`````text
Creates a new circle physics body with generic parameters
`````

<a id="function-physac-create-physics-body-polygon"></a>
#### Function: physac:create-physics-body-polygon (pos radius sides density)

`````text
Creates a new polygon physics body with generic parameters
`````

<a id="function-physac-create-physics-body-rectangle"></a>
#### Function: physac:create-physics-body-rectangle (pos width height density)

`````text
Creates a new rectangle physics body with generic parameters
`````

<a id="function-physac-destroy-physics-body"></a>
#### Function: physac:destroy-physics-body (body radians)

`````text
Unitializes and destroy a physics body
`````

<a id="function-physac-get-physics-bodies-count"></a>
#### Function: physac:get-physics-bodies-count nil

`````text
Returns the current amount of created physics bodies
`````

<a id="function-physac-get-physics-body"></a>
#### Function: physac:get-physics-body (index)

`````text
Returns a physics body of the bodies pool at a specific index
`````

<a id="function-physac-get-physics-shape-type"></a>
#### Function: physac:get-physics-shape-type (index)

`````text
Returns the physics body shape type (:physics-circle or :physics-polygon)
`````

<a id="function-physac-get-physics-shape-vertex"></a>
#### Function: physac:get-physics-shape-vertex (body vertex)

`````text
Returns transformed position of a body shape (body position + vertex transformed position)
`````

<a id="function-physac-get-physics-shape-vertices-count"></a>
#### Function: physac:get-physics-shape-vertices-count (index)

`````text
Returns the amount of vertices of a physics body shape
`````

<a id="function-physac-init-physics"></a>
#### Function: physac:init-physics nil

`````text
Initializes physics values, pointers and creates physics loop thread
`````

<a id="function-physac-is-physics-enabled"></a>
#### Function: physac:is-physics-enabled nil

`````text
Returns true if physics thread is currently enabled
`````

<a id="function-physac-make-physics-shape"></a>
#### Function: physac:make-physics-shape (&key ((:type type) nil)
                                          ((:body body) nil)
                                          ((:radius radius) nil)
                                          ((:transform transform) nil)
                                          ((:vertex-data vertex-data) nil))

`````text
physics-shape's constructor.
`````

<a id="function-physac-make-polygon-data"></a>
#### Function: physac:make-polygon-data (&key ((:positions positions) nil)
                                         ((:normals normals) nil))

`````text
polygon-data's constructor.
`````

<a id="function-physac-physics-add-force"></a>
#### Function: physac:physics-add-force (body force)

`````text
Adds a force to a physics body
`````

<a id="function-physac-physics-add-torque"></a>
#### Function: physac:physics-add-torque (body amount)

`````text
Adds a angular force to a physics body
`````

<a id="function-physac-physics-body-angular-velocity"></a>
#### Function: physac:physics-body-angular-velocity (object102)

`````text
physics-body's angular-velocity accessor
`````

<a id="function-physac-physics-body-dynamic-friction"></a>
#### Function: physac:physics-body-dynamic-friction (object294)

`````text
physics-body's dynamic-friction accessor
`````

<a id="function-physac-physics-body-enabled"></a>
#### Function: physac:physics-body-enabled (object26)

`````text
physics-body's enabled accessor
`````

<a id="function-physac-physics-body-force"></a>
#### Function: physac:physics-body-force (object84)

`````text
physics-body's force accessor
`````

<a id="function-physac-physics-body-freeze-orient"></a>
#### Function: physac:physics-body-freeze-orient (object386)

`````text
physics-body's freeze-orient accessor
`````

<a id="function-physac-physics-body-id"></a>
#### Function: physac:physics-body-id (object1)

`````text
physics-body's id accessor
`````

<a id="function-physac-physics-body-is-grounded"></a>
#### Function: physac:physics-body-is-grounded (object364)

`````text
physics-body's is-grounded accessor
`````

<a id="function-physac-physics-body-orient"></a>
#### Function: physac:physics-body-orient (object150)

`````text
physics-body's orient accessor
`````

<a id="function-physac-physics-body-position"></a>
#### Function: physac:physics-body-position (object48)

`````text
physics-body's position accessor
`````

<a id="function-physac-physics-body-restitution"></a>
#### Function: physac:physics-body-restitution (object318)

`````text
physics-body's restitution accessor
`````

<a id="function-physac-physics-body-shape"></a>
#### Function: physac:physics-body-shape (object408)

`````text
physics-body's shape accessor
`````

<a id="function-physac-physics-body-static-friction"></a>
#### Function: physac:physics-body-static-friction (object270)

`````text
physics-body's static-friction accessor
`````

<a id="function-physac-physics-body-torque"></a>
#### Function: physac:physics-body-torque (object126)

`````text
physics-body's torque accessor
`````

<a id="function-physac-physics-body-use-gravity"></a>
#### Function: physac:physics-body-use-gravity (object342)

`````text
physics-body's use-gravity accessor
`````

<a id="function-physac-physics-body-velocity"></a>
#### Function: physac:physics-body-velocity (object66)

`````text
physics-body's velocity accessor
`````

<a id="function-physac-physics-shape-body"></a>
#### Function: physac:physics-shape-body (sb-kernel:instance)

`````text
polygon-shape's body accessor.
`````

<a id="function-physac-physics-shape-radius"></a>
#### Function: physac:physics-shape-radius (sb-kernel:instance)

`````text
polygon-shape's radius accessor.
`````

<a id="function-physac-physics-shape-transform"></a>
#### Function: physac:physics-shape-transform (sb-kernel:instance)

`````text
polygon-shape's transform accessor.
`````

<a id="function-physac-physics-shape-type"></a>
#### Function: physac:physics-shape-type (sb-kernel:instance)

`````text
polygon-shape's type accessor.
`````

<a id="function-physac-physics-shape-vertex-data"></a>
#### Function: physac:physics-shape-vertex-data (sb-kernel:instance)

`````text
polygon-shape's vertex-data accessor.
`````

<a id="function-physac-physics-shatter"></a>
#### Function: physac:physics-shatter (body position)

`````text
Shatters a polygon shape physics body to little physics bodies with explosion force
`````

<a id="function-physac-polygon-data-normals"></a>
#### Function: physac:polygon-data-normals (sb-kernel:instance)

`````text
polygon-data's normals accessor.
`````

<a id="function-physac-polygon-data-positions"></a>
#### Function: physac:polygon-data-positions (sb-kernel:instance)

`````text
polygon-data's positions accessor.
`````

<a id="function-physac-set-physics-body-rotation"></a>
#### Function: physac:set-physics-body-rotation (body radians)

`````text
Sets physics body shape transform based on radians parameter
`````

<a id="function-physac-set-physics-gravity"></a>
#### Function: physac:set-physics-gravity (x y)

`````text
Sets physics global gravity force
`````

<a id="function-physac-with-physics"></a>
#### Macro: physac:with-physics (&body body)

`````text
Encloses the body with the initialization and unitialization of physics simulation.
`````