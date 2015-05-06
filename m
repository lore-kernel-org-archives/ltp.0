Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1YqFYB-0001kn-9A
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 06:44:51 +0000
Received: from e17.ny.us.ibm.com ([129.33.205.207])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YqFYA-00057V-60
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 06:44:51 +0000
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 7 May 2015 02:44:44 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
	[9.57.198.27])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6467C38C8039
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 May 2015 02:44:42 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t476igYH61538424
	for <ltp-list@lists.sourceforge.net>; Thu, 7 May 2015 06:44:42 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t476ifk4006438
	for <ltp-list@lists.sourceforge.net>; Thu, 7 May 2015 02:44:41 -0400
Received: from localhost.localdomain ([9.78.168.230])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t476ievC006396
	for <ltp-list@lists.sourceforge.net>; Thu, 7 May 2015 02:44:41 -0400
Date: Wed, 6 May 2015 21:55:04 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20150506135504.GC2752@localhost.localdomain>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150504115324.GB7674@rei.suse.de>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
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

On Mon, May 04, 2015 at 01:53:26PM +0200, Cyril Hrubis wrote:
> What about creating a test directory in test temporary directory
> unconditionally and change the TEST_FILE to point to a file in it? That
> way we can just mount the loop device over the directory if needed and
> avoid the ugly chdir here and in the cleanup.
> 
> This should rather be tst_resm(TWARN | TERRNO, ...) so that we at least
> attempt to continue the cleanup.
> 

Thanks. I have revised the patch according to your suggestions.


From 1cdaff6a5658a544f0968ec3e336ffff191ebc30 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 4 May 2015 13:44:51 +0800
Subject: [PATCH] performing test on loop device if noatime or relatime
 specified

After 2.6.30, kernel specifies relatime option by default. If so then
try to mount a loop device using strictatime option to do the noatime
test.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/open/open12.c | 40 ++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 54ddfe0..fdc81bb 100644
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
@@ -31,11 +32,17 @@
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 
-#define TEST_FILE	"test_file"
+#define MNTPOINT	"mntpoint"
+#define TEST_FILE	MNTPOINT"/test_file"
 #define LARGE_FILE	"large_file"
 
+#define DIR_MODE 0755
+
 char *TCID = "open12";
 
+static const char *device;
+static unsigned int mount_flag = 0;
+
 static void setup(void);
 static void cleanup(void);
 static void test_append(void);
@@ -75,6 +82,8 @@ static void setup(void)
 
 	tst_tmpdir();
 
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+
 	SAFE_FILE_PRINTF(cleanup, TEST_FILE, TEST_FILE);
 }
 
@@ -114,10 +123,18 @@ static void test_noatime(void)
 	}
 
 	if (tst_path_has_mnt_flags(cleanup, NULL, flags)) {
-		tst_resm(TCONF,
-			 "test O_NOATIME flag for open needs filesystems which "
-			 "is mounted without noatime and relatime");
-		return;
+
+		const char *fs_type = tst_dev_fs_type();
+		device = tst_acquire_device(cleanup);
+
+		if (!device)
+			tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+
+		tst_mkfs(cleanup, device, fs_type, NULL);
+
+		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
+		mount_flag = 1;
+		SAFE_FILE_PRINTF(cleanup, TEST_FILE, TEST_FILE);
 	}
 
 	SAFE_STAT(cleanup, TEST_FILE, &old_stat);
@@ -138,6 +155,13 @@ static void test_noatime(void)
 		tst_resm(TPASS, "test O_NOATIME for open success");
 	else
 		tst_resm(TFAIL, "test O_NOATIME for open failed");
+
+	if (mount_flag) {
+		mount_flag = 0;
+
+		if (tst_umount(MNTPOINT) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "umount(2) failed");
+	}
 }
 
 static void test_cloexec(void)
@@ -221,5 +245,11 @@ static void test_largefile(void)
 
 static void cleanup(void)
 {
+	if (mount_flag && tst_umount(MNTPOINT) == -1)
+		tst_brkm(TWARN | TERRNO, NULL, "umount(2) failed");
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
