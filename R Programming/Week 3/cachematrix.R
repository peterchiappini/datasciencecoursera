## A pair of functions that cache the inverse of a matrix.
## The first function, makeCacheMatrix, creates a special 
## "matrix" object. This function returns a list of functions 
## that allow us to
##     1. set the value of the matrix
##     2. get the value of the matrix
##     3. set the inverse of the matrix
##     4. get the inverse of the matrix
## The second function, cacheSolve, returns the inverse of the 
## "matrix" object.


## A function to create a "matrix" object. This function returns
## a list of functions allowing us to set and get the value of the
## "matrix" and its inverse.
makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        
        # Set the value of the matrix
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        
        # Get the value of the matrix
        get <- function() x
        
        # Set/cache the inverse matrix
        setsolve <- function(solve)  inv <<- solve
        
        # Get the inverse matrix
        getsolve <- function()  inv
        
        list(set = set, get = get, 
             setsolve = setsolve, 
             getsolve = getsolve)
}


## A function to return the inverse of a "matrix" object 
## created by the makeCacheMatrix function. Additional 
## function arguments get passed to the solve function.
cacheSolve <- function(x, ...) {
        inv <- x$getsolve()
        if(!is.null(inv)) {
                # If inv is not null, then we already cached the 
                # value of the inverse of x
                message("getting cached data")
                return(inv)
        }
        data <- x$get()  # Get the value of the matrix
        inv <- solve(data, ...)  # compute the inverse of the matrix
        x$setsolve(inv)  # Cache the inverse of the matrix
        inv
}

## Testing

A <-matrix(c(1,3,4,3,2,2,3,4,5), 
           nrow=3,             
           ncol=3)

myMatrix_object <- makeCacheMatrix(A)

print(cacheSolve(myMatrix_object))
print(cacheSolve(myMatrix_object))  # "Getting cached data"

B <- matrix(c(5/8, -1/8, -7/8, 3/8), 
            nrow = 2, 
            ncol = 2)

myMatrix_object$set(B)  # Setting value of the matrix to B

print(cacheSolve(myMatrix_object))
print(cacheSolve(myMatrix_object))  # "Getting cached data"



