Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F20C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDC23C9268
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 11:20:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629ED3C620F
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 11:20:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8836600693
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 11:20:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD0721F384;
 Wed, 22 Dec 2021 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640168426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/krb+nH1xGK8K+nTS48eyN/srw3VLbBkJQ3QVL7bJt8=;
 b=F/pa9hQuQsZQvVgCjpaz8+R/3KcoJjCG4cihxli4MvIqKvgScoewAbasyMyIfA8hYuNSUh
 eiFuGgPudSk79lQW9EgiyYdwGVYZmXYqTxojmSiwU7IdjLka0RUGfcL8u8qdXqp3G1HLPk
 jxx25beitkN6OM5gjEdP8mP5GL8tsc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640168426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/krb+nH1xGK8K+nTS48eyN/srw3VLbBkJQ3QVL7bJt8=;
 b=l/Uf5Dy8u9PSKNLdFfl5hTUA3NE1OlMmiApP2Z3P2h31KHQ6cYcmmLPw6VBll/YQwN/JNT
 EPIA1Af4KBpN/eAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E27013CDA;
 Wed, 22 Dec 2021 10:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RE2TFOr7wmGpdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 10:20:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Dec 2021 11:20:22 +0100
Message-Id: <20211222102022.3141-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lib: Check permission for OOM protection
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

setting value < 0 in /proc/*/oom_score_adj requires CAP_SYS_RESOURCE or
CAP_SYS_ADMIN therefore check it in tst_{disable,enable}_oom_protection().

Use set_oom_score_adj() to run without this check.

Fixes: 8a0827766d ("lib: add functions to adjust oom score")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* changes v1->v2:
check CAP_SYS_RESOURCE and CAP_SYS_ADMIN instead of UID 0.

 include/tst_memutils.h | 11 ++++++++++-
 lib/tst_memutils.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 68a6e37714..f2a41ed8ce 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -30,11 +30,15 @@ long long tst_available_mem(void);
  *   echo -1000 >/proc/$PID/oom_score_adj
  * If the pid is 0 which means it will set on current(self) process.
  *
+ * WARNING:
+ *  Do nothing unless CAP_SYS_RESOURCE or CAP_SYS_ADMIN, because setting value <
+ *  0 requires it. Use set_oom_score_adj() to run without this check.
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
@@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);
 /*
  * Disable the OOM protection for the process($PID).
  *   echo 0 >/proc/$PID/oom_score_adj
+ *
+ * WARNING:
+ *  Do nothing unless CAP_SYS_RESOURCE or CAP_SYS_ADMIN, because it's expected
+ *  to be cleanup after tst_enable_oom_protection(). Use set_oom_score_adj() to
+ *  run without this check.
  */
 void tst_disable_oom_protection(pid_t pid);
 
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 4dea303307..e67f810116 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -8,9 +8,12 @@
 #include <limits.h>
 #include <sys/sysinfo.h>
 #include <stdlib.h>
+#include <stdbool.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_capability.h"
+#include "lapi/syscalls.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
 
@@ -124,12 +127,37 @@ static void set_oom_score_adj(pid_t pid, int value)
 	}
 }
 
+static bool check_caps(void)
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
+	if (!(caps[0].effective & (1U << CAP_SYS_ADMIN)) ||
+	    !(caps[0].effective & (1U << CAP_SYS_RESOURCE)))
+		return false;
+
+	return true;
+}
+
 void tst_enable_oom_protection(pid_t pid)
 {
+	if (!check_caps())
+		return;
+
 	set_oom_score_adj(pid, -1000);
 }
 
 void tst_disable_oom_protection(pid_t pid)
 {
+	if (!check_caps())
+		return;
+
 	set_oom_score_adj(pid, 0);
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
