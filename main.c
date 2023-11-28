#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        // Fork this process 10 times
        pid_t pid = fork();

        if (pid == 0) {
            if (i == 6) {
                // Child 6 is the target child that we want to debug
                __asm__("int3");
                __asm__("vmcall");
                return 0xdeadbeef;
            } else {
                // All other children we just want to continue as normal
                printf("In child %d\n", i);
                sleep(1);
            }
            return 0; // Child process exits
        } else if (pid < 0) {
            // Fork failed
            perror("fork");
            return 1;
        }
    }

    // Parent process waits for all children to complete
    for (int i = 0; i < 10; i++) {
        wait(NULL);
    }

    printf("Parent exiting..\n");

    return 0;
}
