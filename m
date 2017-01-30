From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 30 Jan 2017 17:14:58 +0300
Subject: [LTP] [PATCH 2/2] netstress: apply safe macros and remove recv()
	check in client
In-Reply-To: <1485785698-32053-1-git-send-email-alexey.kodanev@oracle.com>
References: <1485785698-32053-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1485785698-32053-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't need to check recv() return value to see if we still
connected. If server sends fin byte in data message, the client
closes sockfd and set it to -1. After that we know exactly when
we have to initate new connection.

Also,
* allocate send_msg on stack (similar to recv_msg),
* add TWARN messages when client exits but has unfinished requests,
* remove shutdown() from client_recv() as it can fail and set errno
  to ENOTCONN, that affects the end results, including rewriting of
  the original errno set.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |   90 +++++++++---------------------
 1 files changed, 27 insertions(+), 63 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index a1fbff3..e0716c3 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -126,7 +126,7 @@ static socklen_t remote_addr_len;
 static void init_socket_opts(int sd)
 {
 	if (busy_poll >= 0) {
-		setsockopt(sd, SOL_SOCKET, SO_BUSY_POLL,
+		SAFE_SETSOCKOPT(sd, SOL_SOCKET, SO_BUSY_POLL,
 			&busy_poll, sizeof(busy_poll));
 	}
 }
@@ -183,8 +183,8 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset)
 
 		if (len == -1 && errno == EINTR)
 			continue;
-		else
-			break;
+
+		break;
 	}
 
 	return len;
@@ -220,41 +220,26 @@ static int client_recv(int *fd, char *buf)
 		return 0;
 	}
 
