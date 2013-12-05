Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VoYSJ-00057a-Ey
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:54:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoYS3-0003Nh-RQ
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 12:54:59 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB5CsajU030485
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 20:54:36 +0800
Message-ID: <1386248072.1542.12.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 20:54:32 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 4/4] fallocate/fallocate02.c: add EFBIG
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
To: ltp-list <ltp-list@lists.sourceforge.net>

add error with EFBIG for fallocate(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                  |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c | 55 +++++++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 12bae10..e561175 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -150,7 +150,7 @@ faccessat01 faccessat01
 
 #fallocate test cases
 fallocate01 fallocate01
-fallocate02 fallocate02
+fallocate02 fallocate02 -D DEVICE
 fallocate03 fallocate03
 
 #posix_fadvise test cases
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 8838cff..981a142 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -34,6 +34,7 @@
 #include <fcntl.h>
 #include <inttypes.h>
 #include <sys/utsname.h>
+#include <sys/mount.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -47,15 +48,34 @@
 #define	DEFAULT_TEST_MODE	1
 #endif
 #define OFFSET			12
+/*
+ * block_size is 1024, then the maximum file size is MAX_FILE * block_size: 4T
+ * block_size is 4096, then the maximum file size is MAX_FILE * block_size: 16T
+ */
+#define MAX_FILE		(4L*1024*1024*1024)
+#define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+				 S_IXGRP|S_IROTH|S_IXOTH)
 #define	FNAMER			"test_file1"
 #define	FNAMEW			"test_file2"
 
 static void setup(void);
 static void cleanup(void);
+static void help(void);
 
 static int fdw;
 static int fdr;
 static int block_size;
+/* Use ext4 default to test EFBIG */
+static char *fstype = "ext4";
+static char *device;
+static int dflag;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 
 static struct test_data_t {
 	int *fd;
@@ -72,6 +92,8 @@ static struct test_data_t {
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN-OFFSET, 1, 0},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILE, 1, EFBIG},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 0, MAX_FILE, EFBIG},
 };
 
 TCID_DEFINE(fallocate02);
@@ -83,10 +105,17 @@ int main(int ac, char **av)
 	int i;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -141,9 +170,17 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	fdr = SAFE_OPEN(cleanup, FNAMER, O_RDONLY | O_CREAT, S_IRUSR);
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
 
-	fdw = SAFE_OPEN(cleanup, FNAMEW, O_RDWR | O_CREAT, S_IRWXU);
+	fdr = SAFE_OPEN(cleanup, "mntpoint/"FNAMER,
+			O_RDONLY | O_CREAT, S_IRUSR);
+	fdw = SAFE_OPEN(cleanup, "mntpoint/"FNAMEW, O_RDWR | O_CREAT, S_IRWXU);
 
 	SAFE_FSTAT(cleanup, fdr, &file_stat);
 
@@ -156,5 +193,17 @@ static void cleanup(void)
 
 	SAFE_CLOSE(NULL, fdr);
 
+	if (mount_flag && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
 	tst_rmdir();
 }
+
+static void help(void)
+{
+	printf("-T type : specifies the type of filesystem to be mounted. "
+	       "Default ext4.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.8.2.1





------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
