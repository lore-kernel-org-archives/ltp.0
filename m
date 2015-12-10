From: Eryu Guan <eguan@redhat.com>
Date: Thu, 10 Dec 2015 19:38:22 +0800
Subject: [LTP] [PATCH] syscalls: avoid creating whiteout device in tests
Message-ID: <1449747502-29612-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A char device with major 0 and minor 0 is known as whiteout device, and
overlayfs refuses to create such device. mknod01 and mount02 fail on
overlayfs because of this restriction.

Fix it by creating null device instead.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/mknod/mknod01.c | 17 +++++++++++++----
 testcases/kernel/syscalls/mount/mount02.c |  8 ++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index 863d02d..a35adf9 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -66,6 +66,7 @@ int TST_TOTAL = ARRAY_SIZE(tcases);
 int main(int ac, char **av)
 {
 	int lc, i;
+	dev_t dev;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
@@ -75,17 +76,25 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
+			/*
+			 * overlayfs doesn't support mknod char device with
+			 * major 0 and minor 0, which is known as whiteout_dev
+			 */
+			if (S_ISCHR(tcases[i]))
+				dev = makedev(1, 3);
+			else
+				dev = 0;
 			TEST(mknod(PATH, tcases[i], 0));
 
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL,
-					 "mknod(%s, %#o, 0) failed, errno=%d : %s",
-					 PATH, tcases[i], TEST_ERRNO,
+					 "mknod(%s, %#o, %lu) failed, errno=%d : %s",
+					 PATH, tcases[i], dev, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
 			} else {
 				tst_resm(TPASS,
-					 "mknod(%s, %#o, 0) returned %ld",
-					 PATH, tcases[i], TEST_RETURN);
+					 "mknod(%s, %#o, %lu) returned %ld",
+					 PATH, tcases[i], dev, TEST_RETURN);
 			}
 
 			SAFE_UNLINK(cleanup, PATH);
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 85c050d..916c35e 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -170,6 +170,8 @@ static void do_umount(void)
 
 static void setup(void)
 {
+	dev_t dev;
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_require_root();
@@ -190,9 +192,11 @@ static void setup(void)
 
 	memset(path, 'a', PATH_MAX + 1);
 
-	if (mknod(char_dev, S_IFCHR | FILE_MODE, 0)) {
+	dev = makedev(1, 3);
+	if (mknod(char_dev, S_IFCHR | FILE_MODE, dev)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-		         "failed to mknod(char_dev, S_IFCHR | FILE_MODE, 0)");
+			 "failed to mknod(char_dev, S_IFCHR | FILE_MODE, %lu)",
+			 dev);
 	}
 
 	TEST_PAUSE;
-- 
2.5.0

