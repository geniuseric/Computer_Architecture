#include <stdio.h>

volatile int searchInsert(volatile int* nums, volatile int numsSize, volatile int target){
    volatile int down = 0, up = numsSize - 1, mid = 0;    
    compare:
    	mid = (down + up) >> 1;
        if (target == nums[mid]) return mid;
        else if (target < nums[mid]) goto less;
        else goto greater;
    less:
    	up = mid - 1;
    	if (down > up) return down;
    	goto compare;
    greater:
    	down = mid + 1;
    	if (down > up) return down;
    	goto compare; 
}

volatile int main(void) {
    volatile int data[] = {2, 3, 8, 11, 13, 19};
    volatile int size = 6, target = 13;
    volatile int index = searchInsert(data, size, target);
    printf("The insert position is %d\n", index);
    return 0;
}
