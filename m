Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE6C52D7C
	for <ltp@archiver.kernel.org>; Sun, 11 Aug 2024 12:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 345FA3D20E7
	for <ltp@archiver.kernel.org>; Sun, 11 Aug 2024 14:34:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E07373CE3C4
 for <ltp@lists.linux.it>; Sun, 11 Aug 2024 14:33:53 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id D3D02600C89
 for <ltp@lists.linux.it>; Sun, 11 Aug 2024 14:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GFxMz
 wQiAGmgK++/Z67lGpXX2sSBuyKtCBrHnA14o7Y=; b=UMlfB6uQcpv+5W57Wf2hB
 QY5HyY/VSu94s4PMqdVFCZ6yTUMV7z05NJRqhUvI8dLZ20mh+SnjQ8ZVnk/NkIug
 7F84EkBDBG4X7qO2DvhcNpaXRuXXzDbCyUD6lVaPv0GDGy0MT7zjWIdxIkgwH4Qf
 cFExx4NpcdqtY9RuWXQusI=
Received: from ubuntu22.localdomain (unknown [171.214.180.39])
 by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wAXHxGor7hmTUDiBQ--.57527S2;
 Sun, 11 Aug 2024 20:33:45 +0800 (CST)
From: chenguanxi11234@163.com
To: ltp@lists.linux.it
Date: Sun, 11 Aug 2024 20:33:42 +0800
Message-Id: <c82e787a5e77e6c7bc7cbac6338f4ce33b1079b2.1722929348.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wAXHxGor7hmTUDiBQ--.57527S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyUJrW3tr18GF4UXw1fWFg_yoW8KFWfpF
 Z7u34vyr95Jr1fKr1fJF1UZ3WFkrWfJ3W8Aryxuw1jk3sayryY9r10qryYqF1xurZ2gFWr
 AryfJa43W3yFqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5xhXUUUUU=
X-Originating-IP: [171.214.180.39]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBZwo4+mV4ImBLdgAAsN
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] posix/conformance/interfaces/sem_timedwait/2-1:
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
Cc: yang.guang5@zte.com.cn, chen.haonan2@zte.com.cn
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
 .../interfaces/sem_timedwait/2-1.c            | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index 655e35108..46e9b696a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -20,6 +20,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <time.h>
+#include <sys/mman.h>
 #include "posixtest.h"
 
 #define TEST "2-1"
@@ -28,12 +29,17 @@
 
 int main(void)
 {
-	sem_t mysemp;
+	sem_t *mysemp;
 	struct timespec ts;
 	int pid;
+	mysemp = mmap(NULL, sizeof(*mysemp), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (mysemp == MAP_FAILED) {
+		perror(ERROR_PREFIX "mmap");
+		return PTS_UNRESOLVED;
+	}
 
 	/* Semaphore started out locked */
-	if (sem_init(&mysemp, 0, 0) == -1) {
+	if (sem_init(mysemp, 1, 0) == -1) {
 		perror(ERROR_PREFIX "sem_init");
 		return PTS_UNRESOLVED;
 	}
@@ -44,19 +50,19 @@ int main(void)
 		ts.tv_sec = time(NULL) + 2;
 		ts.tv_nsec = 0;
 
-		if (sem_timedwait(&mysemp, &ts) == -1) {
+		if (sem_timedwait(mysemp, &ts) == -1) {
 			puts("TEST FAILED");
 			return PTS_FAIL;
 		} else {
 			puts("TEST PASSED");
-			sem_destroy(&mysemp);
+			sem_destroy(mysemp);
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
@@ -65,11 +71,15 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (!WEXITSTATUS(i)) {
+		if (WEXITSTATUS(i)) {
 			return PTS_FAIL;
 		}
 		puts("TEST PASSED");
-		sem_destroy(&mysemp);
+		sem_destroy(mysemp);
+		if (munmap(mysemp, sizeof(*mysemp)) == -1) {
+			perror(ERROR_PREFIX "munmap");
+			return PTS_UNRESOLVED;
+		}
 		return PTS_PASS;
 	}
 	return PTS_UNRESOLVED;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
