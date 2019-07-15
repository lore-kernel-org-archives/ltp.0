From: Tobias Jordan <knilch-ltp@cdqe.de>
Date: Mon, 15 Jul 2019 14:37:21 +0200
Subject: [LTP] [PATCH] syscalls/chdir/chdir04.c: fix out-of-bounds write
Message-ID: <20190715123721.gnsrcu6xpjrdng6p@agrajag.zerfleddert.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When UCLINUX is defined, line 156 will write to the TC[2].dname:
    #ifdef UCLINUX
        [...]
        TC[2].dname = bad_addr;
    #endif

However, TC[2] won't exist as it's only initialized when UCLINUX is
not defined and length of TC is implicit. Remove "#ifndef UCLINUX"
around initializer for TC[2].

Signed-off-by: Tobias Jordan <knilch-ltp@cdqe.de>
---
original posted as github PR:
https://github.com/linux-test-project/ltp/pull/543

 testcases/kernel/syscalls/chdir/chdir04.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index 9e0a9e9d0..f0420e4c9 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -83,14 +83,12 @@ struct test_case_t {
 	     */
 	{
 	noexist_dir, ENOENT},
-#ifndef UCLINUX
 	    /*
 	     * to test whether chdir() is setting EFAULT if the
 	     * directory is an invalid address.
 	     */
 	{
 	(void *)-1, EFAULT}
-#endif
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
-- 
2.11.0

