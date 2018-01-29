From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:14 +0300
Subject: [LTP] [PATCH 7/9] netstress: support IP_BIND_ADDRESS_NO_PORT
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-8-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added in Linux 4.2 commit 90c337da1524 ("inet: add
IP_BIND_ADDRESS_NO_PORT to overcome bind(0) limitations")

It will be enabled by default in netstress for v4.2+ kernels
if '-S' option is used.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/lapi/netinet_in.h               |    4 ++++
 testcases/network/netstress/netstress.c |   27 ++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/lapi/netinet_in.h b/include/lapi/netinet_in.h
index 7da7b32..427f283 100644
--- a/include/lapi/netinet_in.h
+++ b/include/lapi/netinet_in.h
@@ -28,4 +28,8 @@
 # define IPPROTO_UDPLITE	136 /* UDP-Lite (RFC 3828) */
 #endif
 
+#ifndef IP_BIND_ADDRESS_NO_PORT
+# define IP_BIND_ADDRESS_NO_PORT	24
+#endif
+
 #endif	/* LAPI_IN_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index d06cdae..64fdc91 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -279,6 +279,25 @@ static int client_recv(char *buf, int srv_msg_len, struct sock_info *i)
 	return (errno) ? -1 : 0;
 }
 
+static int bind_no_port;
+static void bind_before_connect(int sd)
+{
+	if (!local_addrinfo)
+		return;
+
+	if (bind_no_port)
+		SAFE_SETSOCKOPT_INT(sd, SOL_IP, IP_BIND_ADDRESS_NO_PORT, 1);
+
+	SAFE_BIND(sd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
+
+	if (bind_no_port && proto_type != TYPE_SCTP) {
+		int port = TST_GETSOCKPORT(sd);
+
+		if (port)
+			tst_brk(TFAIL, "port not zero after bind(): %d", port);
+	}
+}
+
 static int client_connect_send(const char *msg, int size)
 {
 	int cfd = SAFE_SOCKET(family, sock_type, protocol);
@@ -290,9 +309,7 @@ static int client_connect_send(const char *msg, int size)
 		SAFE_SENDTO(1, cfd, msg, size, send_flags | MSG_FASTOPEN,
 			remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
 	} else {
-		if (local_addrinfo)
-			SAFE_BIND(cfd, local_addrinfo->ai_addr,
-				  local_addrinfo->ai_addrlen);
+		bind_before_connect(cfd);
 		/* old TCP API */
 		SAFE_CONNECT(cfd, remote_addrinfo->ai_addr,
 			     remote_addrinfo->ai_addrlen);
@@ -817,6 +834,10 @@ static void setup(void)
 	set_protocol_type();
 
 	if (client_mode) {
+		if (source_addr && tst_kvercmp(4, 2, 0) >= 0) {
+			bind_no_port = 1;
+			tst_res(TINFO, "IP_BIND_ADDRESS_NO_PORT is used");
+		}
 		tst_res(TINFO, "connection: addr '%s', port '%s'",
 			server_addr, tcp_port);
 		tst_res(TINFO, "client max req: %d", client_max_requests);
-- 
1.7.1

