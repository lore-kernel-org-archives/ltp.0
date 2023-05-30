Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34F2C7EE2F
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 20:37:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7AEE3CE70F
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 22:37:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FC173CCFAA
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B64D600878
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685479041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foAiNe7XydzU2kWqvjALQh0K4VYmVs3JeIGk4008Mls=;
 b=ZRVmz/ChzsLSOlaQlPez6UREiFQXuEBuviQ1L6SBMGS+wBKyzmnrvnRLcgdI8eLtuQISrA
 /rmiJAbE0U2u/ajcNyuPLRfquVM4gDA7wgfVGGbdYkq2oU5hjPYzBEq+JWGiESAuohySe4
 PXrejusilcpTgsc4NXOzre3LClRO/2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427--akcnarkP_yhAL0l7kdpMQ-1; Tue, 30 May 2023 16:37:19 -0400
X-MC-Unique: -akcnarkP_yhAL0l7kdpMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7984C811E7C
 for <ltp@lists.linux.it>; Tue, 30 May 2023 20:37:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com
 (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62634202696C;
 Tue, 30 May 2023 20:37:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 30 May 2023 16:37:05 -0400
Message-Id: <20230530203707.2965684-4-aahringo@redhat.com>
In-Reply-To: <20230530203707.2965684-1-aahringo@redhat.com>
References: <20230530203707.2965684-1-aahringo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] fcntl42: test for F_SETLKW interruption case
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

This patch adds fcntl42 testcase to test on side effects, e.g. unlock
all acquired locks, when a lock request was interrupted by a signal.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 testcases/kernel/syscalls/fcntl/.gitignore |   2 +
 testcases/kernel/syscalls/fcntl/fcntl42.c  | 153 +++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl42.c

diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index 4bdae1a22..abffa2967 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -78,3 +78,5 @@
 /fcntl40_64
 /fcntl41
 /fcntl41_64
+/fcntl42
+/fcntl42_64
diff --git a/testcases/kernel/syscalls/fcntl/fcntl42.c b/testcases/kernel/syscalls/fcntl/fcntl42.c
new file mode 100644
index 000000000..4d66568fd
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl42.c
@@ -0,0 +1,153 @@
+/*
+ * [Description]
+ * This test confirms that DLM posix locking has problems when a posix lock
+ * got interrupted every lock gets unlocked.
+ *
+ * man fcntl:
+ *
+ * F_SETLKW (struct flock *)
+ *  As for F_SETLK, but if a conflicting lock is held on  the  file,
+ *  then  wait  for that lock to be released.  If a signal is caught
+ *  while waiting, then the call is interrupted and (after the  signal
+ *  handler has returned) returns immediately (with return value -1 and
+ *  errno set to EINTR; see signal(7)).
+ *
+ * The above quote of the man page of fcntl() is what this testcase tests.
+ * particulary if it has side-effects of previously acquired locks.
+ *
+ * [How to use it]
+ * Call it with TMPDIR=/mnt ./fcntl42 where TMPDIR is a gfs2 mountpoint.
+ * Try it on other filesystems to compare results.
+ *
+ * [What's it doing]
+ *
+ * What this test does is (using dlm_controld interval range interpretation):
+ *
+ * parent:
+ *
+ * 1. lock[0-0]
+ *
+ * child:
+ *
+ * 2. lock[1-1]
+ * 3. lockw[0-0] - should block (see 1. parent), but we get interrupted by SIGALRM
+ *
+ * parent:
+ *
+ * 4. trylock[1-1] - should return -1 and errno -EAGAIN because the child
+ *                   should still have lock[1-1] acuired and this is what
+ *                   the child thinks to have. If it's successful the child
+ *                   wrongly assumes it has the lock[1-1] still acquired and
+ *                   the child process is still alive.
+ *
+ */
+
+#include <sys/wait.h>
+
+#include "tst_test.h"
+
+static int fd;
+
+static void catch_alarm(int num)
+{
+	(void)num;
+
+	tst_res(TINFO, "catch alarm");
+}
+
+void do_child1(void)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	struct sigaction act;
+	int rv;
+
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+	tst_res(TINFO, "child locked lock 1-1");
+
+	fl.l_type = F_WRLCK;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	memset(&act, 0, sizeof(act));
+	act.sa_handler = catch_alarm;
+	sigemptyset(&act.sa_mask);
+	sigaddset(&act.sa_mask, SIGALRM);
+	sigaction(SIGALRM, &act, NULL);
+
+	/* interrupt SETLKW by signal in 3 secs */
+	alarm(3);
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1 && errno == EINTR)
+		tst_res(TPASS, "Child1 interrupted 0-0");
+
+	TST_CHECKPOINT_WAKE(1);
+	/* keep child alive until parent check region */
+	TST_CHECKPOINT_WAIT(2);
+}
+
+static void fcntl40_test(void)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	pid_t pid;
+	int rv;
+
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+	tst_res(TINFO, "parent lock 0-0");
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_child1();
+		tst_res(TINFO, "childs exits");
+		return;
+	}
+
+	TST_CHECKPOINT_WAIT(1);
+
+	fl.l_type = F_WRLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	/* parent testing childs region, the child will think
+	 * it has region 1-1 locked because it was interrupted
+	 * by region 0-0. Due bugs the interruption also unlocked
+	 * region 1-1.
+	 */
+	if (rv == -1 && errno == EAGAIN)
+		tst_res(TPASS, "region 1-1 locked");
+	else
+		tst_res(TFAIL, "region 1-1 unlocked");
+
+	TST_CHECKPOINT_WAKE(2);
+
+	wait(NULL);
+	tst_res(TINFO, "parent exits");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("filename", O_RDWR | O_CREAT, 0700);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.test_all = fcntl40_test,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
