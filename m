Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC3C71135
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750069656; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ZU3zysS0FBZLzOh23f5MwfW6Bty8n1iHUncGSuj7FyM=;
 b=CFV1kZc9LH4Zec7BHF/op8s+eC0/oAt2uSpLOtd3FGmlV4JKcyMqCxwwqJ88ceItHmSQQ
 Hbo3Dmc66TNrkhoSqcMwhg627Ljx1lkH5C1l2UKrGGrd56s+ybX++0mf9AdCJNhm9yykFSv
 vk4Sdsmb3ZUBBI3cq4E2OPtDKV3O9ao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B735D3CC026
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 12:27:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C2AE3CC02B
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D60691A009AE
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750069590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnBPb2EEvfePFP9smC162PtbVeEraleWY+kBi5wMdSY=;
 b=QCBsF/plyoKH+yJSRaBa05Ihjw81VO/K2ZCod/VtEU1egKR5y7SY5oKr8pqk/oaWukYxpm
 v2VFiuasndZmxHW7Gq8EsW85V4hlRUiNHY2pPCMs6ngVkCZYX4W41zSL+Ps8KaykmZEfLG
 cxWCJabaoq4kMXCZiDL5vDFtnNSMFfM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-jBjDC8ocMYmnEsYynFx7hQ-1; Mon,
 16 Jun 2025 06:26:26 -0400
X-MC-Unique: jBjDC8ocMYmnEsYynFx7hQ-1
X-Mimecast-MFC-AGG-ID: jBjDC8ocMYmnEsYynFx7hQ_1750069586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A3AF1800289; Mon, 16 Jun 2025 10:26:25 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D31D195608F; Mon, 16 Jun 2025 10:26:23 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 16 Jun 2025 18:26:17 +0800
Message-ID: <20250616102619.54254-2-liwang@redhat.com>
In-Reply-To: <20250616102619.54254-1-liwang@redhat.com>
References: <20250616102619.54254-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HjGmYcET4thWtvIqTKP7HpW0ycczv9QJIYhedyQ02WA_1750069586
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] shell/lib: refactor checkpoint with shared path
 for exec() support
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch refactors shell checkpoint mechanism to support exec()
based process synchronization by introducing support for a shared
futex region via a configurable path.

Key changes:

 - Introduce LTP_IPC_PATH environment variable to specify the futex
   shared memory file used for checkpoint synchronization.
 - Add magic header "LTPM" to validate the shared memory file content.
 - Add checkpoint_reinit() to re-attach futex mapping for wait/wake
   operations in exec()'ed processes.
 - Update tst_checkpoint CLI tool to support "init", "wait", and "wake"
   commands with a unified interface.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_checkpoint_fn.h    | 20 +++++++++-
 lib/tst_checkpoint.c           | 70 +++++++++++++++++++++++-----------
 testcases/lib/tst_checkpoint.c | 27 +++++++------
 testcases/lib/tst_test.sh      |  2 +
 4 files changed, 83 insertions(+), 36 deletions(-)

diff --git a/include/tst_checkpoint_fn.h b/include/tst_checkpoint_fn.h
index 3a010d616..209296fe0 100644
--- a/include/tst_checkpoint_fn.h
+++ b/include/tst_checkpoint_fn.h
@@ -6,13 +6,29 @@
 #define TST_CHECKPOINT_FN__
 
 /*
- * Checkpoint initializaton, must be done first.
+ * Checkpoint initialization.
  *
- * NOTE: tst_tmpdir() must be called beforehand.
+ * This function sets up the shared memory region used for process
+ * synchronization via futexes. It must be called before any checkpoint
+ * operations such as tst_checkpoint_wait() or tst_checkpoint_wake().
  */
 void tst_checkpoint_init(const char *file, const int lineno,
 			 void (*cleanup_fn)(void));
 
