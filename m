From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 23 Jan 2020 16:18:36 +0100
Subject: [LTP] [PATCH v2] Fix prctl02
In-Reply-To: <239304412.3515101.1579791334045.JavaMail.zimbra@redhat.com>
References: <239304412.3515101.1579791334045.JavaMail.zimbra@redhat.com>
Message-ID: <20200123151836.29484-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The prctl() system call takes 5 integer arguments but only 3 of them were
passed in the test. This means that the system call read random garbage
from stack in place of the two missing arguments and failed even on some
perfectly valid combinations of arguments on some platforms.

- Change num_invalid to ULONG_MAX
- Fix arguments in test case 9, 13 and 14
- Fix test call of prctl() to have all 5 arguments

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
CC: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---

Changes since v1:
- Change num_invalid to ULONG_MAX
- Return removed test cases and fix them instead

 testcases/kernel/syscalls/prctl/prctl02.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 93f30b54a..ebc0e5060 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -41,6 +41,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stddef.h>
+#include <limits.h>
 #include "config.h"
 #include "lapi/prctl.h"
 #include "lapi/seccomp.h"
@@ -65,7 +66,7 @@ static unsigned long bad_addr;
 static unsigned long num_0;
 static unsigned long num_1 = 1;
 static unsigned long num_2 = 2;
-static unsigned long num_invalid = 999;
+static unsigned long num_invalid = ULONG_MAX;
 static int seccomp_nsup;
 static int nonewprivs_nsup;
 static int thpdisable_nsup;
@@ -87,12 +88,12 @@ static struct tcase {
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
+	{PR_CAP_AMBIENT, &num_invalid, &num_0, EINVAL, "PR_CAP_AMBIENT"},
+	{PR_GET_SPECULATION_CTRL, &num_0, &num_invalid, EINVAL, "PR_GET_SPECULATION_CTRL"},
 	{PR_SET_SECUREBITS, &num_0, &num_0, EPERM, "PR_SET_SECUREBITS"},
 	{PR_CAPBSET_DROP, &num_1, &num_0, EPERM, "PR_CAPBSET_DROP"},
 };
@@ -140,7 +141,7 @@ static void verify_prctl(unsigned int n)
 	break;
 	}
 
-	TEST(prctl(tc->option, *tc->arg2, *tc->arg3));
+	TEST(prctl(tc->option, *tc->arg2, *tc->arg3, 0, 0));
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "prctl() succeeded unexpectedly");
 		return;
-- 
2.24.1

