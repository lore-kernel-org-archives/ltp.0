Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C29C7EE30
	for <ltp@archiver.kernel.org>; Sun, 29 Jun 2025 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751186392; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FCv+RgMfGlN5JE6bsBixmOVLSz6Vir0JBjDHJr4rU1E=;
 b=mheEYcWGRTdU8asXlLp6WeJ3q3LfjPfEQ8E8wXXm9ug9Rw1/o5ddyJ7rDDov1jhpns73m
 wXFhZeif4vRcIenMITn+NhIubhd243dqJPm6Y5TwlNyC55azyGaLfVdDlVQ4okr57pcfpI0
 3YVFoywn6A0/ZAGB/h0iiD+pdPBU5uI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553623C1008
	for <ltp@archiver.kernel.org>; Sun, 29 Jun 2025 10:39:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 037963C0565
 for <ltp@lists.linux.it>; Sun, 29 Jun 2025 10:39:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 373711A001A9
 for <ltp@lists.linux.it>; Sun, 29 Jun 2025 10:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751186365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfmRXQajCiDiF1N8slWFVCn251bBBr5p6D8ilrNvYTg=;
 b=Ls5dwqR1PStTge0mj23lPGsR48YzV0niyollcXLKg3PziXV5/ZzyYFCv+EzoWCobTLZ8fZ
 PAgzd5nGJrA/mfIukzmoiz7fGaZqli5sHfYqoltk6OtwvqJ7uQRQOHhVB1j2PuX/jqm/MY
 Ra+QayAacFDimZt7PggqP2u9my5old8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-gYAraZwYMmGbw_53xmCD7g-1; Sun,
 29 Jun 2025 04:39:21 -0400
X-MC-Unique: gYAraZwYMmGbw_53xmCD7g-1
X-Mimecast-MFC-AGG-ID: gYAraZwYMmGbw_53xmCD7g_1751186360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 572F0180029E
 for <ltp@lists.linux.it>; Sun, 29 Jun 2025 08:39:20 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.65])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 353C2180045B
 for <ltp@lists.linux.it>; Sun, 29 Jun 2025 08:39:18 +0000 (UTC)
To: ltp@lists.linux.it
Date: Sun, 29 Jun 2025 16:39:16 +0800
Message-ID: <20250629083916.227303-1-liwang@redhat.com>
In-Reply-To: <20250628031302.196715-1-liwang@redhat.com>
References: <20250628031302.196715-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qZvfAMEROEm3g0tj279Bao4te3mRLd8cYWeR7O_bjJ8_1751186360
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] checkpoint: add test for child reinitializing
 checkpoint region
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

This adds a pair of tests that verify checkpoint synchronization across
a parent and a re-exec'd child. The child process uses `tst_reinit()` to
reconnect to the shared checkpoint memory region established by the parent.

The parent waits on checkpoint 0, while the child wakes it after verifying
CLI arguments and reinitializing the IPC region.

Follow-up: https://lists.linux.it/pipermail/ltp/2025-June/044063.html
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/.gitignore              |  2 ++
 lib/newlib_tests/runtest.sh              |  4 +++
 lib/newlib_tests/tst_checkpoint_child.c  | 27 +++++++++++++++++
 lib/newlib_tests/tst_checkpoint_parent.c | 38 ++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 lib/newlib_tests/tst_checkpoint_child.c
 create mode 100644 lib/newlib_tests/tst_checkpoint_parent.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 3545f5ac5..a4984d2ec 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -16,6 +16,8 @@ tst_capability02
 tst_cgroup01
 tst_cgroup02
 tst_checkpoint
+tst_checkpoint_parent
+tst_checkpoint_child
 tst_checkpoint_wait_timeout
 tst_checkpoint_wake_timeout
 tst_device
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index f2133d365..d87751c2f 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -18,6 +18,10 @@ test1[59]
 test2[04]
 tst_bool_expr
 tst_capability02
+tst_checkpoint
+tst_checkpoint_parent
+tst_checkpoint_wait_timeout
+tst_checkpoint_wake_timeout
 tst_device
 tst_expiration_timer
 tst_fuzzy_sync0[1-3]
diff --git a/lib/newlib_tests/tst_checkpoint_child.c b/lib/newlib_tests/tst_checkpoint_child.c
new file mode 100644
index 000000000..c4eaccacc
--- /dev/null
+++ b/lib/newlib_tests/tst_checkpoint_child.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Child process: this binary is expected to be exec'd by the parent.
+ *
+ * It reinitializes the shared memory region using tst_reinit(),
+ * verifies the command-line argument, and signals checkpoint 0.
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_checkpoint.h"
+
+int main(int argc, char *argv[])
+{
+	tst_reinit();
+
+	if (argc != 2)
+		tst_brk(TFAIL, "argc is %d, expected 2", argc);
+
+	if (strcmp(argv[1], "canary"))
+		tst_brk(TFAIL, "argv[1] is %s, expected 'canary'", argv[1]);
+
+	tst_res(TINFO, "Child: signaling checkpoint");
+	TST_CHECKPOINT_WAKE(0);
+
+	return 0;
+}
diff --git a/lib/newlib_tests/tst_checkpoint_parent.c b/lib/newlib_tests/tst_checkpoint_parent.c
new file mode 100644
index 000000000..9d7f1783b
--- /dev/null
+++ b/lib/newlib_tests/tst_checkpoint_parent.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Parent process: spawns a child which reinitializes checkpoint region
+ * using tst_reinit(). Waits for a checkpoint signal from the child.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_checkpoint.h"
+
+static void run(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		TEST(execlp("tst_checkpoint_child", "tst_checkpoint_child", "canary", NULL));
+		tst_brk(TFAIL | TTERRNO, "Failed to execute tst_checkpoint_child");
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	tst_res(TPASS, "Parent: checkpoint reached");
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	return;
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.child_needs_reinit = 1,
+	.test_all = run,
+};
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
