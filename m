From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 Jul 2018 03:41:50 -0400 (EDT)
Subject: [LTP] [PATCH v2] Test : madvise('MADV_WIPEONFORK')
In-Reply-To: <1532010442-4742-1-git-send-email-kewal@zilogic.com>
References: <1532010442-4742-1-git-send-email-kewal@zilogic.com>
Message-ID: <692165764.34693020.1532072510498.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
>  madvise10.c :- Present the child process with zero-filled memory in
>   this range after a fork(2).
>   Test-Case 1 : madvise with 'MADV_WIPEONFORK'
>   Test-Case 2 : madvise with 'MADV_WIPEONFORK' as size 'ZERO'
> 
>  madvise11.c:- The MADV_WIPEONFORK operation can be applied only to
>   private anonymous pages.
>   Test-Case 1 : mmap with 'MAP_SHARED | MAP_ANONYMOUS'
>   Test-Case 2 : mmap with 'MAP_PRIVATE'
> 
>  madvise12.c:- Within the child created by fork(2), the MADV_WIPEONFORK
>   setting remains in place on the specified address range.
>   Test-Case 1: 'MADV_WIPEONFORK' on Grand child
> 
>  madvise13.c:- MADV_KEEPONFORK Undo the effect of an earlier MADV_WIPEONFORK
>   Test-Case 1 : Undo 'MADV_WIPEONFORK' by 'MADV_KEEPONFORK'
> 
> * Update from v1 to v2:-
> 
>  Added EINVAL error check in madvise02.
>  Tests having common code are combined together and put into one
>   single file madvise10.c.
>  Files were added to .gitignore which was left out in the previous
>   patch file.
>  Using -1 as file descriptor for MAP_PRIVATE | MAP_ANONYMOUS page.
>  Whole mapped-memory area is compared instead of first byte.
>  Printing test_errno with TFAIL.
> 
> Signed-off-by: Subash Ganesan <subash@zilogic.com>
> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>

Hi,

Pushed with following changes:

- split into 2 patches, one for madvise02, and for madvise10

madvise10:
- commit message changed to be relevant to latest patch
- dropped unnecessary includes
- increased MAP_SIZE, so we cover couple pages at least on x86
- added description to struct test_case for each test
- cmp_area() changed to print also what failed, index and value
- pattern modulo changed to 0x03, so pages are somewhat unique

Thanks,
Jan


@@ -51,23 +51,15 @@
  **/

 #include <stdio.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <error.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <stdlib.h>

 #include "lapi/mmap.h"
 #include "tst_test.h"
 #include "tst_safe_macros.h"

-#define MAP_SIZE (4 * 1024)
+#define MAP_SIZE (16 * 1024)

 static char pattern[MAP_SIZE];
 static char zero[MAP_SIZE];
@@ -78,11 +70,16 @@
        int advise2;
        char *exp;
        int grand_child;
+       const char *desc;
 } tcases[] = {
-       {MAP_SIZE, MADV_NORMAL, MADV_WIPEONFORK, zero,    0},
-       {0,        MADV_NORMAL, MADV_WIPEONFORK, pattern, 0},
-       {MAP_SIZE, MADV_NORMAL, MADV_WIPEONFORK, zero,    1},
-       {MAP_SIZE, MADV_WIPEONFORK, MADV_KEEPONFORK, pattern, 0},
+       {MAP_SIZE, MADV_NORMAL, MADV_WIPEONFORK, zero,    0,
+       "MADV_WIPEONFORK zeroes memory in child"},
+       {0,        MADV_NORMAL, MADV_WIPEONFORK, pattern, 0,
+       "MADV_WIPEONFORK with zero length does nothing"},
+       {MAP_SIZE, MADV_NORMAL, MADV_WIPEONFORK, zero,    1,
+       "MADV_WIPEONFORK zeroes memory in grand-child"},
+       {MAP_SIZE, MADV_WIPEONFORK, MADV_KEEPONFORK, pattern, 0,
+       "MADV_KEEPONFORK will undo MADV_WIPEONFORK"},
 };

 static void cmp_area(char *addr, const struct test_case *tc)
@@ -91,12 +88,14 @@

        for (i = 0; i < tc->size; i++) {
                if (addr[i] != tc->exp[i]) {
-                       tst_res(TFAIL, "In PID : %d Failed match", getpid());
+                       tst_res(TFAIL, "In PID %d, addr[%d] = 0x%02x, "
+                               "expected[%d] = 0x%02x", getpid(),
+                               i, addr[i], i, tc->exp[i]);
                        break;
                }
        }

-       tst_res(TPASS, "In PID : %d Matched expected pattern", getpid());
+       tst_res(TPASS, "In PID %d, Matched expected pattern", getpid());
 }

 static int set_advice(char *addr, int size, int advise)
@@ -104,14 +103,13 @@
        TEST(madvise(addr, size, advise));

        if (TEST_RETURN == -1) {
-               tst_res(TFAIL | TTERRNO, "failed :madvise(%p, %d, 0x%x)",
-                               addr, size, advise);
+               tst_res(TFAIL | TTERRNO, "madvise(%p, %d, 0x%x)",
+                       addr, size, advise);

                return 1;
        }

-       tst_res(TINFO, "success :madvise(%p, %d, 0x%x)",
-                       addr, size, advise);
+       tst_res(TPASS, "madvise(%p, %d, 0x%x)", addr, size, advise);
        return 0;
 }

@@ -137,13 +135,11 @@

        addr = mem_map();

+       tst_res(TINFO, "%s", tc->desc);
        if (set_advice(addr, tc->size, tc->advise1))
                goto un_map;

        if (!set_advice(addr, tc->size, tc->advise2)) {
-               tst_res(TINFO, "In %s process",
-                               tc->grand_child ? "grand_child" : "child");
-
                pid = SAFE_FORK();

                if (!pid) {
@@ -171,7 +167,7 @@
        unsigned int i;

        for (i = 0; i < MAP_SIZE; i++)
-               pattern[i] = i % 0x02;
+               pattern[i] = i % 0x03;
 }
                               
