<a id="header-adp-github-headertag646"></a>
# cl\-physac

Welcome to ``` cl-physac ```\!\!

``` cl-physac ``` binds the functions from [Physac](https://github.com/victorfisac/Physac/tree/master)\. The engine uses a fixed time\-step thread loop to simluate physics\. A physics step contains the following phases\: get collision information\, apply dynamics\, collision solving and position correction\. It uses a very simple struct for physic bodies with a position vector to be used in any 3D rendering API\.

<a id="header-adp-github-headertag647"></a>
## Installation

First\, you need to install Physac\. However\, the project does not generate any shared libraries\, so you should install Physac from [this fork](https://github.com/Hectarea1996/Physac)\. Follow the installation instructions\:

`````shell
cd /path/to/your/repositories
git clone https://github.com/Hectarea1996/Physac.git
mkdir build && cd build
cmake ..
make
sudo make install
`````

It is safe to remove now the Physac project\.

Now make sure that your system can find the new shared library\. You may require to run the command \`sudo ldconfig\`\.

After this\, ``` cl-physac ``` can load without problems\. Clone this repository under the ``` ~/common-lisp ``` or ``` ~/quicklisp/local-projects ``` directory\.

Happy coding\!


<a id="header-adp-github-headertag648"></a>
## Documentation

* [Reference](/docs/reference.md#header-adp-github-reference)
