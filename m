From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 16:08:31 +0100
Subject: [LTP] [COMMITTED] [PATCH 4/4] getrandom04: Convert to the new
	library.
In-Reply-To: <20170208150831.4529-1-chrubis@suse.cz>
References: <20170208150831.4529-1-chrubis@suse.cz>
Message-ID: <20170208150831.4529-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getrandom/getrandom04.c | 36 +++++++++++------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 10ab44b..0eae031 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -33,30 +33,28 @@
 #include <sys/resource.h>
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "getrandom04";
-int TST_TOTAL = 1;
-static char buf[128];
-
-int main(int ac, char **av)
+static void verify_getrandom(void)
 {
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	int r;
-
-	struct rlimit lim = {3, 3};
+	char buf[128];
+	struct rlimit lold, lnew;
 
-	r = setrlimit(RLIMIT_NOFILE, &lim);
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &lold);
+	lnew.rlim_max = lold.rlim_max;
+	lnew.rlim_cur = 3;
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &lnew);
 
-	if (r == -1)
-		tst_brkm(TBROK | TTERRNO, NULL, "setrlimit failed");
-
-	TEST(ltp_syscall(__NR_getrandom, buf, 100, 0));
+	TEST(tst_syscall(__NR_getrandom, buf, 100, 0));
 	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "getrandom failed");
+		tst_res(TFAIL | TTERRNO, "getrandom failed");
 	else
-		tst_resm(TPASS, "getrandom returned %ld", TEST_RETURN);
+		tst_res(TPASS, "getrandom returned %ld", TEST_RETURN);
 
-	tst_exit();
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &lold);
 }
+
+static struct tst_test test = {
+	.tid = "getrandom04",
+	.test_all = verify_getrandom,
+};
-- 
2.10.2

