Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XwmwB-0006zR-UN
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:04:23 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XwmwA-0006Cp-Jg
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:04:23 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sB573sPO026300
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 15:03:54 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 5 Dec 2014 15:00:57 +0800
Message-ID: <1417762858-18686-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/2] containers: change check_iproute() behavior in
	netns/netns_helper.h
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

Change check_iproute() behavior in order to improve
its expansibility.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_crtchild.c          |  4 +++-
 testcases/kernel/containers/netns/netns_crtchild_delchild.c |  4 +++-
 testcases/kernel/containers/netns/netns_helper.h            | 13 ++++++++-----
 testcases/kernel/containers/netns/netns_par_chld_ftp.c      |  4 +++-
 testcases/kernel/containers/netns/netns_par_chld_ipv6.c     |  3 ++-
 testcases/kernel/containers/netns/netns_two_children_ns.c   |  4 +++-
 6 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_crtchild.c b/testcases/kernel/containers/netns/netns_crtchild.c
index 3b5a696..8d9b68f 100644
--- a/testcases/kernel/containers/netns/netns_crtchild.c
+++ b/testcases/kernel/containers/netns/netns_crtchild.c
@@ -29,12 +29,14 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_crtchild";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	check_iproute(IPROUTE_MIN_VER);
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_crtchild_delchild.c b/testcases/kernel/containers/netns/netns_crtchild_delchild.c
index 3235990..f46f2b3 100644
--- a/testcases/kernel/containers/netns/netns_crtchild_delchild.c
+++ b/testcases/kernel/containers/netns/netns_crtchild_delchild.c
@@ -33,12 +33,14 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_crtchild_delchild";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	check_iproute(IPROUTE_MIN_VER);
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 7f301ce..3399a2f 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -33,9 +33,7 @@
 #define CLONE_NEWNS -1
 #endif
 
-#define IPROUTE_MIN_VER 80725
-
-static void check_iproute(void)
+static void check_iproute(int spe_ipver)
 {
 	FILE *ipf;
 	int n;
@@ -47,9 +45,14 @@ static void check_iproute(void)
 				"Failed while opening pipe for iproute check");
 
 	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
-	if (n < 1 || ipver < IPROUTE_MIN_VER)
+	if (n < 1) {
 		tst_brkm(TCONF, NULL,
-			"iproute tools do not support setting network namespaces");
+			"Failed while obtaining version for iproute check");
+	}
+	if (ipver < spe_ipver) {
+		tst_brkm(TCONF, NULL, "The commands in iproute tools do "
+			"not support required objects");
+	}
 
 	pclose(ipf);
 }
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.c b/testcases/kernel/containers/netns/netns_par_chld_ftp.c
index 97411f7..d88780c 100644
--- a/testcases/kernel/containers/netns/netns_par_chld_ftp.c
+++ b/testcases/kernel/containers/netns/netns_par_chld_ftp.c
@@ -30,12 +30,14 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_par_chld_ftp";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	check_iproute(IPROUTE_MIN_VER);
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c b/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
index 1e50f24..96d00c5 100644
--- a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
@@ -50,13 +50,14 @@
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
 
+#define IPROUTE_MIN_VER 80725
 #define PARENT_SCRIPT "netns_paripv6.sh"
 #define CHILD_SCRIPT "netns_childipv6.sh"
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	check_iproute(IPROUTE_MIN_VER);
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_two_children_ns.c b/testcases/kernel/containers/netns/netns_two_children_ns.c
index 0a032d0..a8a36d2 100644
--- a/testcases/kernel/containers/netns/netns_two_children_ns.c
+++ b/testcases/kernel/containers/netns/netns_two_children_ns.c
@@ -49,13 +49,15 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 char *TCID = "netns_2children";
 int TST_TOTAL = 1;
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	check_iproute(IPROUTE_MIN_VER);
 	check_netns();
 }
 
-- 
1.9.3


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
