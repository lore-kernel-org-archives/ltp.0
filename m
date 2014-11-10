Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Xnkew-00032i-1C
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 08:49:14 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xnkeu-0004es-BP
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 08:49:14 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAA8mrNF014928
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 16:48:53 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 10 Nov 2014 16:46:03 +0800
Message-ID: <1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] containers: change check_iproute() behavior in
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
 testcases/kernel/containers/netns/netns_crtchild.c |  7 ++++-
 .../containers/netns/netns_crtchild_delchild.c     |  7 ++++-
 testcases/kernel/containers/netns/netns_helper.h   | 31 +++++++++++++++++-----
 .../kernel/containers/netns/netns_par_chld_ftp.c   |  7 ++++-
 .../kernel/containers/netns/netns_par_chld_ipv6.c  |  7 ++++-
 .../containers/netns/netns_two_children_ns.c       |  7 ++++-
 6 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_crtchild.c b/testcases/kernel/containers/netns/netns_crtchild.c
index 3b5a696..a6da669 100644
--- a/testcases/kernel/containers/netns/netns_crtchild.c
+++ b/testcases/kernel/containers/netns/netns_crtchild.c
@@ -29,12 +29,17 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_crtchild";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	if (check_iproute(IPROUTE_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+	}
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_crtchild_delchild.c b/testcases/kernel/containers/netns/netns_crtchild_delchild.c
index 3235990..b2aa7cc 100644
--- a/testcases/kernel/containers/netns/netns_crtchild_delchild.c
+++ b/testcases/kernel/containers/netns/netns_crtchild_delchild.c
@@ -33,12 +33,17 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_crtchild_delchild";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	if (check_iproute(IPROUTE_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+	}
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 7f301ce..bd0a88d 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -33,25 +33,42 @@
 #define CLONE_NEWNS -1
 #endif
 
-#define IPROUTE_MIN_VER 80725
-
-static void check_iproute(void)
+/*
+ * Check whether the current iproute version matches specified iproute.
+ *
+ * Returns:
+ *   -1 - cur_ipver is less than spe_ipver
+ *   0 - cur_ipver is equal to spe_ipver
+ *   1 - cur_ipver is greater than spe_ipver
+ */
+static int check_iproute(int spe_ipver)
 {
 	FILE *ipf;
 	int n;
-	unsigned int ipver = 0;
+	unsigned int cur_ipver = 0;
+	int ret;
 
 	ipf = popen("ip -V", "r");
 	if (ipf == NULL)
 		tst_brkm(TCONF, NULL,
 				"Failed while opening pipe for iproute check");
 
-	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
-	if (n < 1 || ipver < IPROUTE_MIN_VER)
+	n = fscanf(ipf, "ip utility, iproute2-ss%u", &cur_ipver);
+	if (n < 1) {
+		pclose(ipf);
 		tst_brkm(TCONF, NULL,
-			"iproute tools do not support setting network namespaces");
+			"Failed while obtaining version for iproute check");
+	} else {
+		if (cur_ipver < spe_ipver)
+			ret = -1;
+		else if (cur_ipver == spe_ipver)
+			ret = 0;
+		else
+			ret = 1;
+	}
 
 	pclose(ipf);
+	return ret;
 }
 
 static void check_netns(void)
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.c b/testcases/kernel/containers/netns/netns_par_chld_ftp.c
index 97411f7..20ab179 100644
--- a/testcases/kernel/containers/netns/netns_par_chld_ftp.c
+++ b/testcases/kernel/containers/netns/netns_par_chld_ftp.c
@@ -30,12 +30,17 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 const char *TCID = "netns_par_chld_ftp";
 
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	if (check_iproute(IPROUTE_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+	}
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c b/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
index 1e50f24..c68e7ab 100644
--- a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
@@ -47,6 +47,8 @@
 #include "common.h"
 #include "netns_helper.h"
 
+#define IPROUTE_MIN_VER 80725
+
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
 
@@ -56,7 +58,10 @@ int TST_TOTAL = 1;
 static void setup(void)
 {
 	tst_require_root(NULL);
-	check_iproute();
+	if (check_iproute(IPROUTE_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+	}
 	check_netns();
 }
 
diff --git a/testcases/kernel/containers/netns/netns_two_children_ns.c b/testcases/kernel/containers/netns/netns_two_children_ns.c
index 0a032d0..2446200 100644
--- a/testcases/kernel/containers/netns/netns_two_children_ns.c
+++ b/testcases/kernel/containers/netns/netns_two_children_ns.c
@@ -49,13 +49,18 @@
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
+	if (check_iproute(IPROUTE_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+	}
 	check_netns();
 }
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
