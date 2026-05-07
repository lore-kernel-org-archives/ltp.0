Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2DBCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:47:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6303E2C5B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:47:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFAF3E2497
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:47:01 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38E6F600800
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:47:01 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778147220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qvOKTAxwUefEXuRbtpzaWZ89eyy1Qm9k+27N/cudaYU=;
 b=qIntJ/CdF9pW/DVC9bOkFSifhoGeJn6GF96ftc6jFrrx/OSlUDwD00oVEFtQBAjA5YQdY2
 USt+oPbVwvjF8PaV+pWSGfsS3ID6no/j8g8N3eSv+RZpiXzGM7HXYbB5rrMoLZRWDARjg7
 ylZ1hpjR4caJSP7v8zdEPd2HA9qFo2Q=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 17:46:43 +0800
Message-ID: <20260507094643.47079-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima: rewrite ima_mmap auxiliary with
 TST_NO_DEFAULT_MAIN
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 7276e7c154 ("ima_violations.sh: ima_mmap.c: Replace sleep with
checkpoints") called tst_reinit() inside the run() callback of a
struct tst_test based binary. This is incorrect because the test
framework has already initialized the IPC during setup, and calling
tst_reinit() re-maps the shared memory to the parent shell's IPC
region, corrupting the C binary's own test infrastructure.

Fix this by converting ima_mmap to a TST_NO_DEFAULT_MAIN helper
binary. In this mode there is no prior framework initialization, so
tst_reinit() correctly attaches to the parent shell test's shared
memory for checkpoint communication, following the same pattern used
by other LTP helper binaries (e.g. execvp01_child).

Fixes: 7276e7c154 ("ima_violations.sh: ima_mmap.c: Replace sleep with checkpoints")
Signed-off-by: Li Wang <li.wang@linux.dev>
---
 .../security/integrity/ima/src/ima_mmap.c     | 40 ++++++-------------
 .../integrity/ima/tests/ima_violations.sh     |  5 +--
 2 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 09b22fd4f..1861147f8 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -7,46 +7,30 @@
  * Mimi Zohar <zohar@us.ibm.com>
  */
 
+#define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
 #define MMAPSIZE 1024
 
-static char *filename;
-static void *file;
-static int fd;
-
-static void cleanup(void)
+int main(int argc, char *argv[])
 {
-	if (file)
-		SAFE_MUNMAP(file, MMAPSIZE);
-
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-}
+	int fd;
+	void *file;
 
-static void run(void)
-{
-	if (!filename)
-		tst_brk(TBROK, "missing filename (-f filename)");
+	tst_reinit();
 
-	fd = SAFE_OPEN(filename, O_CREAT | O_RDWR, S_IRWXU);
+	if (argc != 2)
+		tst_brk(TBROK, "usage: ima_mmap <filename>");
 
+	fd = SAFE_OPEN(argv[1], O_CREAT | O_RDWR, S_IRWXU);
 	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	SAFE_CLOSE(fd);
 
-	tst_reinit();
-	TST_CHECKPOINT_WAIT(0);
-	/* keep running until ima_violations.sh open and close file */
+	/* Waiting until ima_violations.sh open and close file */
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
+	SAFE_MUNMAP(file, MMAPSIZE);
 	tst_res(TPASS, "test completed");
-}
 
-static struct tst_test test = {
-	.options = (struct tst_option[]) {
-		{"f:", &filename, "File to mmap"},
-		{}
-	},
-	.test_all = run,
-	.cleanup = cleanup,
-};
+	return 0;
+}
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index d7dcd077b..6271bba35 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -170,11 +170,10 @@ test3()
 
 	echo 'testing testing' > $FILE
 
-	ima_mmap -f $FILE &
+	ima_mmap $FILE &
 	pid=$!
 
-	# wait for violations appear in logs
-	TST_CHECKPOINT_WAKE_AND_WAIT 0
+	TST_CHECKPOINT_WAIT 0
 
 	open_file_read
 	close_file_read
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
