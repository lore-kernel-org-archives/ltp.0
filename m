Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z8Q6p-0007P6-IA
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 09:39:43 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z8Q6n-0002Yj-4k
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 09:39:43 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Fri, 26 Jun 2015 11:45:37 -0600
Message-ID: <1435340737-16403-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pidns: Update TCID from pid_namespace to pidns.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/pidns/pidns01.c | 2 +-
 testcases/kernel/containers/pidns/pidns02.c | 2 +-
 testcases/kernel/containers/pidns/pidns03.c | 2 +-
 testcases/kernel/containers/pidns/pidns04.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 5af6149..234f2b8 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -58,7 +58,7 @@
 #include "libclone.h"
 #include "pidns_helper.h"
 
-char *TCID = "pid_namespace1";
+char *TCID = "pidns01";
 int TST_TOTAL = 1;
 
 #define CHILD_PID       1
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index b10f4b9..53f487a 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -54,7 +54,7 @@
 #include "libclone.h"
 #include "pidns_helper.h"
 
-char *TCID = "pid_namespace2";
+char *TCID = "pidns02";
 int TST_TOTAL = 1;
 
 #define PGID	1
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index ecd2627..2014bb8 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -37,7 +37,7 @@
 #include "pidns_helper.h"
 
 #define PROCDIR "proc"
-char *TCID	= "pidns03";
+char *TCID = "pidns03";
 int TST_TOTAL	= 1;
 
 
diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index 6be8e1c..9f2547c 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -65,7 +65,7 @@
 #define CHILD_PID       1
 #define PARENT_PID      0
 
-char *TCID = "pid_namespace4";
+char *TCID = "pidns04";
 int TST_TOTAL = 1;
 int fd[2];
 
-- 
1.9.1


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
