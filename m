Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64130C7EE23
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 20:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D1953CE71D
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 22:38:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92F53CCFA1
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A3A11000BD9
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685479040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjN6dg59V0TBoYTUAid/o9q8l4IMeFbDiTYtOBeabOM=;
 b=CYt6SbEo7n0yQcY6Ruj+bNZiiqQYlc61TfJwk42YfXAIDfgnqfvmFKYiVFk5DLRJtDuxnQ
 zQ0Mmvvy/xT0LX3BRm65lsjP8ohrCAmMo13mLyVQlG3IjMklLyc2UaGSLGtD5Z7VpXmSF4
 NDid5y5DYgDjMGIRK2TwfETrL9H9n2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-S2jGaPTTNbC4ekTG1wJi8g-1; Tue, 30 May 2023 16:37:19 -0400
X-MC-Unique: S2jGaPTTNbC4ekTG1wJi8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B95A8007D9
 for <ltp@lists.linux.it>; Tue, 30 May 2023 20:37:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com
 (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22A8020296C6;
 Tue, 30 May 2023 20:37:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 30 May 2023 16:37:03 -0400
Message-Id: <20230530203707.2965684-2-aahringo@redhat.com>
In-Reply-To: <20230530203707.2965684-1-aahringo@redhat.com>
References: <20230530203707.2965684-1-aahringo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic posix
 lock
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

This patch adds fcntl40 to test similar owner values for classical owner
locks. There was an issue been found in the gfs2 filesystem because
there can be collisions with identical owner values.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 testcases/kernel/syscalls/fcntl/.gitignore |   2 +
 testcases/kernel/syscalls/fcntl/Makefile   |   3 +
 testcases/kernel/syscalls/fcntl/fcntl40.c  | 188 +++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl40.c

diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index 10cb0995f..e558cfe83 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -74,3 +74,5 @@
 /fcntl38_64
 /fcntl39
 /fcntl39_64
+/fcntl40
+/fcntl40_64
diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index df663a50a..c3196a527 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -12,6 +12,9 @@ fcntl34_64: LDLIBS += -lpthread
 fcntl36: LDLIBS += -lpthread
 fcntl36_64: LDLIBS += -lpthread
 
+fcntl40: LDLIBS += -lpthread
+fcntl40_64: LDLIBS += -lpthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl40.c b/testcases/kernel/syscalls/fcntl/fcntl40.c
new file mode 100644
index 000000000..829685436
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
@@ -0,0 +1,188 @@
+/*
+ * [Description]
+ * Tests gfs2 dlm posix op queue handling in the kernel.
+ * It is recommended to run watch -n 0.1 "dlm_tool plocks $LS"
+ * aside to monitor dlm plock handling.
+ *
+ * [How to use it]
+ * Call it with TMPDIR=/mnt ./fcntl40 where TMPDIR is a gfs2 mountpoint.
+ * Try it on other filesystems to compare results.
+ *
+ * [What's it doing]
+ *
+ * The test shows that we currently have problems with the operation lookup
+ * functionality [0] when we using threads. The owner value is the same for two
+ * locks being in WAITING state. dlm_controld "dlm_tool plocks $LS" will show
+ * it correctly that the specific lock is not in waiting anymore. The issue
+ * begins matching the right iter->done in the kernel at dev_write() see [0].
+ *
+ * What this test does is (using dlm_controld interval range interpretation):
+ *
+ * parent:
+ *
+ * 1. lock[0-1]
+ *
+ * child:
+ *
+ * thread1:
+ *
+ * 2. lockw[1-1] - important 1-1 at first because the order of WAITING state
+ *                 locks matters
+ *
+ * thread2:
+ *
+ * 3. lockw[0-0]
+ *
+ * parent:
+ *
+ * 4. unlock[1-1] - will give a iter->done = 1 in [0] for lock at 3. and the
+ *                  application results in a deadlock
+ * 5. unlock[0-0]
+ *
+ * We have this issue also with SETLK, GETLK - it's easier to reproduce
+ * with SETLKW because dev_write() is more controlable by doing unlocks.
+ *
+ * OFD (open filedescriptor locks) are also affected and should be able
+ * to reproduce with fork() only and not threads. The owner value of [0]
+ * depends on "struct file *" pointer in this case.
+ *
+ * [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/dlm/plock.c?h=v6.3#n432
+ */
+
+#include <sys/wait.h>
+#include <pthread.h>
+
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+static int fd;
+
+static void *do_thread1(void *arg)
+{
+	const struct flock fl_0_0 = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	(void)arg;
+
+	tst_res(TINFO, "thread1 waits for thread2 to lock 1-1");
+	TST_CHECKPOINT_WAIT(1);
+
+	tst_res(TINFO, "thread1 lock region 0-0 - It should block");
+	SAFE_FCNTL(fd, F_SETLKW, &fl_0_0);
+	tst_res(TINFO, "lock region 0-0 acquired");
+
+	return NULL;
+}
+
+static void *do_thread2(void *arg)
+{
+	const struct flock fl_1_1 = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	(void)arg;
+
+	tst_res(TINFO, "thread1 lock region 1-1 - It should block");
+	SAFE_FCNTL(fd, F_SETLKW, &fl_1_1);
+	tst_res(TINFO, "lock region 1-1 acquired");
+
+	TST_CHECKPOINT_WAKE(2);
+
+	return NULL;
+}
+
+void do_child(void)
+{
+	pthread_t t1, t2;
+
+	SAFE_PTHREAD_CREATE(&t1, NULL, do_thread1, NULL);
+	SAFE_PTHREAD_CREATE(&t2, NULL, do_thread2, NULL);
+
+	SAFE_PTHREAD_JOIN(t1, NULL);
+	SAFE_PTHREAD_JOIN(t2, NULL);
+
+	tst_res(TPASS, "Child passed!");
+}
+
+void do_parent(void)
+{
+	struct flock fl = {
+		.l_whence = SEEK_SET,
+	};
+
+	/* wait for 1 seconds so thread2 lock 1-1 tries to acquires at first
+	 * than thread1 lock 0-0 tries to acquired to have a specific waiting
+	 * order in dlm posix handling.
+	 */
+	sleep(1);
+	/* tell thread2 to call SETLKW for lock 0-0 */
+	TST_CHECKPOINT_WAKE(1);
+	/* wait 3 seconds for thread 1 and 2 being in waiting state */
+	sleep(3);
+
+	/* unlock 0-1, should be successful */
+	fl.l_type = F_UNLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	tst_res(TINFO, "unlock region 1-1 thread2");
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+
+	/* wait until thread 2 got acquired and leave waiting */
+	TST_CHECKPOINT_WAIT(2);
+
+	fl.l_start = 0;
+	fl.l_len = 1;
+	fl.l_type = F_UNLCK;
+	tst_res(TINFO, "unlock region 0-0 thread2");
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+}
+
+static void fcntl40_test(void)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 2L,
+	};
+	pid_t pid;
+
+	tst_res(TINFO, "parent lock region 0-1 - should be successful");
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+	tst_res(TINFO, "parent region 0-1 locked");
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_child();
+		return;
+	}
+
+	do_parent();
+	wait(NULL);
+
+	tst_res(TPASS, "Parent passed!");
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
