Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YvG1S-0003Ni-KY
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:15:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvG1R-0008I2-8I
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:15:46 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4L2EEf1004640
	for <ltp-list@lists.sourceforge.net>; Thu, 21 May 2015 10:14:14 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 21 May 2015 10:14:42 +0800
Message-ID: <1432174482-23967-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1432174482-23967-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <20150520133631.GA9052@rei.suse.de>
	<1432174482-23967-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] kernel/controllers/cpuctl: cleanup
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

* Remove redundant include(s) for unistd.h
* Add void where needed

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c | 3 +--
 testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c | 3 +--
 testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c | 3 +--
 testcases/kernel/controllers/cpuctl/cpuctl_test03.c     | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index ba24b4a..ae6a374 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -54,7 +54,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <time.h>
-#include <unistd.h>
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
@@ -75,7 +74,7 @@ int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[FILENAME_MAX] = "/dev/cpuctl";
 
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	/* Report exit status */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 4680406..5fb3559 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -57,7 +57,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <time.h>
-#include <unistd.h>
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
@@ -70,7 +69,7 @@ int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
 
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	/* Report exit status */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index 41cfa41..af4695f 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -58,7 +58,6 @@
 #include <sys/time.h>
 #include <sys/types.h>
 #include <time.h>
-#include <unistd.h>
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
@@ -70,7 +69,7 @@ char *TCID = "cpu_controller_test06";
 int TST_TOTAL = 3;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	/* Report exit status */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index ca9f4f9..20dbf86 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -58,7 +58,6 @@
 #include <sys/time.h>
 #include <sys/types.h>
 #include <time.h>
-#include <unistd.h>
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
@@ -70,7 +69,7 @@ char *TCID = "cpu_controller_test06";
 int TST_TOTAL = 3;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	tst_exit();		/* Report exit status */
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
