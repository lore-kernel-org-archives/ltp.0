From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 16 Oct 2020 15:45:45 +0800
Subject: [LTP] [PATCH] syscalls/send02: Improve message
Message-ID: <1602834345-24019-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case sometimes fails, output as below:

tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)

From this output, we don't know which subcase fails(tcp,udp,send,sendto).
So add some message and make this clear.

Now this case fails as below:
tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
send02.c:124: TINFO: Testing TCP send
send02.c:87: TFAIL: recv() error at the 776 times(expsize 17): EAGAIN/EWOULDBLOCK (11)
send02.c:124: TINFO: Testing UDP send
send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)
send02.c:124: TINFO: Testing UDP sendto
send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)
send02.c:124: TINFO: Testing UDP sendmsg
send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/send/send02.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/send/send02.c b/testcases/kernel/syscalls/send/send02.c
index 5630230fa..719e86a90 100644
--- a/testcases/kernel/syscalls/send/send02.c
+++ b/testcases/kernel/syscalls/send/send02.c
@@ -71,7 +71,7 @@ static void setup(void)
 	memset(sendbuf, 0x42, SENDSIZE);
 }
 
-static int check_recv(int sock, long expsize)
+static int check_recv(int sock, long expsize, int loop)
 {
 	char recvbuf[RECVSIZE] = {0};
 
@@ -83,19 +83,20 @@ static int check_recv(int sock, long expsize)
 			return 1;
 
 		/* unexpected error */
-		tst_res(TFAIL | TTERRNO, "recv() error");
+		tst_res(TFAIL | TTERRNO, "recv() error at the %d times(expsize"
+			" %ld)", loop, expsize);
 		return 0;
 	}
 
 	if (TST_RET < 0) {
-		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld",
-			TST_RET);
+		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld at"
+			" the %d times(expsize %ld)", TST_RET, loop, expsize);
 		return 0;
 	}
 
 	if (TST_RET != expsize) {
-		tst_res(TFAIL, "recv() read %ld bytes, expected %ld", TST_RET,
-			expsize);
+		tst_res(TFAIL, "recv() read %ld bytes, expected %ld@the"
+			" %d times", TST_RET, expsize, loop);
 		return 0;
 	}
 
@@ -120,6 +121,7 @@ static void run(unsigned int n)
 	struct test_case *tc = testcase_list + n;
 	socklen_t len = sizeof(addr);
 
+	tst_res(TINFO, "Testing %s", tc->name);
 	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 0);
 	listen_sock = SAFE_SOCKET(tc->domain, tc->type, tc->protocol);
 	dst_sock = listen_sock;
@@ -139,19 +141,19 @@ static void run(unsigned int n)
 			dst_sock = SAFE_ACCEPT(listen_sock, NULL, NULL);
 
 		tc->send(sock, sendbuf, SENDSIZE, 0);
-		ret = check_recv(dst_sock, SENDSIZE);
+		ret = check_recv(dst_sock, SENDSIZE, i + 1);
 
 		if (!ret)
 			break;
 
 		tc->send(sock, sendbuf, SENDSIZE, MSG_MORE);
-		ret = check_recv(dst_sock, 0);
+		ret = check_recv(dst_sock, 0, i + 1);
 
 		if (!ret)
 			break;
 
 		tc->send(sock, sendbuf, 1, 0);
-		ret = check_recv(dst_sock, SENDSIZE + 1);
+		ret = check_recv(dst_sock, SENDSIZE + 1, i + 1);
 
 		if (!ret)
 			break;
-- 
2.23.0



