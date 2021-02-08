From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Mon, 8 Feb 2021 03:14:38 -0500
Subject: [LTP] [PATCH] netns_helper: Make iproute version check work
 correctly
Message-ID: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the iproute2 patch[1]("replace SNAPSHOT with auto-generated version string"),
the output format of "ip -V" has changed form "ip utility, iproute2-ss*" to
"ip utility, iproute2-*", which leads to an exception when checking the version
of iproute. Use return to avoid unexpected TCONF.

[1]https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fbef655568

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_helper.h  | 10 ++++++++--
 testcases/kernel/containers/netns/netns_helper.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 8b87645..8337051 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -37,6 +37,7 @@ static void check_iproute(unsigned int spe_ipver)
 	FILE *ipf;
 	int n;
 	unsigned int ipver = 0;
+	char ver;
 
 	ipf = popen("ip -V", "r");
 	if (ipf == NULL)
@@ -44,7 +45,14 @@ static void check_iproute(unsigned int spe_ipver)
 				"Failed while opening pipe for iproute check");
 
 	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
+	pclose(ipf);
 	if (n < 1) {
+		ipf = popen("ip -V", "r");
+		n = fscanf(ipf, "ip utility, iproute2-%s", &ver);
+		if (n >= 1) {
+			pclose(ipf);
+			return;
+		}
 		tst_brkm(TCONF, NULL,
 			"Failed while obtaining version for iproute check");
 	}
@@ -52,8 +60,6 @@ static void check_iproute(unsigned int spe_ipver)
 		tst_brkm(TCONF, NULL, "The commands in iproute tools do "
 			"not support required objects");
 	}
-
-	pclose(ipf);
 }
 
 static int dummy(void *arg)
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a5b77a0..bec43ac 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -50,6 +50,15 @@ tst_check_iproute()
 	local cur_ipver="$(ip -V)"
 	local spe_ipver="$1"
 
+	echo $cur_ipver | grep "ip utility, iproute2-ss" > /dev/null
+	ret1=$?
+	echo $cur_ipver | grep "ip utility, iproute2-" > /dev/null
+	ret2=$?
+
+	if [ $ret1 -ne 0 -a $ret2 -eq 0 ]; then
+		return
+	fi
+
 	cur_ipver=${cur_ipver##*s}
 
 	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
-- 
1.8.3.1



