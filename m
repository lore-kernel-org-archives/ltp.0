From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:10 +0300
Subject: [LTP] [PATCH 3/9] netstress: make socketaddr returned by recvfrom()
	thread-local
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Group other socket parameters into struct as well.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |  100 +++++++++++++++++--------------
 1 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index eec60b8..ccab403 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -128,8 +128,14 @@ static pthread_t *thread_ids;
 
 static struct addrinfo *remote_addrinfo;
 static struct addrinfo *local_addrinfo;
-static struct sockaddr_storage remote_addr;
-static socklen_t remote_addr_len;
+
+struct sock_info {
+	int fd;
+	struct sockaddr_storage raddr;
+	socklen_t raddr_len;
+	int etime_cnt;
+	int timeout;
+};
 
 static void init_socket_opts(int sd)
 {
@@ -163,17 +169,16 @@ static void do_cleanup(void)
 }
 TST_DECLARE_ONCE_FN(cleanup, do_cleanup)
 
-static int sock_recv_poll(int fd, char *buf, int buf_size, int offset,
-			  int *timeout)
+static int sock_recv_poll(char *buf, int size, struct sock_info *i)
 {
 	struct pollfd pfd;
-	pfd.fd = fd;
+	pfd.fd = i->fd;
 	pfd.events = POLLIN;
 	int len = -1;
 
 	while (1) {
 		errno = 0;
-		int ret = poll(&pfd, 1, *timeout);
+		int ret = poll(&pfd, 1, i->timeout);
 		if (ret == -1) {
 			if (errno == EINTR)
 				continue;
@@ -189,9 +194,9 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset,
 			break;
 
 		errno = 0;
-		len = recvfrom(fd, buf + offset, buf_size - offset,
-			       MSG_DONTWAIT, (struct sockaddr *)&remote_addr,
-			       &remote_addr_len);
+		len = recvfrom(i->fd, buf, size, MSG_DONTWAIT,
+			       (struct sockaddr *)&i->raddr,
+			       &i->raddr_len);
 
 		if (len == -1 && errno == EINTR)
 			continue;
@@ -205,14 +210,13 @@ static int sock_recv_poll(int fd, char *buf, int buf_size, int offset,
 	return len;
 }
 
-static int client_recv(int *fd, char *buf, int srv_msg_len, int *etime_cnt,
-		       int *timeout)
+static int client_recv(char *buf, int srv_msg_len, struct sock_info *i)
 {
 	int len, offset = 0;
 
 	while (1) {
 		errno = 0;
-		len = sock_recv_poll(*fd, buf, srv_msg_len, offset, timeout);
+		len = sock_recv_poll(buf + offset, srv_msg_len - offset, i);
 
 		/* socket closed or msg is not valid */
 		if (len < 1 || (offset + len) > srv_msg_len ||
@@ -232,15 +236,15 @@ static int client_recv(int *fd, char *buf, int srv_msg_len, int *etime_cnt,
 	}
 
 	if (errno == ETIME && sock_type != SOCK_STREAM) {
-		if (++(*etime_cnt) > max_etime_cnt)
-			tst_brk(TFAIL, "protocol timeout: %dms", *timeout);
+		if (++(i->etime_cnt) > max_etime_cnt)
+			tst_brk(TFAIL, "protocol timeout: %dms", i->timeout);
 		/* Increase timeout in poll up to 3.2 sec */
-		if (*timeout < 3000)
-			*timeout <<= 1;
+		if (i->timeout < 3000)
+			i->timeout <<= 1;
 		return 0;
 	}
 
-	SAFE_CLOSE(*fd);
+	SAFE_CLOSE(i->fd);
 	return (errno) ? -1 : 0;
 }
 
@@ -294,22 +298,26 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int cln_len = init_cln_msg_len,
 	    srv_len = init_srv_msg_len;
+	struct sock_info inf;
 	char buf[max_msg_len];
 	char client_msg[max_msg_len];
-	int cfd, i = 0, etime_cnt = 0;
+	int i = 0;
 	intptr_t err = 0;
-	int timeout = wait_timeout;
+
+	inf.raddr_len = sizeof(inf.raddr);
+	inf.etime_cnt = 0;
+	inf.timeout = wait_timeout;
 
 	make_client_request(client_msg, &cln_len, &srv_len);
 
 	/* connect & send requests */
-	cfd = client_connect_send(client_msg, cln_len);
-	if (cfd == -1) {
+	inf.fd = client_connect_send(client_msg, cln_len);
+	if (inf.fd == -1) {
 		err = errno;
 		goto out;
 	}
 
-	if (client_recv(&cfd, buf, srv_len, &etime_cnt, &timeout)) {
+	if (client_recv(buf, srv_len, &inf)) {
 		err = errno;
 		goto out;
 	}
@@ -318,15 +326,14 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		if (proto_type == TYPE_UDP)
 			goto send;
 
-		if (cfd == -1) {
-			cfd = client_connect_send(client_msg, cln_len);
-			if (cfd == -1) {
+		if (inf.fd == -1) {
+			inf.fd = client_connect_send(client_msg, cln_len);
+			if (inf.fd == -1) {
 				err = errno;
 				goto out;
 			}
 
-			if (client_recv(&cfd, buf, srv_len, &etime_cnt,
-			    &timeout)) {
+			if (client_recv(buf, srv_len, &inf)) {
 				err = errno;
 				break;
 			}
@@ -337,16 +344,16 @@ send:
 		if (max_rand_msg_len)
 			make_client_request(client_msg, &cln_len, &srv_len);
 
-		SAFE_SEND(1, cfd, client_msg, cln_len, MSG_NOSIGNAL);
+		SAFE_SEND(1, inf.fd, client_msg, cln_len, MSG_NOSIGNAL);
 
-		if (client_recv(&cfd, buf, srv_len, &etime_cnt, &timeout)) {
+		if (client_recv(buf, srv_len, &inf)) {
 			err = errno;
 			break;
 		}
 	}
 
-	if (cfd != -1)
-		SAFE_CLOSE(cfd);
+	if (inf.fd != -1)
+		SAFE_CLOSE(inf.fd);
 
 out:
 	if (i != client_max_requests)
@@ -468,22 +475,25 @@ static void make_server_reply(char *send_msg, int size)
 
 void *server_fn(void *cfd)
 {
-	int client_fd = (intptr_t) cfd;
 	int num_requests = 0, offset = 0;
-	int timeout = wait_timeout;
 	/* Reply will be constructed from first client request */
 	char send_msg[max_msg_len];
 	int send_msg_len = 0;
 	char recv_msg[max_msg_len];
+	struct sock_info inf;
 	ssize_t recv_len;
 
+	inf.fd = (intptr_t) cfd;
+	inf.raddr_len = sizeof(inf.raddr);
+	inf.timeout = wait_timeout;
+
 	send_msg[0] = '\0';
 
-	init_socket_opts(client_fd);
+	init_socket_opts(inf.fd);
 
 	while (1) {
-		recv_len = sock_recv_poll(client_fd, recv_msg,
-			max_msg_len, offset, &timeout);
+		recv_len = sock_recv_poll(recv_msg + offset,
+					  max_msg_len - offset, &inf);
 
 		if (recv_len == 0)
 			break;
@@ -491,7 +501,7 @@ void *server_fn(void *cfd)
 		if (recv_len < 0 || (offset + recv_len) > max_msg_len ||
 		   (recv_msg[0] != start_byte &&
 		    recv_msg[0] != start_fin_byte)) {
-			tst_res(TFAIL, "recv failed, sock '%d'", client_fd);
+			tst_res(TFAIL, "recv failed, sock '%d'", inf.fd);
 			goto out;
 		}
 
@@ -526,28 +536,28 @@ void *server_fn(void *cfd)
 
 		switch (proto_type) {
 		case TYPE_SCTP:
-			SAFE_SEND(1, client_fd, send_msg, send_msg_len,
+			SAFE_SEND(1, inf.fd, send_msg, send_msg_len,
 				MSG_NOSIGNAL);
 		break;
 		default:
-			SAFE_SENDTO(1, client_fd, send_msg, send_msg_len,
-				MSG_NOSIGNAL, (struct sockaddr *)&remote_addr,
-				remote_addr_len);
+			SAFE_SENDTO(1, inf.fd, send_msg, send_msg_len,
+				MSG_NOSIGNAL, (struct sockaddr *)&inf.raddr,
+				inf.raddr_len);
 		}
 
 		if (sock_type == SOCK_STREAM &&
 		    num_requests >= server_max_requests) {
 			/* max reqs, close socket */
-			shutdown(client_fd, SHUT_WR);
+			shutdown(inf.fd, SHUT_WR);
 			break;
 		}
 	}
 
-	SAFE_CLOSE(client_fd);
+	SAFE_CLOSE(inf.fd);
 	return NULL;
 
 out:
-	SAFE_CLOSE(client_fd);
+	SAFE_CLOSE(inf.fd);
 	tst_brk(TBROK, "Server closed");
 	return NULL;
 }
@@ -790,8 +800,6 @@ static void setup(void)
 		}
 	}
 
-	remote_addr_len = sizeof(struct sockaddr_storage);
-
 	switch (proto_type) {
 	case TYPE_TCP:
 		tst_res(TINFO, "TCP %s is using %s TCP API.",
-- 
1.7.1

