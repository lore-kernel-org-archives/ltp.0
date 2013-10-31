Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VbhnA-0004Yu-K2
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 02:15:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vbhn9-0004rI-5a
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 02:15:24 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9V2FDxT027063
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 10:15:15 +0800
Message-ID: <5271BD29.6080701@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 10:15:05 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] chroot/chroot03.c: add ELOOP error value test for
	chroot(2)
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


Subject: [PATCH] chroot/chroot03.c: add ELOOP error value test for chroot(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chroot/chroot03.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index c34d8ea..a4cd209 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -43,6 +43,10 @@
  *		The pathname parameter to chroot() points to an invalid address,
  *		chroot(2) fails with EPERM.
  *
+ *	5.	Test for ELOOP:
+ *		Too many symbolic links were encountered When resolving the
+ *		pathname parameter.
+ *
  * USAGE:  <for command-line>
  *  chroot03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
  *     where,  -c n : Run n copies concurrently.
@@ -66,6 +70,7 @@
 #include "test.h"
 #include "usctest.h"
 #include <fcntl.h>
+#include "safe_macros.h"
 
 char *TCID = "chroot03";
 
@@ -74,8 +79,9 @@ char fname[255];
 char good_dir[100] = "/tmp/testdir";
 char bad_dir[] =
     "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+char symbolic_dir[] = "sym_dir1";
 
-int exp_enos[] = { ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT, 0 };
+int exp_enos[] = { ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT, ELOOP, 0 };
 
 struct test_case_t {
 	char *dir;
@@ -105,8 +111,9 @@ struct test_case_t {
 	     * and expect EFAULT as errno
 	     */
 	{
-	(char *)-1, EFAULT}
+	(char *)-1, EFAULT},
 #endif
+	{symbolic_dir, ELOOP}
 };
 
 int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
@@ -196,6 +203,12 @@ void setup()
 	}
 	TC[3].dir = bad_addr;
 #endif
+	/*
+	 * create two symbolic directory who point to each other to
+	 * test ELOOP.
+	 */
+	SAFE_SYMLINK(cleanup, "sym_dir1/", "sym_dir2");
+	SAFE_SYMLINK(cleanup, "sym_dir2/", "sym_dir1");
 }
 
 /*
-- 
1.8.2.1

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
