Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B51C47077
	for <ltp@archiver.kernel.org>; Sun, 14 Jan 2024 06:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A24B3CD0A8
	for <ltp@archiver.kernel.org>; Sun, 14 Jan 2024 07:39:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15FC33CA6E3
 for <ltp@lists.linux.it>; Sun, 14 Jan 2024 07:39:06 +0100 (CET)
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id DDD9D1A00670
 for <ltp@lists.linux.it>; Sun, 14 Jan 2024 07:39:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bfF85
 c/8DAAeX5yROX3Lg9ZcYWlxQPvAmCFaUp3TmAw=; b=ph/zBzE6FpU4K6/6UDlKS
 AdUgGX751gl1AN17SJebz9he5j1c0pZN7gb2E3HbaLJ3I71ra4ooZxCWM5bC1dyw
 kNwcKUwvj7LY1y2O9fmIVhtFCNZbXcYg9on+BJ0iaZo0yIPiVyokycZKCHM9dKLh
 6bfP8TmuAUTRWh92RiYNcc=
Received: from ubuntu22.localdomain (unknown [171.213.57.23])
 by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3_wmAgaNluqQEAQ--.42650S2;
 Sun, 14 Jan 2024 14:38:57 +0800 (CST)
From: chenguanxi11234@163.com
To: ltp@lists.linux.it
Date: Sun, 14 Jan 2024 14:38:54 +0800
Message-Id: <977c827a45313499dd372cfda1c5156c2729595d.1704804430.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wD3_wmAgaNluqQEAQ--.42650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw15Jw1xGry8Aw1fZFy7ZFb_yoW5XF4DpF
 ZxCa9Yyr95Jr1Sgry7AF4qvF1FkrZ3JF1UJryxuw10k3sayryYyr4vqry5JF18u392gFWr
 CrWfJa4rX390qr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5xhXUUUUU=
X-Originating-IP: [171.213.57.23]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiQANj+mVOA-BQgQABsS
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] posix/conformance/interfaces/sem_timedwait/2-1:
 Fix test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: yang.guang5@zte.com.cn, Chen Haonan <chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Chen Haonan <chen.haonan2@zte.com.cn>

Since the parent and child processes are not operating on the 
same semaphore, this code wasn't doing its job correctly before,
so we mapped the semaphore to a piece of shared memory and 
changed some implementation details in the original code to make it work.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 .../interfaces/sem_timedwait/2-1.c            | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index 655e35108..f5b9cf921 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -10,13 +10,14 @@
  * will unlock the semaphore from another process.
  */
 
-
+#include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
 #include <semaphore.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <time.h>
@@ -28,12 +29,17 @@
 
 int main(void)
 {
-	sem_t mysemp;
+	sem_t *mysemp;
 	struct timespec ts;
 	int pid;
 
-	/* Semaphore started out locked */
-	if (sem_init(&mysemp, 0, 0) == -1) {
+	/* Map semaphore to shared memory */
+	int shm_fd = shm_open("/myshm", O_CREAT | O_RDWR, 0666);
+
+	ftruncate(shm_fd, sizeof(sem_t));
+	mysemp = (sem_t *)mmap(NULL, sizeof(sem_t), PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
+
+	if (sem_init(mysemp, 1, 0) == -1) {
 		perror(ERROR_PREFIX "sem_init");
 		return PTS_UNRESOLVED;
 	}
@@ -43,20 +49,22 @@ int main(void)
 	{
 		ts.tv_sec = time(NULL) + 2;
 		ts.tv_nsec = 0;
-
-		if (sem_timedwait(&mysemp, &ts) == -1) {
+		if (sem_timedwait(mysemp, &ts) == -1) {
 			puts("TEST FAILED");
+			sem_destroy(mysemp);
+			munmap(mysemp, sizeof(sem_t));
+			close(shm_fd);
+			shm_unlink("/myshm");
 			return PTS_FAIL;
 		} else {
-			puts("TEST PASSED");
-			sem_destroy(&mysemp);
+			puts("TEST PASSED");
 			return PTS_PASS;
 		}
 	} else if (pid > 0)	// parent to unlock semaphore
 	{
 		int i;
 		sleep(1);
-		if (sem_post(&mysemp) == -1) {
+		if (sem_post(mysemp) == -1) {
 			perror(ERROR_PREFIX "sem_post");
 			return PTS_FAIL;
 		}
@@ -64,12 +72,14 @@ int main(void)
 			perror("Error waiting for child to exit");
 			return PTS_UNRESOLVED;
 		}
-
-		if (!WEXITSTATUS(i)) {
+		if (WEXITSTATUS(i)) {
 			return PTS_FAIL;
 		}
 		puts("TEST PASSED");
-		sem_destroy(&mysemp);
+		sem_destroy(mysemp);
+		munmap(mysemp, sizeof(sem_t));
+		close(shm_fd);
+		shm_unlink("/myshm");
 		return PTS_PASS;
 	}
 	return PTS_UNRESOLVED;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
