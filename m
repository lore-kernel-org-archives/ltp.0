Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B4C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 13:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 157623C9296
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 14:51:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934F63C2BA4
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 14:51:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94CEE200DED
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 14:51:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1491F384;
 Wed, 22 Dec 2021 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640181062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tnumUxlt1cwB4za6iXDGfp1CcsIHJkSa2R0sHWGexQo=;
 b=JBkQUCRFrRD8BTB3QN9K06c3attqKH230gYrE+xMVZXoKTLEe0rzE6eGgvUUF5QjABITBj
 FVbm9EMwNPWWlGNmYG86yZN0Rmc8oC3JtMGFRD6UjH9Dg162kKvZsoGcLo7aSnM9IGDI/5
 KCLSn/3FO5MTq5xUFG6svwATNi/OkRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640181062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tnumUxlt1cwB4za6iXDGfp1CcsIHJkSa2R0sHWGexQo=;
 b=HRN3AILnhOPRQN+YOIsQXcuBFpXggA/TIXQ/iCx8XV+kxbwVe+Y9mlAYLiGsx1u2Zh16F3
 9xe01YOMIfh5H8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6531D13D10;
 Wed, 22 Dec 2021 13:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VicHF0Ytw2EbVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Dec 2021 13:51:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Dec 2021 14:52:34 +0100
Message-Id: <20211222135234.30025-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: Do not fail a test if oom score cannot be
 adjusted.
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

From: Petr Vorel <pvorel@suse.cz>

Setting value < 0 in /proc/*/oom_score_adj requires CAP_SYS_RESOURCE or
CAP_SYS_ADMIN. However setting the library process score is a best
effort operation, so let's skip it silently when the user is not
privileged to do so.

Fixes: 8a0827766d ("lib: add functions to adjust oom score")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_memutils.h |  6 ++++-
 lib/tst_memutils.c     | 55 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 68a6e3771..855c6f289 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -28,13 +28,17 @@ long long tst_available_mem(void);
 /*
  * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
  *   echo -1000 >/proc/$PID/oom_score_adj
+ *
  * If the pid is 0 which means it will set on current(self) process.
  *
+ *  Unless the process has CAP_SYS_RESOURCE or CAP_SYS_ADMIN this call will be
+ *  no-op because setting adj value < 0 requires it.
+ *
  * Note:
  *  This exported tst_enable_oom_protection function can be used at anywhere
  *  you want to protect, but please remember that if you do enable protection
  *  on a process($PID) that all the children will inherit its score and be
- *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection
+ *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection()
  *  to be used in combination.
  */
 void tst_enable_oom_protection(pid_t pid);
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 4dea30330..4a47bbb33 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -11,6 +11,8 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_capability.h"
+#include "lapi/syscalls.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
 
@@ -93,6 +95,42 @@ long long tst_available_mem(void)
 	return mem_available;
 }
 
+static int has_caps(void)
+{
+	struct tst_cap_user_header hdr = {
+		.version = 0x20080522,
+		.pid = tst_syscall(__NR_gettid),
+	};
+
+	struct tst_cap_user_data caps[2];
+
+	if (tst_capget(&hdr, caps))
+		tst_brk(TBROK | TERRNO, "tst_capget()");
+
+	if ((caps[0].effective & (1U << CAP_SYS_ADMIN)) ||
+	    (caps[0].effective & (1U << CAP_SYS_RESOURCE)))
+		return 1;
+
+	return 0;
+}
+
+static int write_score(const char *path, int score)
+{
+	FILE *f;
+
+	f = fopen(path, "w");
+	if (!f)
+		return 1;
+
+	if (fprintf(f, "%d", score) <= 0)
+		return 1;
+
+	if (fclose(f))
+		return 1;
+
+	return 0;
+}
+
 static void set_oom_score_adj(pid_t pid, int value)
 {
 	int val;
@@ -111,17 +149,18 @@ static void set_oom_score_adj(pid_t pid, int value)
 			tst_brk(TBROK, "%s does not exist, please check if PID is valid", score_path);
 	}
 
-	FILE_PRINTF(score_path, "%d", value);
+	if (write_score(score_path, value)) {
+		if (!has_caps())
+			return;
+
+		tst_res(TWARN, "Can't adjust score, even with capabilities!?");
+		return;
+	}
+
 	FILE_SCANF(score_path, "%d", &val);
 
-	if (val != value) {
-		if (value < 0) {
-			tst_res(TWARN, "'%s' cannot be set to %i, are you root?",
-				score_path, value);
-			return;
-		}
+	if (val != value)
 		tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val, value);
-	}
 }
 
 void tst_enable_oom_protection(pid_t pid)
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
