Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0826C77B73
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 20:38:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82B873CD0AF
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 22:38:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBC03CB939
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9D26200BCD
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685479041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJFtseW1TKoHdAEDJ73boji0oZHmTNEr1dRP6ec14QQ=;
 b=g7fEAujBvlaz2zZLK5wGsV7JHiS7VyRmvflOpVKFgjqBmwncMWBdgHJ7EQHIzlT96Sz8Ev
 9dpAJsnKJOz5TyTQu01pwSe0MqD1uoLOKKk/z8H7Ck9x9McPDZIQx8Tkwm07W9uS7aVpFv
 euvLbZfm5DlJXJavzgEKdRz5B19a0dc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-M_4D8P5WNcuONl1DdMGRDQ-1; Tue, 30 May 2023 16:37:20 -0400
X-MC-Unique: M_4D8P5WNcuONl1DdMGRDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B97821C01505
 for <ltp@lists.linux.it>; Tue, 30 May 2023 20:37:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com
 (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1F3720296C6;
 Tue, 30 May 2023 20:37:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 30 May 2023 16:37:07 -0400
Message-Id: <20230530203707.2965684-6-aahringo@redhat.com>
In-Reply-To: <20230530203707.2965684-1-aahringo@redhat.com>
References: <20230530203707.2965684-1-aahringo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] fcntl44: test for kill child while others waiting
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

This patch adds fcntl44 to kill a forked child blocking for get a lock
granted and another child waiting for the same lock context. This test
checks on cleanup issues when the forked child gets killed.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 testcases/kernel/syscalls/fcntl/.gitignore |   2 +
 testcases/kernel/syscalls/fcntl/fcntl44.c  | 128 +++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl44.c

diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index 6622aedbc..0ee00ce1f 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -82,3 +82,5 @@
 /fcntl42_64
 /fcntl43
 /fcntl43_64
+/fcntl44_64
+/fcntl44
diff --git a/testcases/kernel/syscalls/fcntl/fcntl44.c b/testcases/kernel/syscalls/fcntl/fcntl44.c
new file mode 100644
index 000000000..364916634
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl44.c
@@ -0,0 +1,128 @@
+/*
+ * [Description]
+ * Tests killing a child while several other processes using different OFD
+ * lock contexts are blocking. When the child is killed there is a cleanup
+ * routine going on. The parent will check if there were any unexpected
+ * side-effects, e.g. unlock all previous acquired locks, happened.
+ *
+ * It is recommended to run watch -n 0.1 "dlm_tool plocks $LS"
+ * aside to monitor dlm plock handling.
+ *
+ * [How to use it]
+ * Call it with TMPDIR=/mnt ./fcntl44 where TMPDIR is a gfs2 mountpoint.
+ * Try it on other filesystems to compare results.
+ *
+ * [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/dlm/plock.c?h=v6.3#n432
+ */
+
+#include <sys/wait.h>
+
+#include "tst_test.h"
+
+static int fd, fd2;
+
+void do_child1(void)
+{
+	const struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+
+	SAFE_FCNTL(fd2, F_OFD_SETLKW, &fl);
+	tst_res(TINFO, "child1 lock region 0-0 acquired");
+
+	TST_CHECKPOINT_WAIT(1);
+
+	tst_res(TPASS, "Child1 passed!");
+}
+
+void do_child2(void)
+{
+	const struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+
+	SAFE_FCNTL(fd2, F_OFD_SETLKW, &fl);
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
+	pid_t pid, pid2;
+	int rv;
+
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+	tst_res(TINFO, "parent lock 0-1");
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_child1();
+		return;
+	}
+
+	pid2 = SAFE_FORK();
+	if (pid2 == 0) {
+		do_child2();
+		return;
+	}
+
+	/* wait until childs wait to acquire */
+	sleep(2);
+
+	kill(pid2, SIGKILL);
+	/* wait until linux killed the process */
+	sleep(3);
+	tst_res(TPASS, "Child2 killed!");
+
+	fl.l_type = F_UNLCK;
+	SAFE_FCNTL(fd, F_SETLK, &fl);
+
+	/* let child1 acquire 0-0 */
+	sleep(2);
+
+	fl.l_type = F_WRLCK;
+	fl.l_start = 0;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_OFD_SETLK, &fl);
+	if (rv == -1 && errno == EAGAIN)
+		tst_res(TPASS, "region 1-1 was locked");
+	else
+		tst_res(TFAIL, "region 1-1 was unlocked");
+
+	TST_CHECKPOINT_WAKE(1);
+
+	/* due bug child1 does not return because child2 killing removed waiters */
+	wait(NULL);
+
+	tst_res(TPASS, "Parent passed!");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("filename", O_RDWR | O_CREAT, 0700);
+	fd2 = SAFE_OPEN("filename", O_RDWR | O_CREAT, 0700);
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
