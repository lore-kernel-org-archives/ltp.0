Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WtuBY-0003DP-RK
	for ltp-list@lists.sourceforge.net; Mon, 09 Jun 2014 07:40:05 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WtuBV-0007EP-VV
	for ltp-list@lists.sourceforge.net; Mon, 09 Jun 2014 07:40:04 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s597drU3008669
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Jun 2014 15:39:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 9 Jun 2014 15:37:11 +0800
Message-ID: <1402299431-2045-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] linkat/linkat02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Remove the check against XFS when testing EMLINK error value.
Using the new interface provided by lib/tst_fs_link_count.c.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/linkat/linkat02.c | 58 ++++++-----------------------
 1 file changed, 11 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index b899fa6..9fac935 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -36,7 +36,6 @@
 #include "linux_syscall_numbers.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "tst_fs_type.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
@@ -47,7 +46,7 @@
 #define TEST_EACCES2	"./tmp/testeeacces2"
 #define TEST_EROFS	"mntpoint"
 #define TEST_EROFS2	"mntpoint/testerofs2"
-#define TEST_EMLINK	"mntpoint/testemlink"
+#define TEST_EMLINK	"emlink_dir/testfile1"
 #define BASENAME	"mntpoint/basename"
 
 static char lname[PATH_MAX];
@@ -55,13 +54,13 @@ static char nametoolong[PATH_MAX+2];
 static char *fstype = "ext2";
 static char *device;
 static int mount_flag;
+static int max_hardlinks;
 
 static void setup(void);
 static void cleanup(void);
 static void setup_eacces(void);
 static void cleanup_eacces(void);
 static void setup_erofs(void);
-static void setup_emlink(void);
 static void help(void);
 
 static option_t options[] = {
@@ -84,7 +83,7 @@ static struct test_struct {
 	{TEST_ELOOP, TEST_FILE, AT_SYMLINK_FOLLOW, ELOOP, NULL, NULL},
 	{TEST_EACCES, TEST_EACCES2, 0, EACCES, setup_eacces, cleanup_eacces},
 	{TEST_EROFS, TEST_EROFS2, 0, EROFS, setup_erofs, NULL},
-	{TEST_EMLINK, lname, 0, EMLINK, setup_emlink, NULL},
+	{TEST_EMLINK, lname, 0, EMLINK, NULL, NULL},
 };
 
 char *TCID = "linkat02";
@@ -96,8 +95,6 @@ static void linkat_verify(const struct test_struct *);
 static int exp_enos[] = { ENAMETOOLONG, EEXIST, ELOOP,
 			  EACCES, EROFS, EMLINK, 0 };
 
-static long fs_type;
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -130,14 +127,13 @@ int main(int ac, char **av)
 
 static void linkat_verify(const struct test_struct *desc)
 {
+	if (desc->expected_errno == EMLINK && max_hardlinks == 0) {
+		tst_resm(TCONF, "EMLINK test is not appropriate");
+		return;
+	}
+
 	if (desc->setupfunc != NULL) {
-		if (desc->setupfunc == setup_emlink &&
-		    fs_type == TST_XFS_MAGIC) {
-			tst_resm(TCONF, "Test skipped XFS filesystem.");
-			return;
-		} else {
-			desc->setupfunc();
-		}
+		desc->setupfunc();
 	}
 
 	TEST(ltp_syscall(__NR_linkat, AT_FDCWD, desc->oldfname,
@@ -166,8 +162,6 @@ static void linkat_verify(const struct test_struct *desc)
 
 static void setup(void)
 {
-	long link_max = 0;
-
 	if ((tst_kvercmp(2, 6, 16)) < 0)
 		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
 
@@ -202,38 +196,8 @@ static void setup(void)
 	}
 	mount_flag = 1;
 
-	SAFE_TOUCH(cleanup, TEST_EMLINK, 0666, NULL);
-
-	fs_type = tst_fs_type(cleanup, "mntpoint");
-	if (fs_type == TST_XFS_MAGIC)
-		return;
-
-	while (1) {
-		sprintf(lname, "%s%ld", BASENAME, ++link_max);
-		TEST(link(TEST_EMLINK, lname));
-		if (TEST_RETURN == -1) {
-			switch (TEST_ERRNO) {
-			case EMLINK:
-				tst_resm(TINFO, "for %s the max links is %ld",
-					 fstype, link_max);
-				break;
-			default:
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "Unexpected error: ");
-				break;
-			}
-			break;
-		}
-	}
-}
-
-static void setup_emlink(void)
-{
-	if (mount(device, "mntpoint", fstype, MS_REMOUNT, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "remount device:%s failed", device);
-	}
-	mount_flag = 1;
+	SAFE_MKDIR(cleanup, "emlink_dir", DIR_MODE);
+	max_hardlinks = tst_fs_fill_hardlinks(cleanup, "emlink_dir");
 }
 
 static void setup_eacces(void)
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://www.hpccsystems.com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
