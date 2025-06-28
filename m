Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04CAC77B7C
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751080413; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=v5APw6yYkjVIsLz7V4WcU/GvKsqLHV6HumHm+BLTGMM=;
 b=LBGrJ4Ja2m7sxK4k15kNE/XVuka2zJRlr/jzRAtvoe4eG/mXGi5hPuAJh9WS2U9m7mM2Q
 hqYzQagR48nkCo6+NAf42JFD6s0ExrEk0c0iffCJq6OlUpr42Z+glg220Czf7xDOYeXFMfr
 CVkvnHsb3qrzzTRt7+bsoVnvnA3IT4o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ACAF3C9AA8
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 05:13:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2365F3C07C1
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 05:13:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 064391000BFD
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 05:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751080389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SpURymXmvCIRRbV66DjMDcwwsw2ZuCL2APGYJJbic4A=;
 b=Y82QeYAGMSruE9D3g/y1cYgD/MX1aWdcaoko1Vg0GZeUywTAWWRQvADtryMklN52YMrI98
 l2cIzcDS7D++l9J25yhlmdmwTo+1hHsm4UfbcUeLSUOHUyNuUH45ZFprdxoDx48Sp3r27M
 n/Sl5XMjxkaKMLv1ZWKUjy+cm+YHezU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-6KJ39RSKOa2cFDvAhfht1A-1; Fri,
 27 Jun 2025 23:13:07 -0400
X-MC-Unique: 6KJ39RSKOa2cFDvAhfht1A-1
X-Mimecast-MFC-AGG-ID: 6KJ39RSKOa2cFDvAhfht1A_1751080386
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E63B18002EC
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 03:13:06 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.20])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0BAB1944CE7
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 03:13:04 +0000 (UTC)
To: ltp@lists.linux.it
Date: Sat, 28 Jun 2025 11:13:02 +0800
Message-ID: <20250628031302.196715-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sysf2X4sZIapIZim_JTHbCqHUAL9rlxdAt_oPuuU8R4_1751080386
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/checkpoint: remove deprecated
 tst_checkpoint_init() and legacy macro
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

The function tst_checkpoint_init() and macro TST_CHECKPOINT_INIT were
used by old library tests for setting up checkpoint futex memory.

These APIs have been fully replaced by tst_reinit() and in the new
checkpoint infrastructure.

So let's get rid of them and rewrite the checkpoint tests in newlib_tests/.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/old/old_checkpoint.h                  |   8 --
 include/tst_checkpoint_fn.h                   |   8 --
 lib/newlib_tests/.gitignore                   |   3 +
 lib/newlib_tests/tst_checkpoint.c             | 114 ++++++++++++++++++
 .../tst_checkpoint_wait_timeout.c             |  42 +++++++
 .../tst_checkpoint_wake_timeout.c             |  29 +++++
 lib/tests/.gitignore                          |   3 -
 lib/tests/tst_checkpoint.c                    |  59 ---------
 lib/tests/tst_checkpoint_wait_timeout.c       |  58 ---------
 lib/tests/tst_checkpoint_wake_timeout.c       |  41 -------
 lib/tst_checkpoint.c                          |  51 +-------
 11 files changed, 194 insertions(+), 222 deletions(-)
 create mode 100644 lib/newlib_tests/tst_checkpoint.c
 create mode 100644 lib/newlib_tests/tst_checkpoint_wait_timeout.c
 create mode 100644 lib/newlib_tests/tst_checkpoint_wake_timeout.c
 delete mode 100644 lib/tests/tst_checkpoint.c
 delete mode 100644 lib/tests/tst_checkpoint_wait_timeout.c
 delete mode 100644 lib/tests/tst_checkpoint_wake_timeout.c

diff --git a/include/old/old_checkpoint.h b/include/old/old_checkpoint.h
index c8ffc92da..f91fef9f6 100644
--- a/include/old/old_checkpoint.h
+++ b/include/old/old_checkpoint.h
@@ -32,14 +32,6 @@
 #include "test.h"
 #include "tst_checkpoint_fn.h"
 
-/*
- * Checkpoint initializaton, must be done first.
- *
- * NOTE: tst_tmpdir() must be called beforehand.
- */
-#define TST_CHECKPOINT_INIT(cleanup_fn) \
-	tst_checkpoint_init(__FILE__, __LINE__, cleanup_fn)
-
 #define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
 
diff --git a/include/tst_checkpoint_fn.h b/include/tst_checkpoint_fn.h
index 3a010d616..7d40c0849 100644
--- a/include/tst_checkpoint_fn.h
+++ b/include/tst_checkpoint_fn.h
@@ -5,14 +5,6 @@
 #ifndef TST_CHECKPOINT_FN__
 #define TST_CHECKPOINT_FN__
 
