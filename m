From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 23 Jan 2020 15:31:37 +0100
Subject: [LTP] [PATCH] Fix prctl02
Message-ID: <20200123143137.23214-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The prctl() system call takes 5 integer arguments but only 3 of them were
passed in the test. This means that the system call read random garbage
from stack in place of the two missing arguments and failed even on some
perfectly valid combinations of arguments on some platforms.

- Fixed arguments in test case 9 (second PR_SET_NO_NEW_PRIVS)
- Dropped test case 13 (PR_CAP_AMBIENT) because the args are valid
- Dropped test case 14 (PR_GET_SPECULATION_CTRL) because the args are valid
- Fixed test call of prctl() to have all 5 arguments

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
CC: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/prctl/prctl02.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 93f30b54a..7bf3684e5 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -23,13 +23,9 @@
  * arg4, arg5 is non-zero.
  * 12) prctl() fails with EINVAL when options is PR_GET_THP_DISABLE & arg2,
  * arg3, arg4, or arg5 is nonzero.
- * 13) prctl() fails with EINVAL when options is PR_CAP_AMBIENT & an unused
- * argument such as arg4 is nonzero.
- * 14) prctl() fails with EINVAL when option is PR_GET_SPECULATION_CTRL and
- * unused arguments is nonzero.
- * 15) prctl() fails with EPERM when option is PR_SET_SECUREBITS and the
+ * 13) prctl() fails with EPERM when option is PR_SET_SECUREBITS and the
  * caller does not have the CAP_SETPCAP capability.
- * 16) prctl() fails with EPERM when option is PR_CAPBSET_DROP and the caller
+ * 14) prctl() fails with EPERM when option is PR_CAPBSET_DROP and the caller
  * does not have the CAP_SETPCAP capability.
  */
 
@@ -87,12 +83,10 @@ static struct tcase {
 	{PR_SET_SECCOMP, &num_2, &strict_addr, EACCES, "PR_SET_SECCOMP"},
 	{PR_SET_TIMING, &num_1, &num_0, EINVAL, "PR_SET_TIMING"},
 	{PR_SET_NO_NEW_PRIVS, &num_0, &num_0, EINVAL, "PR_SET_NO_NEW_PRIVS"},
-	{PR_SET_NO_NEW_PRIVS, &num_1, &num_0, EINVAL, "PR_SET_NO_NEW_PRIVS"},
+	{PR_SET_NO_NEW_PRIVS, &num_1, &num_1, EINVAL, "PR_SET_NO_NEW_PRIVS"},
 	{PR_GET_NO_NEW_PRIVS, &num_1, &num_0, EINVAL, "PR_GET_NO_NEW_PRIVS"},
 	{PR_SET_THP_DISABLE, &num_0, &num_1, EINVAL, "PR_SET_THP_DISABLE"},
 	{PR_GET_THP_DISABLE, &num_1, &num_1, EINVAL, "PR_GET_THP_DISABLE"},
-	{PR_CAP_AMBIENT, &num_2, &num_1, EINVAL, "PR_CAP_AMBIENT"},
-	{PR_GET_SPECULATION_CTRL, &num_1, &num_0, EINVAL, "PR_GET_SPECULATION_CTRL"},
 	{PR_SET_SECUREBITS, &num_0, &num_0, EPERM, "PR_SET_SECUREBITS"},
 	{PR_CAPBSET_DROP, &num_1, &num_0, EPERM, "PR_CAPBSET_DROP"},
 };
@@ -140,7 +134,7 @@ static void verify_prctl(unsigned int n)
 	break;
 	}
 
-	TEST(prctl(tc->option, *tc->arg2, *tc->arg3));
+	TEST(prctl(tc->option, *tc->arg2, *tc->arg3, 0, 0));
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "prctl() succeeded unexpectedly");
 		return;
-- 
2.24.1

