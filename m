From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 20 Apr 2021 21:38:39 +0800
Subject: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic in
 do_child()
Message-ID: <20210420133839.145408-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't need do_child() loop 'TEST_LOOPING(lc)' times to invoke the
recvfrom() function, whitch makes no sense. If we run with "-i large number",
this will slow down the program.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/sendfile/sendfile02.c | 14 ++++++++------
 testcases/kernel/syscalls/sendfile/sendfile04.c | 14 ++++++++------
 testcases/kernel/syscalls/sendfile/sendfile05.c | 14 ++++++++------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index e5f115146..acd7a5a50 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -156,15 +156,17 @@ void do_sendfile(OFF_T offset, int i)
  */
 void do_child(void)
 {
-	int lc;
-	socklen_t length;
 	char rbuf[4096];
+	ssize_t ret = 0;
+	socklen_t length = sizeof(sin1);

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		length = sizeof(sin1);
-		recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			 &length);
+	ret = recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1, &length);
+	if (ret < 0) {
+		tst_resm(TFAIL, "child process recvfrom failed: %s\n",
+			 strerror(errno));
+		exit(1);
 	}
+
 	exit(0);
 }

diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 0f315abb0..322e2b58e 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -153,15 +153,17 @@ void do_sendfile(int prot, int pass_unmapped_buffer)
  */
 void do_child(void)
 {
-	int lc;
-	socklen_t length;
 	char rbuf[4096];
+	ssize_t ret = 0;
+	socklen_t length = sizeof(sin1);

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		length = sizeof(sin1);
-		recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			 &length);
+	ret = recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1, &length);
+	if (ret < 0) {
+		tst_resm(TFAIL, "child process recvfrom failed: %s\n",
+			 strerror(errno));
+		exit(1);
 	}
+
 	exit(0);
 }

diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 0f268ceb3..a8e76d91d 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -118,15 +118,17 @@ void do_sendfile(void)
  */
 void do_child(void)
 {
-	int lc;
-	socklen_t length;
 	char rbuf[4096];
+	ssize_t ret = 0;
+	socklen_t length = sizeof(sin1);

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		length = sizeof(sin1);
-		recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1,
-			 &length);
+	ret = recvfrom(sockfd, rbuf, 4096, 0, (struct sockaddr *)&sin1, &length);
+	if (ret < 0) {
+		tst_resm(TFAIL, "child process recvfrom failed: %s\n",
+			 strerror(errno));
+		exit(1);
 	}
+
 	exit(0);
 }

--
2.17.1

