Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vabgq-0001PH-SH
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 01:32:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vabgp-00063h-2v
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 01:32:20 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9S1W8pT009007
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Oct 2013 09:32:09 +0800
Message-ID: <526DBE96.1060902@cn.fujitsu.com>
Date: Mon, 28 Oct 2013 09:32:06 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] chdir/chdir01.c: Add ELOOP error number test
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

Add ELOOP error number test in chdir01.c for chdir(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 04fb8b4..c4e74fb 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -59,9 +59,9 @@
 #include "safe_macros.h"
 
 char *TCID = "chdir01";
-int TST_TOTAL = 1;
+int TST_TOTAL = 2;
 
-int exp_enos[] = { ENOTDIR, 0 };
+int exp_enos[] = { ENOTDIR, ELOOP, 0 };
 
 void setup(void);
 void cleanup(void);
@@ -120,6 +120,23 @@ int main(int ac, char **av)
 
 		SAFE_CHDIR(cleanup, "..");
 
+		/* ELOOP */
+		SAFE_SYMLINK(cleanup, "test_eloop1", "test_eloop2");
+		SAFE_SYMLINK(cleanup, "test_eloop2", "test_eloop1");
+
+		TEST(chdir("test_eloop1"));
+
+		if (TEST_RETURN != -1) {
+			tst_resm(TFAIL, "call succeeded unexpectedly");
+		} else if (TEST_ERRNO != ELOOP) {
+			tst_resm(TFAIL | TTERRNO,
+				 "failed unexpectedly; wanted ELOOP");
+		} else {
+			tst_resm(TPASS, "failed as expected with ELOOP");
+		}
+
+		SAFE_UNLINK(cleanup, "test_eloop1");
+		SAFE_UNLINK(cleanup, "test_eloop2");
 	}
 	cleanup();
 
-- 
1.8.2.1



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
