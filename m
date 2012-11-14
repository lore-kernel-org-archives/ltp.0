Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TYZOr-0005j7-T4
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 09:36:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TYZOn-0008J2-Sf
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 09:36:49 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAE9ad6W008901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Nov 2012 04:36:40 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id qAE9acCj017287
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Nov 2012 04:36:39 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Nov 2012 10:36:33 +0100
Message-Id: <6c96a49f0109d33e28d1222f5f87dcca45c9c272.1352885663.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] waitpid02: avoid core file
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

Depending on configuration this testcase may create core
file with various location and name. The signal causing
core dump is here by design so this core file isn't interesting.

Avoid this core file by setting RLIMIT_CORE to 1.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/waitpid/waitpid02.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid02.c b/testcases/kernel/syscalls/waitpid/waitpid02.c
index ae0446e..6db43c2 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid02.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid02.c
@@ -50,6 +50,7 @@
  */
 
 #include <sys/file.h>
+#include <sys/resource.h>
 #include <sys/signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -145,10 +146,6 @@ int main(int argc, char **argv)
 				}
 			}
 		}
-
-		if (access("core", F_OK) == 0) {
-			unlink("core");
-		}
 	}
 	cleanup();
 	tst_exit();
@@ -174,6 +171,13 @@ void do_child()
  */
 void setup(void)
 {
+	/* SIGFPE is expected signal, so avoid creating any corefile.
+	 * '1' is a special value, that will also avoid dumping via pipe. */
+	struct rlimit r;
+	r.rlim_cur = 1;
+	r.rlim_max = 1;
+	setrlimit(RLIMIT_CORE, &r);
+
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -c option.
 	 */
-- 
1.7.1


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
