Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YNHtd-0007pP-Lw
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 09:23:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YNHtb-0003q2-GM
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 09:23:17 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1G9MIeB012987
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Feb 2015 17:22:19 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Mon, 16 Feb 2015 17:22:29 +0800
Message-ID: <1424078549-26772-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] doc: fix spelling mistakes in manuals
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

These mistakes cann't lead to trouble for reading,
but the correct spelling is more better for beginners
to understand it.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 doc/style-guide.txt             |  6 +++---
 doc/test-writing-guidelines.txt | 10 +++++-----
 doc/tpm-commands.txt            |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index aada028..3a7c4ad 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -232,7 +232,7 @@ Don't use +linux/+ headers if at all possible. Usually they are replaced with
 headers get shuffled around a lot more than their +sys/+ counterparts it
 seems.
 
-15. Singnal handlers
+15. Signal handlers
 ~~~~~~~~~~~~~~~~~~~~
 
 Avoid doing tricky things in signal handlers. Calling most of the libc
@@ -294,7 +294,7 @@ New Testcases
 Do not use obvious comments ("child process", "parse options", etc). This
 leads to visual comment noise pollution.
 
-4. Inline assigments
+4. Inline assignments
 ~~~~~~~~~~~~~~~~~~~~
 
 Don't do inline assignment, i.e.
@@ -316,7 +316,7 @@ The only exception to this is when you define global variables.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Your testcase should be runnable as root and non-root. What does that mean? It
-should fail gracefull as non-root if it has insufficient privileges, or use
+should fail gracefully as non-root if it has insufficient privileges, or use
 +tst_require_root(NULL)+ if root access is absolutely required.
 
 A lot of newer testcases don't honor this fact and it causes random
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6660b28..a3d5cb5 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -727,7 +727,7 @@ There are certain cases where the test needs a kernel part and userspace part,
 happily, LTP can build a kernel module and then insert it to the kernel on test
 start for you. See 'testcases/kernel/device-drivers/block' for details.
 
-2.2.11 Usefull macros
+2.2.11 Useful macros
 ^^^^^^^^^^^^^^^^^^^^^
 
 [source,c]
@@ -775,7 +775,7 @@ below:
 	case TST_NFS_MAGIC:
 	case TST_TMPFS_MAGIC:
 	case TST_RAMFS_MAGIC:
-		tst_brkm(TCONF, cleanup, "Test not supported on %s filesytem",
+		tst_brkm(TCONF, cleanup, "Test not supported on %s filesystem",
 		         tst_fs_type_name(type));
 	break;
 	}
@@ -951,7 +951,7 @@ int tst_fs_fill_subdirs(void (*cleanup)(void), const char *dir);
 Try to get maximum number of subdirectories in directory.
 
 NOTE: This number depends on the filesystem 'dir' is on. For current kernel,
-subdir limit is not availiable for all filesystems (availiable for ext2, ext3,
+subdir limit is not available for all filesystems (available for ext2, ext3,
 minix, sysv and more). If the test runs on some other filesystems, like ramfs,
 tmpfs, it will not even try to reach the limit and return 0.
 
@@ -1029,7 +1029,7 @@ ret=$?
 if [ $ret -eq 0 ]; then
 	tst_resm TPASS "true returned 0"
 else
-	tst_resm TFAIL "true rturned $ret"
+	tst_resm TFAIL "true returned $ret"
 fi
 
 tst_exit
@@ -1046,7 +1046,7 @@ WARNING: Do not forget to add the 'tst_exit' at the end of the test,
 2.3.2 Basic test interface
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Following functions similar to the LTP C intearface are available.
+Following functions similar to the LTP C interface are available.
 
 * tst_resm()
 * tst_brkm()
diff --git a/doc/tpm-commands.txt b/doc/tpm-commands.txt
index 4982a6b..59a4324 100644
--- a/doc/tpm-commands.txt
+++ b/doc/tpm-commands.txt
@@ -5,7 +5,7 @@ ar01
 	Construct one or more command lines which use options that do not
 	take arguments
 	For each of these invocations
-	Specify the options seperately
+	Specify the options separately
 	Group the options together
 	Compare the behavior of the two cases
 	If they behave differently, then fail
-- 
1.9.3


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
