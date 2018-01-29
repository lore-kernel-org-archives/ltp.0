From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:13 +0300
Subject: [LTP] [PATCH 6/9] netstress: support SO_ZEROCOPY
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-7-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SO_ZEROCOPY is available since Linux 4.14:
commit 76851d1212c1 ("sock: add SOCK_ZEROCOPY sockopt").

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/lapi/socket.h                   |    8 +++++
 testcases/network/netstress/netstress.c |   46 +++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index a0217e1..426906f 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -21,6 +21,10 @@
 
 #include <sys/socket.h>
 
+#ifndef MSG_ZEROCOPY
+# define MSG_ZEROCOPY	0x4000000 /* Use user data in kernel path */
+#endif
+
 #ifndef MSG_FASTOPEN
 # define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
 #endif
@@ -29,6 +33,10 @@
 # define SO_BUSY_POLL	46
 #endif
 
+#ifndef SO_ZEROCOPY
+# define SO_ZEROCOPY	60
+#endif
+
 #ifndef SOCK_DCCP
 # define SOCK_DCCP		6
 #endif
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 97de35c..d06cdae 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -139,6 +139,9 @@ struct sock_info {
 	int timeout;
 };
 
+static char *zcopy;
+static int send_flags = MSG_NOSIGNAL;
+
 static void init_socket_opts(int sd)
 {
 	if (busy_poll >= 0)
@@ -150,6 +153,8 @@ static void init_socket_opts(int sd)
 			SAFE_SETSOCKOPT_INT(sd, IPPROTO_TCP,
 					    TCP_FASTOPEN_CONNECT, 1);
 		}
+		if (client_mode && zcopy)
+			SAFE_SETSOCKOPT_INT(sd, SOL_SOCKET, SO_ZEROCOPY, 1);
 	break;
 	case TYPE_DCCP:
 		SAFE_SETSOCKOPT_INT(sd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
@@ -199,13 +204,25 @@ static int sock_recv_poll(char *buf, int size, struct sock_info *i)
 			break;
 		}
 
-		if (ret == 0) {
-			errno = ETIME;
+		if (ret != 1) {
+			if (!errno)
+				errno = ETIME;
 			break;
 		}
 
-		if (ret != 1 || !(pfd.revents & POLLIN))
+		if (!(pfd.revents & POLLIN)) {
+			if (pfd.revents & POLLERR) {
+				int err = 0;
+				socklen_t err_len = sizeof(err);
+
+				getsockopt(i->fd, SOL_SOCKET, SO_ERROR,
+					   &err, &err_len);
+				if (!err)
+					continue;
+				errno = err;
+			}
 			break;
+		}
 
 		errno = 0;
 		len = recvfrom(i->fd, buf, size, MSG_DONTWAIT,
@@ -270,7 +287,7 @@ static int client_connect_send(const char *msg, int size)
 
 	if (fastopen_api) {
 		/* Replaces connect() + send()/write() */
-		SAFE_SENDTO(1, cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
+		SAFE_SENDTO(1, cfd, msg, size, send_flags | MSG_FASTOPEN,
 			remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
 	} else {
 		if (local_addrinfo)
@@ -279,9 +296,8 @@ static int client_connect_send(const char *msg, int size)
 		/* old TCP API */
 		SAFE_CONNECT(cfd, remote_addrinfo->ai_addr,
 			     remote_addrinfo->ai_addrlen);
-		SAFE_SEND(1, cfd, msg, size, MSG_NOSIGNAL);
+		SAFE_SEND(1, cfd, msg, size, send_flags);
 	}
-
 	return cfd;
 }
 
@@ -358,7 +374,7 @@ send:
 		if (max_rand_msg_len)
 			make_client_request(client_msg, &cln_len, &srv_len);
 
-		SAFE_SEND(1, inf.fd, client_msg, cln_len, MSG_NOSIGNAL);
+		SAFE_SEND(1, inf.fd, client_msg, cln_len, send_flags);
 
 		if (client_recv(buf, srv_len, &inf)) {
 			err = errno;
@@ -559,20 +575,20 @@ void *server_fn(void *cfd)
 		switch (send_type) {
 		case 0:
 			SAFE_SEND(1, inf.fd, send_msg, send_msg_len,
-				  MSG_NOSIGNAL);
+				  send_flags);
 			if (proto_type != TYPE_SCTP)
 				++send_type;
 			break;
 		case 1:
 			SAFE_SENDTO(1, inf.fd, send_msg, send_msg_len,
-				    MSG_NOSIGNAL, (struct sockaddr *)&inf.raddr,
+				    send_flags, (struct sockaddr *)&inf.raddr,
 				    inf.raddr_len);
 			++send_type;
 			break;
 		default:
 			iov[0].iov_len = send_msg_len - 1;
 			msg.msg_namelen = inf.raddr_len;
-			SAFE_SENDMSG(send_msg_len, inf.fd, &msg, MSG_NOSIGNAL);
+			SAFE_SENDMSG(send_msg_len, inf.fd, &msg, send_flags);
 			send_type = start_send_type;
 			break;
 		}
@@ -636,8 +652,13 @@ static void server_init(void)
 			tfo_queue_size);
 	}
 
+	if (zcopy)
+		SAFE_SETSOCKOPT_INT(sfd, SOL_SOCKET, SO_ZEROCOPY, 1);
+
 	SAFE_LISTEN(sfd, max_queue_len);
+
 	tst_res(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
+
 }
 
 static void server_cleanup(void)
@@ -843,6 +864,8 @@ static void setup(void)
 		tst_res(TINFO, "TCP %s is using %s TCP API.",
 			(client_mode) ? "client" : "server",
 			(fastopen_api) ? "Fastopen" : "old");
+		if (zcopy)
+			send_flags |= MSG_ZEROCOPY;
 		check_tfo_value();
 	break;
 	case TYPE_UDP:
@@ -887,7 +910,8 @@ static struct tst_option options[] = {
 	{"S:", &source_addr, "-S x     Source address to bind"},
 	{"g:", &tcp_port, "-g x     x - server port"},
 	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
-	{"T:", &type, "-T x     tcp (default), udp, dccp, sctp\n"},
+	{"T:", &type, "-T x     tcp (default), udp, dccp, sctp"},
+	{"z", &zcopy, "-z       enable SO_ZEROCOPY\n"},
 
 	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
 	{"l", &client_mode, "-l       Become client, default is server"},
-- 
1.7.1