+/*
+ * Checkpoint reinitialization.
+ *
+ * This function re-attaches to an existing shared memory checkpoint region
+ * pointed to by the LTP_IPC_PATH environment variable. It is typically used
+ * in child processes (e.g., shell scripts) to synchronize with the main test.
+ *
+ * The function verifies the magic header in the shared memory file and maps
+ * the futex array into memory. It must be called before using checkpoint
+ * operations in a process that did not perform the original initialization.
+ */
+void tst_checkpoint_reinit(const char *file, const int lineno,
+			   void (*cleanup_fn)(void));
+
 /*
  * Waits for wakeup.
  *
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 6a294b28b..5efbf98d2 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -38,8 +38,9 @@ unsigned int tst_max_futexes;
 void tst_checkpoint_init(const char *file, const int lineno,
                          void (*cleanup_fn)(void))
 {
+	char *path = getenv("LTP_IPC_PATH");
+	size_t page_size = getpagesize();
 	int fd;
-	unsigned int page_size;
 
 	if (tst_futexes) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
@@ -47,35 +48,58 @@ void tst_checkpoint_init(const char *file, const int lineno,
 		return;
 	}
 
-	/*
-	 * The parent test process is responsible for creating the temporary
-	 * directory and therefore must pass non-zero cleanup (to remove the
-	 * directory if something went wrong).
-	 *
-	 * We cannot do this check unconditionally because if we need to init
-	 * the checkpoint from a binary that was started by exec() the
-	 * tst_tmpdir_created() will return false because the tmpdir was
-	 * created by parent. In this case we expect the subprogram can call
-	 * the init as a first function with NULL as cleanup function.
-	 */
-	if (cleanup_fn && !tst_tmpdir_created()) {
-		tst_brkm_(file, lineno, TBROK, cleanup_fn,
-			"You have to create test temporary directory "
-			"first (call tst_tmpdir())");
-		return;
+	if (!path) {
+		char *tmp_path = NULL;
+
+		if (!tst_tmpdir_created())
+			tst_tmpdir();
+
+		safe_asprintf(__FILE__, __LINE__, cleanup_fn, &tmp_path,
+				"%s/ltp_checkpoint", tst_get_tmpdir());
+		path = tmp_path;
 	}
 
-	page_size = getpagesize();
+	fd = SAFE_OPEN(cleanup_fn, path, O_RDWR | O_CREAT, 0666);
+	SAFE_WRITE(cleanup_fn, 1, fd, "LTPM", 4);
+
+	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	tst_futexes = (futex_t *)((char *)tst_futexes + 4);
+	tst_max_futexes = (page_size - 4) / sizeof(futex_t);
+
+	SAFE_CLOSE(cleanup_fn, fd);
+}
+
+void tst_checkpoint_reinit(const char *file, const int lineno,
+			   void (*cleanup_fn)(void))
+{
+	const char *path = getenv("LTP_IPC_PATH");
+	size_t page_size = getpagesize();
+	int fd;
 
-	fd = SAFE_OPEN(cleanup_fn, "checkpoint_futex_base_file",
-	               O_RDWR | O_CREAT, 0666);
+	if (!path) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"LTP_IPC_PATH is not defined");
+	}
 
-	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
+	if (access(path, F_OK)) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"File %s does not exist!", path);
+	}
 
+	fd = SAFE_OPEN(cleanup_fn, path, O_RDWR);
 	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
-	                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	char *ptr = (char *)tst_futexes;
+	if (memcmp(ptr, "LTPM", 4) != 0) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"Invalid shared memory region (bad magic)");
+	}
 
-	tst_max_futexes = page_size / sizeof(uint32_t);
+	tst_futexes = (futex_t *)((char *)tst_futexes + 4);
+	tst_max_futexes = (page_size - 4) / sizeof(futex_t);
 
 	SAFE_CLOSE(cleanup_fn, fd);
 }
diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
index c70c4e8e5..35a0c0dfa 100644
--- a/testcases/lib/tst_checkpoint.c
+++ b/testcases/lib/tst_checkpoint.c
@@ -9,11 +9,14 @@
 #include <stdlib.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_checkpoint.h"
 
 static void print_help(void)
 {
-	printf("Usage: tst_checkpoint wait TIMEOUT ID\n");
+	printf("Usage: tst_checkpoint init\n");
+	printf("   or: tst_checkpoint wait TIMEOUT ID\n");
 	printf("   or: tst_checkpoint wake TIMEOUT ID NR_WAKE\n");
+	printf("Arguments:\n");
 	printf("       TIMEOUT - timeout in ms\n");
 	printf("       ID - checkpoint id\n");
 	printf("       NR_WAKE - number of processes to wake up\n");
@@ -43,8 +46,13 @@ int main(int argc, char *argv[])
 	int ret;
 	int type;
 
-	if (argc < 3)
-		goto help;
+	if (!strcmp(argv[1], "init")) {
+		if (argc != 2)
+			goto help;
+
+		tst_checkpoint_init(__FILE__, __LINE__, NULL);
+		return 0;
+	}
 
 	if (!strcmp(argv[1], "wait")) {
 		type = 0;
@@ -70,17 +78,14 @@ int main(int argc, char *argv[])
 		goto help;
 	}
 
-	tst_reinit();
+	tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
 
-	if (type)
-		ret = tst_checkpoint_wake(id, nr_wake, timeout);
-	else
+	if (type == 0)
 		ret = tst_checkpoint_wait(id, timeout);
-
-	if (ret)
-		return 1;
 	else
-		return 0;
+		ret = tst_checkpoint_wake(id, nr_wake, timeout);
+
+	return ret ? 1 : 0;
 
 help:
 	print_help();
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c32bd8b19..e5e76067b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -629,6 +629,8 @@ _tst_init_checkpoints()
 	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
 	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
 	export LTP_IPC_PATH
+
+	tst_checkpoint init
 }
 
 _prepare_device()
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
