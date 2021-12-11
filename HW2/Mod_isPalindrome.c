# define SIZE 4

int div(int a, int b){ // d = a / b
    int d = 0;
    while (a >= b){
        a -= b;
        d += 1;
    }
    return d;
}

int mod(int a, int b){ // m = a / b
    int m = a;
    while (m >= b)
        m -= b;
    return m;
}

int isPalindrome(int x){
    if (x == 0)
        return 1;
    else if (x < 0 || mod(x, 10) == 0)
        return 0;
    else{
        int temp = x;
        int back_x = 0;
        while (temp > back_x){
            back_x = back_x * 10 + mod(temp, 10);
            temp = div(temp, 10);	
        }		
        return (back_x == temp) || (div(back_x, 10) == temp);
    }
}

void _start(){
    int data[SIZE] = {-88, 10, 12321, 258852};
    volatile char *tx_char = (volatile char *) 0x40002000;
    volatile int *tx_int = (volatile int *) 0x40000008;
    const char *isTrue = " is a palindrome!\n";
    const char *isFalse = " is not a palindrome.\n";
    int counter;
    for (int i = 0; i < SIZE; i++){
        int res = isPalindrome(data[i]);
        *tx_int = data[i];
        counter = 0;
        if (res == 1){    		
            while(*isTrue){
                *tx_char = *isTrue;
                isTrue++;
                counter++;
            }
            isTrue -= counter;
        }
        else{
            while(*isFalse){
                *tx_char = *isFalse;
                isFalse++;
                counter++;
            } 
            isFalse -= counter;  
        } 	
    }    
}
