From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 5 Apr 2018 18:27:57 +0800
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Add a hint on failure with
	EINVAL
Message-ID: <1522924077-15028-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If two ipv6 addresses have same family, a buggy kernel(e.g. RHEL6) lacked
the port check for them, and made this test get a failure with EINVAL:
-------------------------------------------------------------------------
safe_net.c:160: BROK: sctp_big_chunk.c:77: setsockopt(4, 132, 100, 0x7ffdbaac83a0, 91644) failed: EINVAL
-------------------------------------------------------------------------

If you want to know detailed info for the bug, please see the following commit:
'40b4f0f (sctp: lack the check for ports in sctp_v6_cmp_addr)'

We just want to hint users about the likely cause of the failure.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/network/sctp/sctp_big_chunk.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 55a2969..7b314f4 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -19,6 +19,7 @@
  * chunk in _sctp_make_chunk()")
  */
 
+#include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -58,7 +59,7 @@ static void setup_server(void)
 static void setup_client(void)
 {
 	struct sockaddr_in6 addr_buf[addr_num];
-	int i;
+	int i, res;
 
 	cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
 	rmt.sin6_family = AF_INET6;
@@ -73,8 +74,23 @@ static void setup_client(void)
 		addr_buf[i].sin6_addr = in6addr_loopback;
 	}
 
-	SAFE_SETSOCKOPT(cfd, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, addr_buf,
-			sizeof(addr_buf));
+	res = setsockopt(cfd, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, addr_buf,
+			 sizeof(addr_buf));
+	if (res) {
+		/* Without commit 40b4f0f, sctp_v6_cmp_addr() lacks the port
+		 * check for two ipv6 addresses which have same family. that
+		 * will make setsockopt(SCTP_SOCKOPT_BINDX_ADD) cannot work
+		 * well.
+		 */
+		if (errno == EINVAL) {
+			tst_res(TINFO, "possibly kernel lacked the port check "
+				"for two ipv6 addresses which have same family");
+		}
+
+		tst_brk(TBROK | TERRNO, "setsockopt(%d, SOL_SCTP, "
+			"SCTP_SOCKOPT_BINDX_ADD, %p, %lu) failed",
+			cfd, addr_buf, sizeof(addr_buf));
+	}
 }
 
 static void setup(void)
-- 
1.8.3.1



