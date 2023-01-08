# How To Merge Two Compatible Shapes

Merging

## Overview

We want to combine ShapeA with ShapeB

### ShapeA

```
.        
.GLAZE.      
    I H      
    O A      
   .NAZARETH.
    . E      
      L      
      N      
      U      
      T      
      .      
```

### Shape B

```
 .    
 H    
 A    
 Z    
 E    
 L    
 N    
 U    
.TOYS.
 .     
```

To get the result:

```
   .        
.GLAZE.      
    I H      
    O A      
   .NAZARETH.
    . E      
      L      
      N      
      U      
     .TOYS.  
      .      
```

The position of HAZELNUT in 
* shape A is x: 1, y: 0
* shape B is x: 6, y: 1

So we have to move shape A by 5 to the right and 1 down

xB - xA = 5
yB - yA = 1

So we apply this to all the placements in shapeA and leave shapeB alone.

This has worked before but then other exceptions have come up and I changed the algorithm and messed it up.

We can see that this worked because shape B is offset in the positive direction to shape A
You could say that shapeA is moving to the bottom right of shape A

Seems like we should calculate which shape should stay the same and which shape should be offset at least in this situation.


```
   .        
.GLAZE.      
    I H      
    O A      
   .NAZARETH.
    . E      
      L      
      N      
      U      
     .TOYS.  
      .      
```


## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
