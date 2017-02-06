From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  6 Feb 2017 13:13:44 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
Message-ID: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current check function looks for frequency of returned
bytes, which sometimes fail for small buffers, where
one byte repeats.

For example, when getrandom() returns 10 bytes, and one byte
repeats we fail on this check:
	if (max > 0 && table[i] > max)

This patch is replacing it with more relaxed condition:
if at least one byte is non-zero, we consider it a success.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/getrandom/getrandom02.c | 46 ++++++-----------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index 0ac8bd28aed0..2b30c7f49f86 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -38,14 +38,11 @@ static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
 int TST_TOTAL = ARRAY_SIZE(modes);
 
 static unsigned char buf[256];
-static size_t size = 256;
-
-static void fill(void);
-static int check_content(int nb);
+int size = sizeof(buf);
 
 int main(int ac, char **av)
 {
-	int lc, i;
+	int lc, i, j, tmp;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
@@ -53,7 +50,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
-			fill();
+			memset(buf, '\0', size);
 
 			do {
 				TEST(ltp_syscall(__NR_getrandom, buf, size,
@@ -61,38 +58,19 @@ int main(int ac, char **av)
 			} while ((modes[i] & GRND_NONBLOCK) && TEST_RETURN == -1
 				&& TEST_ERRNO == EAGAIN);
 
-			if (!check_content(TEST_RETURN))
+			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL | TTERRNO, "getrandom failed");
-			else
+			} else {
 				tst_resm(TPASS, "getrandom returned %ld",
 						TEST_RETURN);
+				tmp = 0;
+				for (j = 0; j < TEST_RETURN; j++)
+					tmp |= buf[j];
+				if (tmp == 0)
+					tst_resm(TWARN, "all bytes from random"
+						" buffer are zero?");
+			}
 		}
 	}
 	tst_exit();
 }
-
-static void fill(void)
-{
-	memset(buf, '\0', sizeof(buf));
-}
-
-static int check_content(int nb)
-{
-	int table[256];
-	int i, index, max;
-
-	memset(table, 0, sizeof(table));
-
-	max = nb * 0.10;
-
-	for (i = 0; i < nb; i++) {
-		index = buf[i];
-		table[index]++;
-	}
-
-	for (i = 0; i < nb; i++) {
-		if (max > 0 && table[i] > max)
-			return 0;
-	}
-	return 1;
-}
-- 
1.8.3.1

