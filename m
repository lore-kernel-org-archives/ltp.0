From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  5 Apr 2018 13:56:51 +0300
Subject: [LTP] [PATCH COMMITTED 2/3] netstress: fix partial checksum length
	for UDP-Lite protocol
In-Reply-To: <1522925812-17200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1522925812-17200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1522925812-17200-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check UDPLITE_RECV_CSCOV value for the possible minimum since it is
calculated from the server message length parameter, i.e. it must
cover the protocol header. Otherwise, if client sends the packet
with the lesser checksum length, server will drop such packets.

Fixes: 0bc572423473 ("netstress: support UDPLITE protocol")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 72f4a40..971a673 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -165,13 +165,16 @@ static void init_socket_opts(int sd)
 		SAFE_SETSOCKOPT_INT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
 				    service_code);
 	break;
-	case TYPE_UDP_LITE:
+	case TYPE_UDP_LITE: {
+		int cscov = init_srv_msg_len >> 1;
+
+		if (cscov < 8)
+			cscov = 8;
+		tst_res(TINFO, "UDP-Lite send cscov is %d", cscov);
 		/* set checksum for header and partially for payload */
-		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_SEND_CSCOV,
-				    init_srv_msg_len >> 1);
-		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_RECV_CSCOV,
-				    init_srv_msg_len >> 2);
-	break;
+		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_SEND_CSCOV, cscov);
+		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_RECV_CSCOV, 8);
+	} break;
 	}
 }
 
-- 
1.7.1

