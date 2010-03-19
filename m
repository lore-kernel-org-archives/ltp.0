Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NscCO-0002Mc-H3
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 13:25:12 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id C3C119417A
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Mar 2010 14:25:03 +0100 (CET)
Date: Fri, 19 Mar 2010 14:29:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100319132918.GA15361@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Subject: [LTP] [PATCH] sigset posix conformance test
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
To: ltp-list@lists.sourceforge.net


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
As pointed out by Cheng Shun Xia one of open posix conformace tests is testing 
return value from sigset(SIGCHLD, SIG_HOLD) and expect this value to be
SIG_HOLD, however this is true only if SIGCHLD is already blocked so we must
ensure that. Patch is attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--7JfCtLOvnd9MIVvH
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="sigset.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/8-1.c
index f344b19..22b1f40 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/8-1.c
@@ -15,12 +15,22 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
+#include <string.h>
 #include "posixtest.h"
 
-int main()
+int main(void)
 {
+	sigset_t st;
+	sigemptyset(&st);
+	sigaddset(&st, SIGCHLD);
 
-        if (sigset(SIGCHLD,SIG_HOLD) != SIG_HOLD) {
+	if (sigprocmask(SIG_BLOCK, &st, NULL) < 0) {
+		printf("Test FAILED: sigprocmask(): %s\n", strerror(errno));
+		return PTS_FAIL;
+	}
+
+        if (sigset(SIGCHLD, SIG_HOLD) != SIG_HOLD) {
 		printf("Test FAILED: sigset() didn't return SIG_HOLD\n");
 		return PTS_FAIL;
 	}

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--7JfCtLOvnd9MIVvH--

