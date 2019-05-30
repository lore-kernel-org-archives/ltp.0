From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 18:23:35 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_test: introduce tst_test->some_filesystems
Message-ID: <20190530102336.10898-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Like all_filesystems, some_filesystems option let tcase to run on
specific filesystems.
In order to implement this, change run_tcases_per_fs to accept a
parameter indicating which filesystems need to test.

To let tcase use this option, we need some other flags set
Eg:
static char *some_filesystems[] = {"ext4", "xfs", "btrfs"};

  .mount_device = 0,
  .needs_device = 1,
  .format_device = 1,
  .mntpoint = MNTPOINT,
  .some_filesystems = some_filesystems,

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index e4b935c45..8dc4fb6b4 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -137,6 +137,7 @@ struct tst_test {
 	 * to the test function.
 	 */
 	int all_filesystems:1;
+	char **some_filesystems;
 
 	/*
 	 * If set non-zero denotes number of test variant, the test is executed
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d88adbd7..72260f027 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -867,7 +867,7 @@ static void do_setup(int argc, char *argv[])
 		else
 			tdev.fs_type = tst_dev_fs_type();
 
-		if (!tst_test->all_filesystems)
+		if (!tst_test->all_filesystems && !tst_test->some_filesystems)
 			prepare_device();
 	}
 
@@ -1143,11 +1143,11 @@ static int fork_testrun(void)
 	return 0;
 }
 
-static int run_tcases_per_fs(void)
+static int run_tcases_per_fs(char **fses)
 {
 	int ret = 0;
 	unsigned int i;
-	const char *const *filesystems = tst_get_supported_fs_types();
+	const char *const *filesystems = fses;
 
 	if (!filesystems[0])
 		tst_brk(TCONF, "There are no supported filesystems");
@@ -1202,8 +1202,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
 		if (tst_test->all_filesystems)
-			ret |= run_tcases_per_fs();
-		else
+			ret |= run_tcases_per_fs(tst_get_supported_fs_types());
+		else if (tst_test->some_filesystems) {
+			tst_test->mount_device = 1;
+			ret |= run_tcases_per_fs(tst_test->some_filesystems);
+		} else
 			ret |= fork_testrun();
 
 		if (ret & ~(TCONF))
-- 
2.21.0

