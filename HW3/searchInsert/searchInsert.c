#include <stdio.h>

int searchInsert(int* nums, int numsSize, int target){
    int down = 0, up = numsSize - 1, mid = 0;
    while (down <= up){
        mid = (down + up) / 2;
        if (target == nums[mid]) return mid;
        else if (target < nums[mid]) up = mid - 1;
        else down = mid + 1;
    }
    return down;
}

int main(void) {
    int data[] = {2, 3, 8, 11, 13, 19};
    int size = 6, target = 13;
    int index = searchInsert(data, size, target);
    printf("The insert position is %d\n", index);
    return 0;
}
