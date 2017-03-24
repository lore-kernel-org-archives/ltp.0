From: charishma <charishm@linux.vnet.ibm.com>
Date: Fri, 24 Mar 2017 11:26:05 +0530
Subject: [LTP] [PATCH] Fix sbrk02 failure on ia32 architecture
Message-ID: <b0668bef-6906-8c74-bbed-a2374d16a9c7@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sbrk02 is failing on ia32 architecture, where as this test passed in 
other arch's.

when we check the sbrk02 with below increment value #define INC 
16*1024*1024 the error
  condition "(void *) -1" met but the errno show the success. below 
output will
  show fail condition.

value of increment:: 369098752 return value 0xdb63f000

errno:: 0sbrk02 0 TINFO : setup() bailing inc: 385875968, ret: 
0xffffffff, sbrk: 0xf063f000:

errno=SUCCESS(0): Success
sbrk_verify:: 385875968
sbrk02 1 TFAIL : sbrk02.c:110: sbrk(385875968) failed unexpectedly; 
expected: 12 - Cannot allocate memory: TEST_ERRNO=SUCCESS(0): Success

Solution Details:
Since it was failing when the loop check for return value but error 
condition doesn't met 0, So added the loop to check the reverse 
condition ie errno == 0.

Signed-off-by  :  Anup Kumar <anupkumk@in.ibm.com>
Signed-off-by  :  Charishma M <charism2@in.ibm.com>

---
  testcases/kernel/syscalls/sbrk/sbrk02.c | 12 +++++++++++-
  1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c 
b/testcases/kernel/syscalls/sbrk/sbrk02.c
index 84744ef..60ade4b 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -21,6 +21,7 @@

  #include <errno.h>
  #include <unistd.h>
+#include <sys/types.h>
  #include "test.h"

  #define INC 16*1024*1024
@@ -55,13 +56,21 @@ int main(int argc, char *argv[])

  static void setup(void)
  {
-    void *ret = NULL;

      tst_sig(NOFORK, DEF_HANDLER, cleanup);

      TEST_PAUSE;

      /* call sbrk until it fails or increment overflows */
+
+#if defined(__i386__)
+
+        for (increment = INC; errno == 0; increment++)
+        sbrk(increment);
+        tst_resm(TINFO | TERRNO, "setup() bailing inc: %ld, sbrk: %p",
+                increment, sbrk(0));
+#else
+    void *ret = NULL;
      while (ret != (void *)-1 && increment > 0) {
          ret = sbrk(increment);
          increment += INC;
@@ -70,6 +79,7 @@ static void setup(void)
          increment, ret, sbrk(0));

      errno = 0;
+#endif
  }

  static void sbrk_verify(void)
-- 
2.5.5

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170324/b714d68d/attachment.html>
