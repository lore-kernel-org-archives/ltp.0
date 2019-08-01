From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:16 +0200
Subject: [LTP] [RFC PATCH 9/9] syscalls/sendmmsg01: Make use of guarded
 buffers.
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190801092616.30553-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We also send one more byte in the second buffer in an attempt to trick
the kernel to write after the second iovec used for receive. Note that
because this is UDP connection this byte is then discarded in kernel and
we don't have to anything even when the test is running in a loop with
the -i parameter.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 68 +++++++++----------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index 7411467ee..37084102e 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -22,35 +22,27 @@
 
 static int send_sockfd;
 static int receive_sockfd;
-static struct mmsghdr msg[VLEN];
-static struct iovec msg1[2], msg2;
+static struct mmsghdr *snd_msg, *rcv_msg;
+static struct iovec *snd1, *snd2, *rcv1, *rcv2;
 
 static void run(void)
 {
-	struct mmsghdr msgs_in[VLEN];
-	struct iovec iovecs[VLEN];
-	char bufs[VLEN][BUFSIZE+1];
 	struct timespec timeout;
-	int i, retval;
+	int retval;
 
-	retval = do_sendmmsg(send_sockfd, msg, VLEN, 0);
-	if (retval < 0 || msg[0].msg_len != 6 || msg[1].msg_len != 5) {
+	retval = do_sendmmsg(send_sockfd, snd_msg, VLEN, 0);
+	if (retval < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
 		tst_res(TFAIL|TTERRNO, "sendmmsg failed");
 		return;
 	}
 
-	memset(msgs_in, 0, sizeof(msgs_in));
-	for (i = 0; i < VLEN; i++) {
-		iovecs[i].iov_base = bufs[i];
-		iovecs[i].iov_len = BUFSIZE;
-		msgs_in[i].msg_hdr.msg_iov = &iovecs[i];
-		msgs_in[i].msg_hdr.msg_iovlen = 1;
-	}
+	memset(rcv1->iov_base, 0, rcv1->iov_len);
+	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
 	timeout.tv_sec = 1;
 	timeout.tv_nsec = 0;
 
-	retval = do_recvmmsg(receive_sockfd, msgs_in, VLEN, 0, &timeout);
+	retval = do_recvmmsg(receive_sockfd, rcv_msg, VLEN, 0, &timeout);
 
 	if (retval == -1) {
 		tst_res(TFAIL | TTERRNO, "recvmmsg failed");
@@ -62,14 +54,12 @@ static void run(void)
 		return;
 	}
 
-	bufs[0][msgs_in[0].msg_len] = 0;
-	if (strcmp(bufs[0], "onetwo"))
+	if (memcmp(rcv1->iov_base, "onetwo", 6))
 		tst_res(TFAIL, "Error in first received message");
 	else
 		tst_res(TPASS, "First message received successfully");
 
-	bufs[1][msgs_in[1].msg_len] = 0;
-	if (strcmp(bufs[1], "three"))
+	if (memcmp(rcv2->iov_base, "three", 5))
 		tst_res(TFAIL, "Error in second received message");
 	else
 		tst_res(TPASS, "Second message received successfully");
@@ -88,24 +78,23 @@ static void setup(void)
 	addr.sin_port = port;
 
 	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
-	SAFE_CONNECT(send_sockfd, (struct sockaddr *) &addr, sizeof(addr));
-
-	memset(msg1, 0, sizeof(msg1));
-	msg1[0].iov_base = "one";
-	msg1[0].iov_len = 3;
-	msg1[1].iov_base = "two";
-	msg1[1].iov_len = 3;
+	SAFE_CONNECT(send_sockfd, (struct sockaddr *)&addr, sizeof(addr));
 
-	memset(&msg2, 0, sizeof(msg2));
-	msg2.iov_base = "three";
-	msg2.iov_len = 5;
+	memcpy(snd1[0].iov_base, "one", snd1[0].iov_len);
+	memcpy(snd1[1].iov_base, "two", snd1[1].iov_len);
+	memcpy(snd2->iov_base, "three3", snd2->iov_len);
 
-	memset(msg, 0, sizeof(msg));
-	msg[0].msg_hdr.msg_iov = msg1;
-	msg[0].msg_hdr.msg_iovlen = 2;
+	memset(snd_msg, 0, VLEN * sizeof(*snd_msg));
+	snd_msg[0].msg_hdr.msg_iov = snd1;
+	snd_msg[0].msg_hdr.msg_iovlen = 2;
+	snd_msg[1].msg_hdr.msg_iov = snd2;
+	snd_msg[1].msg_hdr.msg_iovlen = 1;
 
-	msg[1].msg_hdr.msg_iov = &msg2;
-	msg[1].msg_hdr.msg_iovlen = 1;
+	memset(rcv_msg, 0, VLEN * sizeof(*rcv_msg));
+	rcv_msg[0].msg_hdr.msg_iov = rcv1;
+	rcv_msg[0].msg_hdr.msg_iovlen = 1;
+	rcv_msg[1].msg_hdr.msg_iov = rcv2;
+	rcv_msg[1].msg_hdr.msg_iovlen = 1;
 
 	test_info();
 }
@@ -123,4 +112,13 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = TEST_VARIANTS,
+	.bufs = (struct tst_buffers []) {
+		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
+		{&snd2, .iov_sizes = (int[]){6, -1}},
+		{&rcv1, .iov_sizes = (int[]){6, -1}},
+		{&rcv2, .iov_sizes = (int[]){5, -1}},
+		{&snd_msg, .size = VLEN * sizeof(*snd_msg)},
+		{&rcv_msg, .size = VLEN * sizeof(*rcv_msg)},
+		{},
+	}
 };
-- 
2.21.0

