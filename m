Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <francesco.rundo@st.com>) id 1WGkuT-000645-Gb
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 07:52:37 +0000
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WGkuP-0002Tt-If
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 07:52:37 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51CE0146
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Feb 2014 07:52:26 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26182B1B1
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Feb 2014 07:52:26 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Fri, 21 Feb 2014 08:51:52 +0100
Message-Id: <1392969112-15851-1-git-send-email-francesco.rundo@st.com>
Subject: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Changed exit code from TFAIL to TCONF  in case of unsupported
syscall. The "madvise" syscall needs kernel support as well as
fs support as -for specific advice- it requires specific filesystem
operations such as fallocate().
So, if kernel support is missed or fs doesn't provide specific
operation needed for such "advice" scenario of that syscall, the right
exit code (according to LTP defs) is not TFAIL as it is not a failure
but it is TCONF as the syscall is unsupported.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
---
 testcases/kernel/syscalls/madvise/madvise03.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index b0c17e8..23dd9a6 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -160,10 +160,19 @@ static void cleanup(void)
 static void check_and_print(char *advice)
 {
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL,
-			 "madvise test for %s failed with "
-			 "return = %ld, errno = %d : %s",
-			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+		if (TEST_ERRNO != ENOTSUP) {
+			tst_resm(TFAIL,
+				 "madvise test for %s failed with "
+				 "return = %ld, errno = %d : %s",
+				 advice, TEST_RETURN, TEST_ERRNO,
+				 strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TCONF,
+				"madvise test for %s unsupported "
+				"return = %ld, errno = %d : %s",
+				advice, TEST_RETURN, TEST_ERRNO,
+				strerror(TEST_ERRNO));
+		}
 	} else if (STD_FUNCTIONAL_TEST) {
 		tst_resm(TPASS, "madvise test for %s PASSED", advice);
 	}
-- 
1.7.7.6


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
