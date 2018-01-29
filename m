From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:11 +0300
Subject: [LTP] [PATCH 4/9] netstress: server: write to socket with
	send/sendto/sendmsg
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

server sends with send/sendto/sendmsg in round-robin way.
UDP & DCCP skip send(). SCTP 1-1 uses only send().

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   40 ++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index ccab403..f795f2d 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -476,18 +476,26 @@ static void make_server_reply(char *send_msg, int size)
 void *server_fn(void *cfd)
 {
 	int num_requests = 0, offset = 0;
-	/* Reply will be constructed from first client request */
-	char send_msg[max_msg_len];
-	int send_msg_len = 0;
+	char send_msg[max_msg_len], end[] = { end_byte };
+	int start_send_type = (sock_type == SOCK_DGRAM) ? 1 : 0;
+	int send_msg_len, send_type = start_send_type;
 	char recv_msg[max_msg_len];
 	struct sock_info inf;
 	ssize_t recv_len;
+	struct iovec iov[2];
+	struct msghdr msg;
 
 	inf.fd = (intptr_t) cfd;
 	inf.raddr_len = sizeof(inf.raddr);
 	inf.timeout = wait_timeout;
 
-	send_msg[0] = '\0';
+	iov[0].iov_base = send_msg;
+	iov[1].iov_base = end;
+	iov[1].iov_len = 1;
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_name = &inf.raddr;
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 2;
 
 	init_socket_opts(inf.fd);
 
@@ -534,15 +542,25 @@ void *server_fn(void *cfd)
 		    ++num_requests >= server_max_requests)
 			send_msg[0] = start_fin_byte;
 
-		switch (proto_type) {
-		case TYPE_SCTP:
+		switch (send_type) {
+		case 0:
 			SAFE_SEND(1, inf.fd, send_msg, send_msg_len,
-				MSG_NOSIGNAL);
-		break;
-		default:
+				  MSG_NOSIGNAL);
+			if (proto_type != TYPE_SCTP)
+				++send_type;
+			break;
+		case 1:
 			SAFE_SENDTO(1, inf.fd, send_msg, send_msg_len,
-				MSG_NOSIGNAL, (struct sockaddr *)&inf.raddr,
-				inf.raddr_len);
+				    MSG_NOSIGNAL, (struct sockaddr *)&inf.raddr,
+				    inf.raddr_len);
+			++send_type;
+			break;
+		default:
+			iov[0].iov_len = send_msg_len - 1;
+			msg.msg_namelen = inf.raddr_len;
+			SAFE_SENDMSG(send_msg_len, inf.fd, &msg, MSG_NOSIGNAL);
+			send_type = start_send_type;
+			break;
 		}
 
 		if (sock_type == SOCK_STREAM &&
-- 
1.7.1

