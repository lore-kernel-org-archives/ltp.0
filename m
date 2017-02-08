From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 16:08:30 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/4] getrandom03: Convert to the new
	library.
In-Reply-To: <20170208150831.4529-1-chrubis@suse.cz>
References: <20170208150831.4529-1-chrubis@suse.cz>
Message-ID: <20170208150831.4529-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also use hardcoded table of sizes instead of random().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getrandom/getrandom03.c | 47 +++++++++++++----------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 03950e0..e754ca3 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -32,33 +32,38 @@
 
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
-#include "test.h"
+#include "tst_test.h"
 
 #define MAX_SIZE 256
 
-char *TCID = "getrandom03";
-int TST_TOTAL = 5;
+static unsigned int sizes[] = {
+	1,
+	2,
+	3,
+	7,
+	8,
+	15,
+	22,
+	64,
+	127,
+};
 
-static char buf[256];
-
-int main(int ac, char **av)
+static void verify_getrandom(unsigned int n)
 {
-	int lc, i;
-	long size;
+	char buf[MAX_SIZE];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(tst_syscall(__NR_getrandom, buf, sizes[n], 0));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++) {
-			size = random() % MAX_SIZE;
-			TEST(ltp_syscall(__NR_getrandom, buf, size, 0));
-			if (TEST_RETURN != size)
-				tst_resm(TFAIL | TTERRNO, "getrandom failed");
-			else
-				tst_resm(TPASS, "getrandom returned %ld",
-					TEST_RETURN);
-		}
+	if (TEST_RETURN != sizes[n]) {
+		tst_res(TFAIL | TTERRNO, "getrandom returned %li, expected %u",
+			TEST_RETURN, sizes[n]);
+	} else {
+		tst_res(TPASS, "getrandom returned %ld", TEST_RETURN);
 	}
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tid = "getrandom03",
+	.tcnt = ARRAY_SIZE(sizes),
+	.test = verify_getrandom,
+};
-- 
2.10.2

