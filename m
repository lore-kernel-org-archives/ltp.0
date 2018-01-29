From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:12 +0300
Subject: [LTP] [PATCH 5/9] netstress: support UDPLITE protocol
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use initial server message length to set partial checksum.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/lapi/netinet_in.h               |    4 +++
 include/lapi/socket.h                   |    4 +++
 include/lapi/udp.h                      |   30 +++++++++++++++++++++++
 testcases/network/netstress/netstress.c |   40 +++++++++++++++++++++++++-----
 4 files changed, 71 insertions(+), 7 deletions(-)
 create mode 100644 include/lapi/udp.h

diff --git a/include/lapi/netinet_in.h b/include/lapi/netinet_in.h
index 84aca4d..7da7b32 100644
--- a/include/lapi/netinet_in.h
+++ b/include/lapi/netinet_in.h
@@ -24,4 +24,8 @@
 #define IPPROTO_DCCP		33
 #endif
 
+#ifndef IPPROTO_UDPLITE
+# define IPPROTO_UDPLITE	136 /* UDP-Lite (RFC 3828) */
+#endif
+
 #endif	/* LAPI_IN_H__ */
diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 95337ce..a0217e1 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -37,6 +37,10 @@
 # define SOCK_CLOEXEC 02000000
 #endif
 
+#ifndef SOL_UDPLITE
+# define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
+#endif
+
 #ifndef SOL_DCCP
 # define SOL_DCCP		269
 #endif
diff --git a/include/lapi/udp.h b/include/lapi/udp.h
new file mode 100644
index 0000000..b6f50f8
--- /dev/null
+++ b/include/lapi/udp.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2018 Oracle and/or its affiliates.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef LAPI_UDP_H__
+#define LAPI_UDP_H__
+
+#include <netinet/udp.h>
+
+#ifndef UDPLITE_SEND_CSCOV
+# define UDPLITE_SEND_CSCOV   10 /* sender partial coverage (as sent) */
+#endif
+#ifndef UDPLITE_RECV_CSCOV
+# define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
+#endif
+
+#endif	/* LAPI_UDP_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index f795f2d..97de35c 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <errno.h>
 
+#include "lapi/udp.h"
 #include "lapi/dccp.h"
 #include "lapi/netinet_in.h"
 #include "lapi/posix_clocks.h"
@@ -91,6 +92,7 @@ static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */
 enum {
 	TYPE_TCP = 0,
 	TYPE_UDP,
+	TYPE_UDP_LITE,
 	TYPE_DCCP,
 	TYPE_SCTP
 };
@@ -142,13 +144,25 @@ static void init_socket_opts(int sd)
 	if (busy_poll >= 0)
 		SAFE_SETSOCKOPT_INT(sd, SOL_SOCKET, SO_BUSY_POLL, busy_poll);
 
-	if (proto_type == TYPE_DCCP) {
+	switch (proto_type) {
+	case TYPE_TCP:
+		if (client_mode && fastopen_sapi) {
+			SAFE_SETSOCKOPT_INT(sd, IPPROTO_TCP,
+					    TCP_FASTOPEN_CONNECT, 1);
+		}
+	break;
+	case TYPE_DCCP:
 		SAFE_SETSOCKOPT_INT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
-			service_code);
+				    service_code);
+	break;
+	case TYPE_UDP_LITE:
+		/* set checksum for header and partially for payload */
+		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_SEND_CSCOV,
+				    init_srv_msg_len >> 1);
+		SAFE_SETSOCKOPT_INT(sd, SOL_UDPLITE, UDPLITE_RECV_CSCOV,
+				    init_srv_msg_len >> 2);
+	break;
 	}
-
-	if (client_mode && fastopen_sapi)
-		SAFE_SETSOCKOPT_INT(sd, IPPROTO_TCP, TCP_FASTOPEN_CONNECT, 1);
 }
 
 static void do_cleanup(void)
@@ -612,7 +626,7 @@ static void server_init(void)
 
 	freeaddrinfo(local_addrinfo);
 
-	if (proto_type == TYPE_UDP)
+	if (sock_type == SOCK_DGRAM)
 		return;
 
 	init_socket_opts(sfd);
@@ -730,6 +744,8 @@ static void set_protocol_type(void)
 		proto_type = TYPE_TCP;
 	else if (!strcmp(type, "udp"))
 		proto_type = TYPE_UDP;
+	else if (!strcmp(type, "udp_lite"))
+		proto_type = TYPE_UDP_LITE;
 	else if (!strcmp(type, "dccp"))
 		proto_type = TYPE_DCCP;
 	else if (!strcmp(type, "sctp"))
@@ -795,7 +811,10 @@ static void setup(void)
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
 
-		if (proto_type == TYPE_DCCP || proto_type == TYPE_UDP) {
+		switch (proto_type) {
+		case TYPE_DCCP:
+		case TYPE_UDP:
+		case TYPE_UDP_LITE:
 			tst_res(TINFO, "max timeout errors %d", max_etime_cnt);
 			wait_timeout = 100;
 		}
@@ -812,6 +831,7 @@ static void setup(void)
 			net.cleanup	= server_cleanup;
 		break;
 		case TYPE_UDP:
+		case TYPE_UDP_LITE:
 			net.run		= server_run_udp;
 			net.cleanup	= NULL;
 		break;
@@ -830,6 +850,12 @@ static void setup(void)
 		fastopen_api = fastopen_sapi = NULL;
 		sock_type = SOCK_DGRAM;
 	break;
+	case TYPE_UDP_LITE:
+		tst_res(TINFO, "using UDP Lite");
+		fastopen_api = fastopen_sapi = NULL;
+		sock_type = SOCK_DGRAM;
+		protocol = IPPROTO_UDPLITE;
+	break;
 	case TYPE_DCCP:
 		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
 		fastopen_api = fastopen_sapi = NULL;
-- 
1.7.1

