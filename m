Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1YpCSY-0001Da-Om
	for ltp-list@lists.sourceforge.net; Mon, 04 May 2015 09:14:42 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YpCSX-0006OZ-UW
	for ltp-list@lists.sourceforge.net; Mon, 04 May 2015 09:14:42 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 4 May 2015 05:14:36 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
	[9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4B6926E803C
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 May 2015 05:06:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t449EYs965994960
	for <ltp-list@lists.sourceforge.net>; Mon, 4 May 2015 09:14:34 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t449EYQW028374
	for <ltp-list@lists.sourceforge.net>; Mon, 4 May 2015 05:14:34 -0400
Received: from localhost.localdomain ([9.83.26.204])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t449EXRt028336
	for <ltp-list@lists.sourceforge.net>; Mon, 4 May 2015 05:14:33 -0400
Date: Mon, 4 May 2015 14:34:25 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20150504063425.GA9995@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] performing test on loop device if noatime or relatime
 specified
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

Hi,

The noatime test of open12 fails on a distribution which doesn't
use tmpfs for /tmp. I have composed a patch to fix it. Please have a
look, thanks.

After 2.6.30, kernel specifies relatime option by default. If so then
try to mount a loop device using strictatime option to do the noatime
test.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/open/open12.c | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 54ddfe0..f9be35b 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 #include <unistd.h>
 #include <mntent.h>
 #include <errno.h>
@@ -34,8 +35,16 @@
 #define TEST_FILE	"test_file"
 #define LARGE_FILE	"large_file"
 
+#define DIR_MODE 0755
+#define MNTPOINT "mntpoint"
+
 char *TCID = "open12";
 
+static const char *device;
+static const char *fs_type;
+static unsigned int mount_flag = 0;
+static unsigned int cd_flag = 0;
+
 static void setup(void);
 static void cleanup(void);
 static void test_append(void);
@@ -114,10 +123,21 @@ static void test_noatime(void)
 	}
 
 	if (tst_path_has_mnt_flags(cleanup, NULL, flags)) {
-		tst_resm(TCONF,
-			 "test O_NOATIME flag for open needs filesystems which "
-			 "is mounted without noatime and relatime");
-		return;
+
+		fs_type = tst_dev_fs_type();
+		device = tst_acquire_device(cleanup);
+
+		if (!device)
+			tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+
+		tst_mkfs(cleanup, device, fs_type, NULL);
+
+		SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
+		mount_flag = 1;
+		SAFE_FILE_PRINTF(cleanup, MNTPOINT"/"TEST_FILE, TEST_FILE);
+		SAFE_CHDIR(cleanup, MNTPOINT);
+		cd_flag = 1;
 	}
 
 	SAFE_STAT(cleanup, TEST_FILE, &old_stat);
@@ -221,5 +241,18 @@ static void test_largefile(void)
 
 static void cleanup(void)
 {
+	if (cd_flag) {
+		char *tmp_dir = tst_get_tmpdir();
+		SAFE_CHDIR(NULL, tmp_dir);
+		free(tmp_dir);
+	}
+
+	if (mount_flag && tst_umount(MNTPOINT) == -1) {
+		tst_brkm(TBROK | TERRNO, NULL, "umount(2) failed");
+	}
+
+	if (device)
+		tst_release_device(NULL, device);
+
 	tst_rmdir();
 }
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
