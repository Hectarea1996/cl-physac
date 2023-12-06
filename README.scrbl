
(in-package #:adp-github)

@header{cl-physac}

Welcome to @code{cl-physac}!!

@code{cl-physac} is a small 2D physics engine that binds the functions from @link[:address "https://github.com/victorfisac/Physac/tree/master"]{Physac}. The engine uses a fixed time-step thread loop to simluate physics. A physics step contains the following phases: get collision information, apply dynamics, collision solving and position correction. It uses a very simple struct for physic bodies with a position vector to be used in any 3D rendering API.

@subheader{Installation}

First, you need to install Physac. However, the project does not generate any shared libraries, so you should install Physac from @link[:address "https://github.com/Hectarea1996/Physac"]{this fork}. Follow the installation instructions:

@code-block[:lang "shell"]{
cd /path/to/your/repositories
git clone https://github.com/Hectarea1996/Physac.git
mkdir build && cd build
cmake ..
make
sudo make install
}

It is safe to remove now the Physac project.

Now make sure that your system can find the new shared library. You may require to run the command `sudo ldconfig`.

After this, @code{cl-physac} can load without problems. Clone this repository under the @code{~/common-lisp} or @code{~/quicklisp/local-projects} directory.

Happy coding!


@subheader{Documentation}

@itemize[
        @item{@href[:tag reference]{Reference}}
]
