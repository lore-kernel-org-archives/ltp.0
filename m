Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QrXEs-0006Jd-7m
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 15:32:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QrXEr-0008Hu-CB
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 15:32:06 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7BFVxI2017452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 11:31:59 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu, 11 Aug 2011 23:30:56 +0800
Message-Id: <537c38d30cd527a91b97200b11b5714ce9a2785a.1313075996.git.czhang@redhat.com>
In-Reply-To: <15c8ac922d2c4548bb9171b55df4b143b65e21d4.1312342893.git.czhang@redhat.com>
References: <15c8ac922d2c4548bb9171b55df4b143b65e21d4.1312342893.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH v2] syscalls/mprotect02: hide sigfault info from dmesg
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


mprotect02 triggered an expected SIGSEGV in test, but it puts this
information in dmesg, which might cause confusion when checking results:

mprotect02[11416]: segfault at 7f9ca0060000 ip 0000003a8e3382ff sp 00007fff7aeecb68 error 6 in libc-2.12.so[3a8e200000+197000]

This patch hides the sigfault information from dmesg.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/mprotect/mprotect02.c |   31 +++++++++++++++++------
 1 files changed, 23 insertions(+), 8 deletions(-)


--------------1.7.6
Content-Type: text/x-patch;
	name="0001-syscalls-mprotect02-hide-sigfault-info-from-dmesg.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-mprotect02-hide-sigfault-info-from-dmesg.patch"

diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index 97250c5..301391a 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -60,6 +60,7 @@
 
 #include "safe_macros.h"
 
+static void sighandler(int sig);
 static void cleanup(void);
 static void setup(void);
 
@@ -114,19 +115,26 @@ int main(int ac, char **av)
 
 		if (pid == 0) {
 			(void)memcpy(addr, buf, strlen(buf));
-			printf("memcpy did not generate SIGSEGV\n");
-			exit(1);
+			exit(255);
 		}
 
 		if (waitpid(pid, &status, 0) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "waitpid failed");
-
-		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
-			tst_resm(TPASS, "got SIGSEGV as expected");
-		else
+		if (!WIFEXITED(status))
+			tst_brkm(TBROK, cleanup, "child exited abnormally "
+					"with status: %d", status);
+		switch (status) {
+		case 255:
 			tst_brkm(TBROK, cleanup,
-			    "child exited abnormally; wait status = %d",
-			    status);
+					"memcpy did not generate SIGSEGV");
+		case 0:
+			tst_resm(TPASS, "got SIGSEGV as expected");
+			break;
+		default:
+			tst_brkm(TBROK, cleanup, "got unexpected signal: %d",
+					status);
+			break;
+		}
 
 		/* Change the protection to WRITE. */
 		TEST(mprotect(addr, sizeof(buf), PROT_WRITE));
@@ -185,8 +193,14 @@ int main()
 
 #endif /* UCLINUX */
 
+static void sighandler(int sig)
+{
+	_exit((sig == SIGSEGV) ? 0 : sig);
+}
+
 static void setup()
 {
+	tst_sig(FORK, sighandler, cleanup);
 
 	TEST_PAUSE;
 

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



