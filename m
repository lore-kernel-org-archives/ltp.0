Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD2DC47073
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:23:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 115683CE521
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 11:23:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C0DE3CB8AB
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 14:51:01 +0100 (CET)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id D4DCD200AD5
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 14:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HcP3N
 Wj9V4wkC8qpxcwGoUijSS0s37y+btjFBVFiSwk=; b=fQ8yWkgC3MHEIYDW2RoKy
 rOnYHk5dO6FfxzZdCnKJiNBASMesGU4yT+EhhkfmTeJ2Z6j8vCFpLLvbBIxnF+wO
 TciecqNujbMHjN40CV8NDtYFAeYj8pqng3IkZSv/iMNbo1XjKKNJul5t4FyVGHnl
 urAZMGQwUAYa8KSNZ2/Cuk=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
 by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDXv2fA_ZtlD5BxAg--.912S2; 
 Mon, 08 Jan 2024 21:50:56 +0800 (CST)
From: chenguanxi11234@163.com
To: ltp@lists.linux.it
Date: Mon,  8 Jan 2024 21:50:54 +0800
Message-Id: <ebf6297f90def1cac9f2d6202941b343c361c5a6.1704703396.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wDXv2fA_ZtlD5BxAg--.912S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw15Jw1xJw15Gr4kuryrCrg_yoW5CF4DpF
 Z3Aayvyr95Jr1Sgry7AFsFvF1FkrZ3JFyUJry7uw1jy3sayr1Yyr4ktry5JF4xu392gFWr
 CrWrtFyfX390qr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvzuNUUUUU=
X-Originating-IP: [117.176.219.50]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiVAFf+mVOA6BPuQAAsO
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 09 Jan 2024 11:23:10 +0100
Subject: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1: Fix
 test
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
so we mapped the semaphore to a piece of shared memory and changed 
some implementation details in the original code to make it work.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 .../interfaces/sem_timedwait/2-1.c            | 41 ++++++++++++++-----
 1 file changed, 30 insertions(+), 11 deletions(-)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index 655e35108..3082140e3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -10,13 +10,24 @@
  * will unlock the semaphore from another process.
  */
 
+/* Modifications by: Chen Haonan <chen.haonan2@zte.com.cn>
+ * Date: 2024-01-08
+ *
+ * Since the parent and child processes are not operating on
+ * the same semaphore, this code wasn't doing its job correctly
+ * before, so we mapped the semaphore to a piece of shared
+ * memory and changed some implementation details in the
+ * original code to make it work.
+ */
 
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
@@ -28,12 +39,16 @@
 
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
@@ -43,20 +58,22 @@ int main(void)
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
@@ -64,12 +81,14 @@ int main(void)
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
