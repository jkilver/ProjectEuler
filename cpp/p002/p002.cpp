#include <iostream>

int solve()
{
    long max_val = 4000000;

    long previous_fib = 1;
    long fib = 2;    

    long sum = 0;
    while(fib < max_val)
    {
        if(fib % 2 == 0)
        {
            sum += fib;
        }

        long old_fib = fib;
        fib = fib + previous_fib;
        previous_fib = old_fib;
    }

    return sum;
}

int main()
{
    std::cout << solve() << std::endl;

    return 0;
}
