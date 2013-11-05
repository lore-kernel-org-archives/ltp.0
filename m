Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VdWA4-000353-HV
	for ltp-list@lists.sourceforge.net; Tue, 05 Nov 2013 02:14:32 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdWA2-0004s7-Q0
	for ltp-list@lists.sourceforge.net; Tue, 05 Nov 2013 02:14:32 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Tue, 5 Nov 2013 11:14:21 +0900
Message-ID: <02cb01ced9cc$bd9d6e10$38d84a30$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] acct01: add a check routine for acct implmentation
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

A check routine for acct implemation is added at the beginning of the test.
check_acct_in_kernel function calls acct(NULL) and checks if errno is ENOSYS.
It means that acct system call is not implemented in kernel.
The other ENOSYS check routines in setup are removed.
This patch prevents from unintentional calling acct again in cleanup, which
makes TCONF to TBROK and helps configuration issues stay as TCONF.

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
---
 testcases/kernel/syscalls/acct/acct01.c |   32 +++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 8236042..4a34383 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -124,12 +124,28 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
+static void check_acct_in_kernel(void)
+{
+	/* check if acct is implemented in kernel */
+	if (acct(NULL) == -1) {
+		if (errno == ENOSYS) {
+			tst_resm(TCONF,
+				 "BSD process accounting is not configured in "
+				 "this kernel");
+
+			tst_exit();
+		}
+	}
+}
+
 static void setup(void)
 {
 	int fd;
 
 	tst_require_root(NULL);
 
+	check_acct_in_kernel();
+
 	tst_tmpdir();
 
 	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
@@ -138,24 +154,12 @@ static void setup(void)
 	SAFE_CLOSE(cleanup, fd);
 
 	if (acct(TEST_FILE5) == -1) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "BSD process accounting is not configured in "
-				 "this kernel");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
-		}
+		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
 	}
 
 	/* turn off acct, so we are in a known state */
 	if (acct(NULL) == -1) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "BSD process accounting is not configured in "
-				 "this kernel");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup, "acct(NULL) failed");
-		}
+		tst_brkm(TBROK | TERRNO, cleanup, "acct(NULL) failed");
 	}
 
 	/* ELOOP SETTING */
-- 
1.7.9.5



------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
