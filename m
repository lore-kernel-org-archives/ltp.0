From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 16:08:29 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/4] getrandom02: Convert to the new
	library.
In-Reply-To: <20170208150831.4529-1-chrubis@suse.cz>
References: <20170208150831.4529-1-chrubis@suse.cz>
Message-ID: <20170208150831.4529-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getrandom/getrandom02.c | 69 ++++++++---------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index ec19f0f..ac20d79 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -29,54 +29,12 @@
 
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "getrandom02";
 static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
 		       GRND_RANDOM | GRND_NONBLOCK };
 
-int TST_TOTAL = ARRAY_SIZE(modes);
-
-static unsigned char buf[256];
-static size_t size = 256;
-
-static void fill(void);
-static int check_content(int nb);
-
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			fill();
-
-			do {
-				TEST(ltp_syscall(__NR_getrandom, buf, size,
-					modes[i]));
-			} while ((modes[i] & GRND_NONBLOCK) && TEST_RETURN == -1
-				&& TEST_ERRNO == EAGAIN);
-
-			if (!check_content(TEST_RETURN))
-				tst_resm(TFAIL | TTERRNO, "getrandom failed");
-			else
-				tst_resm(TPASS, "getrandom returned %ld",
-						TEST_RETURN);
-		}
-	}
-	tst_exit();
-}
-
-static void fill(void)
-{
-	memset(buf, '\0', sizeof(buf));
-}
-
-static int check_content(int nb)
+static int check_content(unsigned char *buf, int nb)
 {
 	int table[256];
 	int i, index, max;
@@ -96,3 +54,26 @@ static int check_content(int nb)
 	}
 	return 1;
 }
+
+static void verify_getrandom(unsigned int n)
+{
+	unsigned char buf[256];
+
+	memset(buf, 0, sizeof(buf));
+
+	do {
+		TEST(tst_syscall(__NR_getrandom, buf, sizeof(buf), modes[n]));
+	} while ((modes[n] & GRND_NONBLOCK) && TEST_RETURN == -1
+		  && TEST_ERRNO == EAGAIN);
+
+	if (!check_content(buf, TEST_RETURN))
+		tst_res(TFAIL | TTERRNO, "getrandom failed");
+	else
+		tst_res(TPASS, "getrandom returned %ld", TEST_RETURN);
+}
+
+static struct tst_test test = {
+	.tid = "getrandom02",
+	.tcnt = ARRAY_SIZE(modes),
+	.test = verify_getrandom,
+};
-- 
2.10.2

