%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

# Computes the sum of the memory elements at addresses:
#   arr + 0, arr + 1, ..., arr + (size - 1).
func array_product(arr : felt*, size) -> (product_result):
    if size == 0:
        return (product_result=1)
    end

    # size is not zero.
    let (product) = array_product(arr=arr + 2, size=size - 2)
    return (product_result=[arr] * product)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 4

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 2
    assert [ptr + 1] = 3
    assert [ptr + 2] = 4
    assert [ptr + 3] = 5

    # Call array_sum to compute the sum of the elements.
    let (product) = array_product(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(product)

    return ()
end
