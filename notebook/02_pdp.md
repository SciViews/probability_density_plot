R6 object oriented programming
================

A la suite du séminaire du **16 janvier 2020**. Ce projet est jugé
intéressant par les membres du service. Je vais dès lors consacrer une
partie de mon temps à son développement.

Dans les propositions d’amélioration, il a été proposé d’explorer les
objets R6 OOP

## R6 OOP system

Etant donnée que je ne connais pas le R6 OOP (`object oriented
programming`), la suite de ce document sera consacré la découverte de
ces outils. Je débute mon apprentissage par les lectures suivantes :

  - <https://r6.r-lib.org>
  - <https://adv-r.hadley.nz/r6.html>

Malgré plusieurs sites, qui présentent briévement les objet R6, les
exmeples employés sont toujours les mêmes à l’exception de ce site :

  - <https://colinfay.me/r6-shared-objects/>

### Package R6

Le package R6 présenté par le <https://r6.r-lib.org>. Afin de présenter
les objet R6, il propose la classe `Person`. La fonction R6Class()
permet de créer un générateur d’object R6.

``` r
library(R6)

Person <- R6Class("Person",
  public = list(
    name = NULL,
    hair = NULL,
    initialize = function(name = NA, hair = NA) {
      self$name <- name
      self$hair <- hair
      self$greet()
    },
    set_hair = function(val) {
      self$hair <- val
    },
    greet = function() {
      cat(paste0("Hello, my name is ", self$name, ".\n"))
    }
  )
)
```

Dans la partie public de l’objet `Person` se trouve 2 valeurs associées
à NULL et 3 fonctions dont initialize(), set\_hair() et greet().
L’argument `self$` se réfère à l’objet.

La fonction new() permet de créer l’objet de classe `Person` et appel la
fonction initialize() (si elle est présente).

``` r
ann <- Person$new("Ann", "black")
```

    ## Hello, my name is Ann.

``` r
ann
```

    ## <Person>
    ##   Public:
    ##     clone: function (deep = FALSE) 
    ##     greet: function () 
    ##     hair: black
    ##     initialize: function (name = NA, hair = NA) 
    ##     name: Ann
    ##     set_hair: function (val)

``` r
ann$hair
```

    ## [1] "black"

``` r
ann$greet()
```

    ## Hello, my name is Ann.

La fonction set\_hair() permet de changer la valeur de `hair`

``` r
ann$set_hair("red")
ann$hair
```

    ## [1] "red"

``` r
ann
```

    ## <Person>
    ##   Public:
    ##     clone: function (deep = FALSE) 
    ##     greet: function () 
    ##     hair: red
    ##     initialize: function (name = NA, hair = NA) 
    ##     name: Ann
    ##     set_hair: function (val)

TODO …

### Package distr6

``` r
library(distr6)
```

    ## 
    ## -----------------------------

    ##  distr6 v1.3.2
    ## 
    ## Get started: ?distr6
    ## Changelog:   distr6News()

    ## -----------------------------

    ## 
    ## Attaching package: 'distr6'

    ## The following object is masked from 'package:stats':
    ## 
    ##     qqplot

    ## The following object is masked from 'package:grDevices':
    ## 
    ##     pdf

    ## The following objects are masked from 'package:base':
    ## 
    ##     mode, truncate

Lors de mes recherches, j’ai découvert le package distr6 qui propose une
explication brève et apppliquée des objets R6
    :

  - <https://alan-turing-institute.github.io/distr6/articles/webs/intro_to_r6.html>

Ce package n’est pas exécutable dans la configuration standard de la
SciViews Box 2019 (La suite de ce document est donc rédigé en dehors de
cette dernière).

#### Class

``` r
class(Normal)
```

    ## [1] "R6ClassGenerator"

``` r
#> [1] "R6ClassGenerator"
```

``` r
Normal$new() # si la class Normal a des valeurs par défaut
```

    ## Norm(mean = 0, var = 1)

``` r
#sinon il faut les définir 
n <- Normal$new(var = 2)
```

#### Methods

``` r
n$mean()
```

    ## [1] 0

``` r
n$summary()
```

    ## Normal Probability Distribution. Parameterised with:
    ##   mean = 0, var = 2
    ## 
    ##   Quick Statistics 
    ##  Mean:       0
    ##  Variance:   2
    ##  Skewness:   0
    ##  Ex. Kurtosis:   0
    ## 
    ##  Support: ℝ  Scientific Type: ℝ 
    ## 
    ##  Traits: continuous; univariate
    ##  Properties: symmetric; mesokurtic; no skew

#### Clone

Il explique la notion de `clone`. Pour ce faire, une classe simple nommé
`adder` est réalisée.

``` r
# creation d'une classe d'objet R6 
adder <- R6::R6Class("adder",public = list(add = function(y){
  self$x = self$x + y
  invisible(self)}, x = 0))
```

``` r
a <- adder$new()
a$x
```

    ## [1] 0

``` r
a$add(2)
a$x
```

    ## [1] 2

L’objet b est un double de l’objet a mais les environement de ces deux
objets restent lié. Une modification de b s’applique également sur a et
inversément.

``` r
a <- adder$new()
b <- a
a$x
```

    ## [1] 0

``` r
b$x
```

    ## [1] 0

``` r
b$add(4)
b$x
```

    ## [1] 4

``` r
a$x
```

    ## [1] 4

L’utilisation de la fonction `clone` va permettre de dissocier les deux
environnements qui vont pouvoir se développer séparement.

``` r
a <- adder$new()
b <- a$clone()
a$x
```

    ## [1] 0

``` r
b$x
```

    ## [1] 0

``` r
b$add(4)
b$x
```

    ## [1] 4

``` r
a$x
```

    ## [1] 0

### Premières conclusions

Les objets R6 sont intéressant. Afin de maitriser ces outils, il est
important de maitriser les outils plus en détails
