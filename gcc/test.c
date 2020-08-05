#include"print.h"
#include <stdlib.h>
struct Node {
        int val;
        struct Node *next;
};
//void print(int a)
//{
//      volatile int * p = (int *)0xaaaaa008;
//      *p = a;
//}
int main(void) {
        struct Node *n1, *n2, *n3, *n4;
        n1->val = 3;
        n2->val = 4;
        n3->val = 5;
        n4->val = 6;
        n1->next = n2;
        n2->next = n3;
        n3->next = n4;
        n4->next = NULL;
        struct Node *temp;
        //for(temp = n1; temp != NULL; temp = temp->next) print(temp->val);
        print(n1->val);
        print(n2->val);
        print(n3->val);
        print(n4->val);
        while(1);
        return 0;
}