-/*
- * Checkpoint initializaton, must be done first.
- *
- * NOTE: tst_tmpdir() must be called beforehand.
- */
-void tst_checkpoint_init(const char *file, const int lineno,
-			 void (*cleanup_fn)(void));
-
 /*
  * Waits for wakeup.
  *
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 8acaec0b6..3545f5ac5 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -15,6 +15,9 @@ tst_capability01
 tst_capability02
 tst_cgroup01
 tst_cgroup02
+tst_checkpoint
+tst_checkpoint_wait_timeout
+tst_checkpoint_wake_timeout
 tst_device
 tst_safe_fileops
 tst_res_hexd
diff --git a/lib/newlib_tests/tst_checkpoint.c b/lib/newlib_tests/tst_checkpoint.c
new file mode 100644
index 000000000..a283f03ef
--- /dev/null
+++ b/lib/newlib_tests/tst_checkpoint.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Modernized checkpoint usage.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_checkpoint.h"
+
+/* Test 1: Basic checkpoint signal from child to parent */
+static void checkpoint_test1(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		tst_res(TINFO, "Child: signaling checkpoint");
+		TST_CHECKPOINT_WAKE(0);
+		_exit(0);
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
+/* Test 2: Checkpoint wait with timeout, wake from child */
+static void checkpoint_test2(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		tst_res(TINFO, "Child: signaling checkpoint");
+		TST_CHECKPOINT_WAKE2(0, 1);
+		_exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT2(0, 1000);
+	tst_res(TPASS, "Parent: checkpoint reached");
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	return;
+}
+
+/* Test 3: Wake two child waiters on the same checkpoint */
+static void checkpoint_test3(void)
+{
+	pid_t pid1, pid2;
+
+	pid1 = SAFE_FORK();
+	if (pid1 == 0) {
+		tst_res(TINFO, "Child 1: waiting on checkpoint 0 (no timeout)");
+		TST_CHECKPOINT_WAIT(0);
+		_exit(0);
+	}
+
+	pid2 = SAFE_FORK();
+	if (pid2 == 0) {
+		tst_res(TINFO, "Child 2: waiting on checkpoint 0 (1000ms timeout)");
+		TST_CHECKPOINT_WAIT2(0, 1000);
+		_exit(0);
+	}
+
+	TST_CHECKPOINT_WAKE2(0, 2);
+	tst_res(TPASS, "Parent: checkpoint wake issued");
+
+	tst_reap_children();
+
+	return;
+}
+
+/* Test 4: Two-way checkpoint handshake (child->parent->child) */
+static void checkpoint_test4(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		tst_res(TINFO, "Child: waking and then waiting on checkpoint 0");
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		_exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_res(TPASS, "Parent: checkpoint handshake completed");
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	return;
+}
+
+static void run(void)
+{
+	checkpoint_test1();
+	checkpoint_test2();
+	checkpoint_test3();
+	checkpoint_test4();
+
+	return;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/lib/newlib_tests/tst_checkpoint_wait_timeout.c b/lib/newlib_tests/tst_checkpoint_wait_timeout.c
new file mode 100644
index 000000000..2fa6f8cf9
--- /dev/null
+++ b/lib/newlib_tests/tst_checkpoint_wait_timeout.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test: checkpoint wait with timeout.
+ * Expected: child blocks on checkpoint wait, parent exits without signaling.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_checkpoint.h"
+
+static void run(void)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		int ret = tst_checkpoint_wait(0, 1000);
+
+		if (ret == -1 && errno == ETIMEDOUT)
+			tst_res(TPASS, "Child: checkpoint wait timed out as expected");
+		else
+			tst_brk(TBROK | TERRNO, "checkpoint wait failed");
+
+		_exit(0);
+	}
+
+	tst_res(TINFO, "Parent: exiting without signaling checkpoint");
+	SAFE_WAITPID(pid, NULL, 0);
+
+	return;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/lib/newlib_tests/tst_checkpoint_wake_timeout.c b/lib/newlib_tests/tst_checkpoint_wake_timeout.c
new file mode 100644
index 000000000..c37fd6945
--- /dev/null
+++ b/lib/newlib_tests/tst_checkpoint_wake_timeout.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test: checkpoint wake without matching wait.
+ * Expected: wake completes with ETIMEDOUT errno as expected.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_checkpoint.h"
+
+static void run(void)
+{
+	int ret = tst_checkpoint_wake(0, 1, 1000);
+
+	if (ret == -1 && errno == ETIMEDOUT)
+		tst_res(TPASS, "checkpoint wake timed out as expected");
+	else
+		tst_brk(TBROK | TERRNO, "checkpoint wake failed");
+
+	return;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_checkpoints = 1,
+};
diff --git a/lib/tests/.gitignore b/lib/tests/.gitignore
index 1d880c1b7..00237f532 100644
--- a/lib/tests/.gitignore
+++ b/lib/tests/.gitignore
@@ -1,7 +1,4 @@
 /tst_tmpdir_test
-/tst_checkpoint
-/tst_checkpoint_wait_timeout
-/tst_checkpoint_wake_timeout
 /tst_process_state
 /tst_cleanup_once
 /tst_safe_macros
diff --git a/lib/tests/tst_checkpoint.c b/lib/tests/tst_checkpoint.c
deleted file mode 100644
index 2cb17a5f7..000000000
--- a/lib/tests/tst_checkpoint.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 2012-2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <sys/wait.h>
-
-#include "test.h"
-
-char *TCID = "tst_checkpoint";
-int TST_TOTAL = 1;
-
-int main(void)
-{
-	int pid;
-
-	tst_tmpdir();
-
-	TST_CHECKPOINT_INIT(tst_rmdir);
-
-	pid = fork();
-
-	switch (pid) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "Fork failed");
-	break;
-	case 0:
-		fprintf(stderr, "Child: checkpoint signaling\n");
-		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-		exit(0);
-	break;
-	default:
-		TST_SAFE_CHECKPOINT_WAIT(tst_rmdir, 0);
-		fprintf(stderr, "Parent: checkpoint reached\n");
-	break;
-	}
-
-	wait(NULL);
-	tst_rmdir();
-	return 0;
-}
diff --git a/lib/tests/tst_checkpoint_wait_timeout.c b/lib/tests/tst_checkpoint_wait_timeout.c
deleted file mode 100644
index c5fae670e..000000000
--- a/lib/tests/tst_checkpoint_wait_timeout.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * Copyright (C) 2012-2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <sys/wait.h>
-
-#include "test.h"
-
-char *TCID = "tst_checkpoint_wait_timeout";
-int TST_TOTAL = 1;
-
-int main(void)
-{
-	int pid;
-
-	tst_tmpdir();
-
-	TST_CHECKPOINT_INIT(tst_rmdir);
-
-	pid = fork();
-
-	switch (pid) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "Fork failed");
-	break;
-	case 0:
-		TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
-		fprintf(stderr, "Child: checkpoint reached\n");
-		exit(0);
-	break;
-	default:
-		fprintf(stderr, "Parent: exiting without signaling\n");
-		tst_rmdir();
-		exit(0);
-	break;
-	}
-
-	return 0;
-}
diff --git a/lib/tests/tst_checkpoint_wake_timeout.c b/lib/tests/tst_checkpoint_wake_timeout.c
deleted file mode 100644
index 8af1feb18..000000000
--- a/lib/tests/tst_checkpoint_wake_timeout.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright (C) 2013 Linux Test Project
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <sys/wait.h>
-
-#include "test.h"
-
-char *TCID = "tst_checkpoint_wake_timeout";
-int TST_TOTAL = 1;
-
-int main(void)
-{
-	tst_tmpdir();
-
-	TST_CHECKPOINT_INIT(tst_rmdir);
-	TST_SAFE_CHECKPOINT_WAKE(tst_rmdir, 0);
-	fprintf(stderr, "Parent: checkpoint reached\n");
-
-	return 0;
-}
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 6a294b28b..d36103fbb 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -32,54 +32,15 @@
 
 #define DEFAULT_MSEC_TIMEOUT 10000
 
+/*
+ * Global futex array and size for checkpoint synchronization.
+ *
+ * NOTE: These are initialized by setup_ipc()/tst_reinit() in tst_test.c
+ * when .needs_checkpoints is set in the tst_test struct.
+ */
 futex_t *tst_futexes;
 unsigned int tst_max_futexes;
 
-void tst_checkpoint_init(const char *file, const int lineno,
-                         void (*cleanup_fn)(void))
-{
-	int fd;
-	unsigned int page_size;
-
-	if (tst_futexes) {
-		tst_brkm_(file, lineno, TBROK, cleanup_fn,
-			"checkpoints already initialized");
-		return;
-	}
-
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
-	}
-
-	page_size = getpagesize();
-
-	fd = SAFE_OPEN(cleanup_fn, "checkpoint_futex_base_file",
-	               O_RDWR | O_CREAT, 0666);
-
-	SAFE_FTRUNCATE(cleanup_fn, fd, page_size);
-
-	tst_futexes = SAFE_MMAP(cleanup_fn, NULL, page_size,
-	                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-
-	tst_max_futexes = page_size / sizeof(uint32_t);
-
-	SAFE_CLOSE(cleanup_fn, fd);
-}
-
 int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 {
 	struct timespec timeout;
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
