From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 16:08:28 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/4] getrandom01: Convert to the new
	library.
Message-ID: <20170208150831.4529-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getrandom/getrandom01.c | 40 +++++++++--------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index 103748a..7c7ed94 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -28,33 +28,25 @@
 
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "getrandom01";
-static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
-		       GRND_RANDOM | GRND_NONBLOCK };
+static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
+		      GRND_RANDOM | GRND_NONBLOCK};
 
-int TST_TOTAL = ARRAY_SIZE(modes);
-
-int main(int ac, char **av)
+static void verify_getrandom(unsigned int n)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(tst_syscall(__NR_getrandom, NULL, 100, modes[n]));
 
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ltp_syscall(__NR_getrandom, NULL, 100, modes[i]));
-			if (TEST_RETURN == -1) {
-				tst_resm(TPASS, "getrandom returned %ld",
-						TEST_RETURN);
-			} else {
-				tst_resm(TFAIL | TTERRNO, "getrandom failed");
-			}
-		}
+	if (TEST_RETURN == -1) {
+		tst_res(TPASS | TTERRNO, "getrandom returned %ld",
+			TEST_RETURN);
+	} else {
+		tst_res(TFAIL | TTERRNO, "getrandom failed");
 	}
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tid = "getrandom01",
+	.tcnt = ARRAY_SIZE(modes),
+	.test = verify_getrandom,
+};
-- 
2.10.2