-	shutdown(*fd, SHUT_WR);
 	SAFE_CLOSE(*fd);
 	return (errno) ? -1 : 0;
 }
 
 static int client_connect_send(const char *msg, int size)
 {
-	int cfd = socket(remote_addrinfo->ai_family,
+	int cfd = SAFE_SOCKET(remote_addrinfo->ai_family,
 			 remote_addrinfo->ai_socktype, 0);
 
-	if (cfd == -1)
-		return cfd;
-
 	init_socket_opts(cfd);
 
 	if (fastopen_api) {
 		/* Replaces connect() + send()/write() */
-		if (sendto(cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
-		    remote_addrinfo->ai_addr,
-		    remote_addrinfo->ai_addrlen) != size) {
-			SAFE_CLOSE(cfd);
-			return -1;
-		}
+		SAFE_SENDTO(1, cfd, msg, size, MSG_FASTOPEN | MSG_NOSIGNAL,
+			remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
 	} else {
 		/* old TCP API */
-		if (connect(cfd, remote_addrinfo->ai_addr,
-		    remote_addrinfo->ai_addrlen)) {
-			SAFE_CLOSE(cfd);
-			return -1;
-		}
-
-		if (send(cfd, msg, size, MSG_NOSIGNAL) != client_msg_size) {
-			SAFE_CLOSE(cfd);
-			return -1;
-		}
+		SAFE_CONNECT(cfd, remote_addrinfo->ai_addr,
+			     remote_addrinfo->ai_addrlen);
+		SAFE_SEND(1, cfd, msg, size, MSG_NOSIGNAL);
 	}
 
 	return cfd;
@@ -263,7 +248,7 @@ static int client_connect_send(const char *msg, int size)
 void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	char buf[server_msg_size];
-	int cfd, i;
+	int cfd, i = 0;
 	intptr_t err = 0;
 
 	/* connect & send requests */
@@ -282,16 +267,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		if (use_udp)
 			goto send;
 
-		/* check connection, it can be closed */
-		int ret = 0;
-		if (cfd != -1)
-			ret = recv(cfd, buf, 1, MSG_DONTWAIT);
-
-		if (ret == 0) {
-			/* try to reconnect and send */
-			if (cfd != -1)
-				SAFE_CLOSE(cfd);
-
+		if (cfd == -1) {
 			cfd = client_connect_send(client_msg, client_msg_size);
 			if (cfd == -1) {
 				err = errno;
@@ -302,12 +278,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 				err = errno;
 				break;
 			}
-
 			continue;
-
-		} else if (ret > 0) {
-			err = EMSGSIZE;
-			break;
 		}
 
 send:
@@ -316,11 +287,8 @@ send:
 				"try to send msg[%d]", i);
 		}
 
-		if (send(cfd, client_msg, client_msg_size,
-			MSG_NOSIGNAL) != client_msg_size) {
-			err = ECOMM;
-			break;
-		}
+		SAFE_SEND(1, cfd, client_msg, client_msg_size, MSG_NOSIGNAL);
+
 		if (client_recv(&cfd, buf)) {
 			err = errno;
 			break;
@@ -331,6 +299,9 @@ send:
 		SAFE_CLOSE(cfd);
 
 out:
+	if (i != client_max_requests)
+		tst_res(TWARN, "client exit on '%d' request", i);
+
 	return (void *) err;
 }
 
@@ -443,13 +414,11 @@ static void client_cleanup(void)
 		freeaddrinfo(remote_addrinfo);
 }
 
-static char *make_server_reply(int size)
+static void make_server_reply(char *send_msg, int size)
 {
-	char *send_msg = SAFE_MALLOC(size);
 	memset(send_msg, server_byte, size - 1);
 	send_msg[0] = start_byte;
 	send_msg[size - 1] = end_byte;
-	return send_msg;
 }
 
 void *server_fn(void *cfd)
@@ -457,11 +426,13 @@ void *server_fn(void *cfd)
 	int client_fd = (intptr_t) cfd;
 	int num_requests = 0, offset = 0;
 	/* Reply will be constructed from first client request */
-	char *send_msg = NULL;
+	char send_msg[max_msg_len];
 	int send_msg_size = 0;
 	char recv_msg[max_msg_len];
 	ssize_t recv_len;
 
+	send_msg[0] = '\0';
+
 	init_socket_opts(client_fd);
 
 	while (1) {
@@ -495,14 +466,14 @@ void *server_fn(void *cfd)
 		}
 
 		/* if we send reply for the first time, construct it here */
-		if (!send_msg) {
+		if (send_msg[0] != start_byte) {
 			send_msg_size = parse_client_request(recv_msg);
 			if (send_msg_size < 0) {
 				tst_res(TFAIL, "wrong msg size '%d'",
 					send_msg_size);
 				goto out;
 			}
-			send_msg = make_server_reply(send_msg_size);
+			make_server_reply(send_msg, send_msg_size);
 		}
 
 		offset = 0;
@@ -514,12 +485,8 @@ void *server_fn(void *cfd)
 		if (!use_udp && ++num_requests >= server_max_requests)
 			send_msg[0] = start_fin_byte;
 
-		if (sendto(client_fd, send_msg, send_msg_size,
-		    MSG_NOSIGNAL, (struct sockaddr *)&remote_addr,
-		    remote_addr_len) < 0) {
-			tst_res(TFAIL | TERRNO, "sendto failed");
-			goto out;
-		}
+		SAFE_SENDTO(1, client_fd, send_msg, send_msg_size, MSG_NOSIGNAL,
+			(struct sockaddr *)&remote_addr, remote_addr_len);
 
 		if (!use_udp && num_requests >= server_max_requests) {
 			/* max reqs, close socket */
@@ -528,12 +495,10 @@ void *server_fn(void *cfd)
 		}
 	}
 
-	free(send_msg);
 	SAFE_CLOSE(client_fd);
 	return NULL;
 
 out:
-	free(send_msg);
 	SAFE_CLOSE(client_fd);
 	tst_brk(TBROK, "Server closed");
 }
@@ -564,7 +529,7 @@ static void server_init(void)
 	/* IPv6 socket is also able to access IPv4 protocol stack */
 	sfd = SAFE_SOCKET(AF_INET6, local_addrinfo->ai_socktype, 0);
 	const int flag = 1;
-	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
+	SAFE_SETSOCKOPT(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
 
 	tst_res(TINFO, "assigning a name to the server socket...");
 	SAFE_BIND(sfd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
@@ -577,9 +542,8 @@ static void server_init(void)
 	init_socket_opts(sfd);
 
 	if (fastopen_api) {
-		if (setsockopt(sfd, IPPROTO_TCP, TCP_FASTOPEN, &tfo_queue_size,
-			sizeof(tfo_queue_size)) == -1)
-			tst_brk(TBROK, "Can't set TFO sock. options");
+		SAFE_SETSOCKOPT(sfd, IPPROTO_TCP, TCP_FASTOPEN,
+			&tfo_queue_size, sizeof(tfo_queue_size));
 	}
 
 	SAFE_LISTEN(sfd, max_queue_len);
-- 
1.7.1

