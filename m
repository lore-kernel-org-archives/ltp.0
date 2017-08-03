From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 3 Aug 2017 17:12:44 +0800
Subject: [LTP] [PATCH] cve/cve-2017-2671.c: check if socket() supports
	IPPROTO_ICMP
Message-ID: <1501751564-8002-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

socket() does not support IPPROTO_ICMP, and the ping_group_range file
does not exist in older kernels(e.g. RHEL5.11GA).  these supports are
introduced by:
'c319b4d("net: ipv4: add IPPROTO_ICMP socket kind")'

This case should get TCONF instead of TBROK, so we add check to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/cve/cve-2017-2671.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 2148512..86d12e6 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -37,6 +37,8 @@
  * enabled by default, root privileges are not required.
  */
 
+#include <errno.h>
+#include <unistd.h>
 #include <stdio.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
@@ -52,7 +54,7 @@
 #define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
 
 static int sockfd;
-static unsigned int ping_min_grp = 1, ping_max_grp;
+static unsigned int ping_min_grp, ping_max_grp;
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 static struct sockaddr_in iaddr, uaddr;
 
@@ -64,17 +66,27 @@ static void setup(void)
 	uaddr.sin_family = AF_UNSPEC;
 	fzsync_pair.delay_inc = 1;
 
-	SAFE_FILE_SCANF(PING_SYSCTL_PATH, "%u %u",
-			&ping_min_grp, &ping_max_grp);
-	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
+	if (!access(PING_SYSCTL_PATH, F_OK)) {
+		SAFE_FILE_SCANF(PING_SYSCTL_PATH, "%u %u",
+				&ping_min_grp, &ping_max_grp);
+		SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
+	}
 
-	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	if (sockfd == -1) {
+		if (errno == EPROTONOSUPPORT) {
+			tst_brk(TCONF | TERRNO,
+				"socket() does not support IPPROTO_ICMP");
+		}
+		tst_brk(TBROK | TERRNO, "socket() failed");
+	}
 	tst_res(TINFO, "Created ping socket, attempting to race...");
 }
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(sockfd);
+	if (sockfd > 0)
+		SAFE_CLOSE(sockfd);
 	if (ping_min_grp | ping_max_grp)
 		SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "%u %u",
 				 ping_min_grp, ping_max_grp);
-- 
1.8.3.1



