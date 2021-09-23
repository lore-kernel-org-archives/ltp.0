Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA4C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:28:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1710461107
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1710461107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C27D63CA1CD
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 15:28:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7D003C79C0
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:27:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 11B7F100054F
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:27:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FF251FD7D
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632403670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E0LHWt+T2FaiddmB91smVyko206OTe28R7XcQf9FwzA=;
 b=spzA3QQDJ6mBbFW7f8nru//AgVv/+R5hVCcOCZMm8wmUCexILqNzjRNUYIRf04niacUnbe
 AIQtdPwl60Yf/WtXjKZfLrkuj8uuveHSL+aT7ho9jT1nT3COsC0l0SsO/Z5mQWCEYWOc7h
 rUs8bkZ1ZpuXZ1NM7LiM/KfTl4lGnIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632403670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E0LHWt+T2FaiddmB91smVyko206OTe28R7XcQf9FwzA=;
 b=YM8tEg4IhNZWfyeZhkyKFN64zHtl8cDfuG5DY6QGLK64tH/ptaJiRid/3BZ226dHXSYh1I
 xoG4zLnJ/PU+2SBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A8D913D42
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 13:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SoorCdaATGEjSwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 13:27:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Sep 2021 15:27:48 +0200
Message-Id: <20210923132749.6383-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Rename get_ipc_timestamp() and move to main LTP
 library
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

The get_ipc_timestamp() helper functions is also needed for generic FS tests.
Rename it to get_fs_timestamp() and move it to tst_clocks.h.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/libnewipc.h                             |  2 --
 include/tst_clocks.h                            |  6 ++++++
 lib/tst_clocks.c                                | 13 +++++++++++++
 libs/libltpnewipc/libnewipc.c                   | 13 -------------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c |  5 +++--
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c |  5 +++--
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |  5 +++--
 7 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/libnewipc.h b/include/libnewipc.h
index 52e054c51..9eec31763 100644
--- a/include/libnewipc.h
+++ b/include/libnewipc.h
@@ -59,6 +59,4 @@ void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
 	probe_free_addr(__FILE__, __LINE__)
 
-time_t get_ipc_timestamp(void);
-
 #endif /* newlibipc.h */
diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index 80030c6b0..b6c8c9d53 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -20,4 +20,10 @@ int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
  */
 const char *tst_clock_name(clockid_t clk_id);
 
+/*
+ * Returns current system time for file/IPC operations, which may slightly lag
+ * behind time() return values.
+ */
+time_t get_fs_timestamp(void);
+
 #endif /* TST_CLOCKS__ */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index cdcb9fc4f..ce8eef55b 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -142,3 +142,16 @@ const char *tst_clock_name(clockid_t clk_id)
 		return "INVALID/UNKNOWN CLOCK";
 	}
 }
+
+time_t get_fs_timestamp(void)
+{
+	struct timespec ts;
+	int ret;
+
+	ret = tst_clock_gettime(CLOCK_REALTIME_COARSE, &ts);
+
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clock_gettime(CLOCK_REALTIME_COARSE)");
+
+	return ts.tv_sec;
+}
diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
index 4ae040f3b..331f1b1f5 100644
--- a/libs/libltpnewipc/libnewipc.c
+++ b/libs/libltpnewipc/libnewipc.c
@@ -23,7 +23,6 @@
 #include "libnewipc.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_sysv_ipc.h"
-#include "tst_clocks.h"
 
 #define BUFSIZE 1024
 
@@ -87,15 +86,3 @@ void *probe_free_addr(const char *file, const int lineno)
 
 	return addr;
 }
-
-time_t get_ipc_timestamp(void)
-{
-	struct timespec ts;
-	int ret;
-
-	ret = tst_clock_gettime(CLOCK_REALTIME_COARSE, &ts);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clock_gettime(CLOCK_REALTIME_COARSE)");
-
-	return ts.tv_sec;
-}
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index afe552c4f..333171654 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -9,6 +9,7 @@
 #include <sys/wait.h>
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "tst_clocks.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
@@ -25,13 +26,13 @@ static void verify_msgrcv(void)
 
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	before_rcv = get_ipc_timestamp();
+	before_rcv = get_fs_timestamp();
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv failed");
 		return;
 	}
-	after_rcv = get_ipc_timestamp();
+	after_rcv = get_fs_timestamp();
 
 	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
 		tst_res(TPASS, "message received(%s) = message sent(%s)",
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 432b03def..c6c4eb303 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -15,6 +15,7 @@
 
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "tst_clocks.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
@@ -29,13 +30,13 @@ static void verify_msgsnd(void)
 	struct msqid_ds qs_buf;
 	time_t before_snd, after_snd;
 
-	before_snd = get_ipc_timestamp();
+	before_snd = get_fs_timestamp();
 	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
 		return;
 	}
-	after_snd = get_ipc_timestamp();
+	after_snd = get_fs_timestamp();
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index b32752fb1..7f1c913bd 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "tst_clocks.h"
 #include "libnewipc.h"
 
 #define NCHILD 20
@@ -243,9 +244,9 @@ static int get_shm_idx_from_id(int shm_id)
 
 static void setup(void)
 {
-	ctime_min = get_ipc_timestamp();
+	ctime_min = get_fs_timestamp();
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
-	ctime_max = get_ipc_timestamp();
+	ctime_max = get_fs_timestamp();
 
 	shm_idx = get_shm_idx_from_id(shm_id);
 
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
