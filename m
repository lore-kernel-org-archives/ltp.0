From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 4 Aug 2017 09:21:00 +0800
Subject: [LTP] [PATCH v2] cve/cve-2017-2671.c: check if socket() supports
	IPPROTO_ICMP
In-Reply-To: <20170803155229.GD15519@rei>
References: <20170803155229.GD15519@rei>
Message-ID: <1501809660-17971-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

socket() does not support IPPROTO_ICMP, and where the ping_group_range
file is missing in older kernels(e.g. RHEL5.11GA).  these supports are
introduced by:
'c319b4d("net: ipv4: add IPPROTO_ICMP socket kind")'

This case should get TCONF if the ping_group_range is missing, so we
add check to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/cve/cve-2017-2671.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 2148512..77744db 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -37,6 +37,7 @@
  * enabled by default, root privileges are not required.
  */
 
+#include <unistd.h>
 #include <stdio.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
@@ -52,7 +53,7 @@
 #define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
 
 static int sockfd;
-static unsigned int ping_min_grp = 1, ping_max_grp;
+static unsigned int ping_min_grp, ping_max_grp;
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 static struct sockaddr_in iaddr, uaddr;
 
@@ -64,6 +65,9 @@ static void setup(void)
 	uaddr.sin_family = AF_UNSPEC;
 	fzsync_pair.delay_inc = 1;
 
+	if (access(PING_SYSCTL_PATH, F_OK))
+		tst_brk(TCONF, "socket() does not support IPPROTO_ICMP");
+
 	SAFE_FILE_SCANF(PING_SYSCTL_PATH, "%u %u",
 			&ping_min_grp, &ping_max_grp);
 	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
@@ -74,7 +78,8 @@ static void setup(void)
 
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



