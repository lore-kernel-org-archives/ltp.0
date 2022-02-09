Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469BFC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:18:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21A903C9B5B
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:18:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA37C3C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:18:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0AE251A00706
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:17:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C58321119;
 Wed,  9 Feb 2022 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644398279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HlBBG4j/h10r2jwLTaqHVVhqcAlZIAwUjLYvifvBmQA=;
 b=HMI/tw/7msfnWyv4g7reEi0sFLpfHxKE53ZxcqWNYnkZ8kqIS8lI6u5OayLLwgMag6L6sw
 zkl3IDQRjBWtDWs5Y1vqpf0D8jmln/64LbF+xYSBytx3LJttQgMPXU9VQRgac/NF5sxPPO
 i5SmE0F7n3LiJMAjQEtwIYOofCcq11s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644398279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HlBBG4j/h10r2jwLTaqHVVhqcAlZIAwUjLYvifvBmQA=;
 b=Gbb1MFzo2dYVhGGh+ChmQl5y5Q8O9qfxuOEN9ciUga9V5ZqYrPe91UQdeBRTNX5H6BOB8k
 VB1jKFPkJknNCkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 067AB13D1E;
 Wed,  9 Feb 2022 09:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AuFDO8aGA2J+PQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Feb 2022 09:17:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 10:17:55 +0100
Message-Id: <20220209091756.17245-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] Add TST_THREAD_STATE_WAIT macro
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

The TST_THREAD_STATE_WAIT macro can be used to wait and check for
pthread state changes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
In v5 TST_THREAD_STATE_WAIT has been added in the tst_process_state.h header.

 include/tst_process_state.h | 19 +++++++++++++++++++
 lib/tst_thread_state.c      | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 lib/tst_thread_state.c

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index 81532524a..b1d83e109 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -36,6 +36,25 @@
 #define TST_PROCESS_EXIT_WAIT(pid, msec_timeout) \
 	tst_process_exit_wait((pid), (msec_timeout))
 
+/*
+ * Waits for thread state change.
+ *
+ * The state is one of the following:
+ *
+ * R - running
+ * S - sleeping
+ * D - disk sleep
+ * T - stopped
+ * t - tracing stopped
+ * Z - zombie
+ * X - dead
+ */
+#define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
+	tst_thread_state_wait((tid), (state), (msec_timeout))
+
+int tst_thread_state_wait(pid_t tid, const char state,
+				unsigned int msec_timeout);
+
 #else
 /*
  * The same as above but does not use tst_brkm() interface.
diff --git a/lib/tst_thread_state.c b/lib/tst_thread_state.c
new file mode 100644
index 000000000..6562dfaf0
--- /dev/null
+++ b/lib/tst_thread_state.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "tst_safe_file_ops.h"
+#include "tst_process_state.h"
+
+int tst_thread_state_wait(pid_t tid, const char state,
+			  unsigned int msec_timeout)
+{
+	char proc_path[128], cur_state;
+	unsigned int msecs = 0;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/self/task/%i/stat", tid);
+
+	for (;;) {
+		SAFE_FILE_SCANF(proc_path, "%*i %*s %c", &cur_state);
+
+		if (state == cur_state)
+			break;
+
+		usleep(1000);
+		msecs += 1;
+
+		if (msec_timeout && msecs >= msec_timeout) {
+			errno = ETIMEDOUT;
+			return -1;
+		}
+	}
+
+	return 0;
+}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
