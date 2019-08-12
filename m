From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:34 +0200
Subject: [LTP] [PATCH v2 04/11] syscalls/accept02: Make use of guarded
 buffers.
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept02.c | 41 +++++++++++----------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index df048ede4..1a0f625c9 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -33,10 +33,9 @@ static int client_sockfd;
 static int server_port;
 static socklen_t addr_len;
 
-static struct sockaddr_in server_addr;
-static struct sockaddr_in client_addr;
-static struct group_req mc_group;
-
+static struct sockaddr_in *server_addr;
+static struct sockaddr_in *client_addr;
+static struct group_req *mc_group;
 
 static void *server_thread(void *arg)
 {
@@ -44,27 +43,27 @@ static void *server_thread(void *arg)
 
 	op = 1;
 	op_len = sizeof(op);
-	mc_group_len = sizeof(mc_group);
+	mc_group_len = sizeof(*mc_group);
 
 	server_sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
 
 	SAFE_SETSOCKOPT(server_sockfd, SOL_SOCKET, SO_REUSEADDR, &op, op_len);
 	SAFE_SETSOCKOPT(server_sockfd, SOL_IP, MCAST_JOIN_GROUP,
-			&mc_group, mc_group_len);
+			mc_group, mc_group_len);
 
-	SAFE_BIND(server_sockfd, (struct sockaddr *)&server_addr, addr_len);
+	SAFE_BIND(server_sockfd, (struct sockaddr *)server_addr, addr_len);
 	SAFE_LISTEN(server_sockfd, 1);
 
 	TST_CHECKPOINT_WAKE(0);
 
-	TEST(accept(server_sockfd, (struct sockaddr *)&client_addr, &addr_len));
+	TEST(accept(server_sockfd, (struct sockaddr *)client_addr, &addr_len));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "Could not accept connection");
 
 	clone_server_sockfd = TST_RET;
 
 	TEST(setsockopt(clone_server_sockfd, SOL_IP, MCAST_LEAVE_GROUP,
-			&mc_group, mc_group_len));
+			mc_group, mc_group_len));
 
 	if (TST_RET != -1)
 		tst_res(TFAIL, "Multicast group was copied!");
@@ -80,9 +79,9 @@ static void *server_thread(void *arg)
 static void *client_thread(void *arg)
 {
 	client_sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	SAFE_BIND(client_sockfd, (struct sockaddr *)&client_addr, addr_len);
+	SAFE_BIND(client_sockfd, (struct sockaddr *)client_addr, addr_len);
 
-	SAFE_CONNECT(client_sockfd, (struct sockaddr *)&server_addr, addr_len);
+	SAFE_CONNECT(client_sockfd, (struct sockaddr *)server_addr, addr_len);
 
 	SAFE_CLOSE(client_sockfd);
 	return arg;
@@ -92,8 +91,8 @@ static void run(void)
 {
 	pthread_t server_thr, client_thr;
 
-	server_addr.sin_port = server_port;
-	client_addr.sin_port = htons(0);
+	server_addr->sin_port = server_port;
+	client_addr->sin_port = htons(0);
 
 	SAFE_PTHREAD_CREATE(&server_thr, NULL, server_thread, NULL);
 	TST_CHECKPOINT_WAIT(0);
@@ -107,16 +106,20 @@ static void setup(void)
 {
 	struct sockaddr_in *mc_group_addr;
 
-	mc_group.gr_interface = 0;
-	mc_group_addr = (struct sockaddr_in *) &mc_group.gr_group;
+	server_addr = tst_alloc(sizeof(*server_addr));
+	client_addr = tst_alloc(sizeof(*client_addr));
+	mc_group = tst_alloc(sizeof(*mc_group));
+
+	mc_group->gr_interface = 0;
+	mc_group_addr = (struct sockaddr_in *) &mc_group->gr_group;
 	mc_group_addr->sin_family = AF_INET;
 	inet_aton(MULTICASTIP, &mc_group_addr->sin_addr);
 
-	server_addr.sin_family = AF_INET;
-	inet_aton(LOCALHOSTIP, &server_addr.sin_addr);
+	server_addr->sin_family = AF_INET;
+	inet_aton(LOCALHOSTIP, &server_addr->sin_addr);
 
-	client_addr.sin_family = AF_INET;
-	client_addr.sin_addr.s_addr = htons(INADDR_ANY);
+	client_addr->sin_family = AF_INET;
+	client_addr->sin_addr.s_addr = htons(INADDR_ANY);
 
 	addr_len = sizeof(struct sockaddr_in);
 
-- 
2.21.0

