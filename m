Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA159C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:17:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474B83CCDAD
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:17:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 489B03CCCCC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDE771A0034D
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E57621859;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE5TtQrmubpyjkNxHbe4+xKr3avnmscqQegbKSk1WSk=;
 b=AQubUXfpnWjeDDSpLFBPntzNZxdLL5dylCjOFfL3NJ7lwup/QP7ddwpcY3CiwhJHI3HYDl
 IoSL6JYrT8hiT9pWWL7Wbl9wWiLGCuKVI1V85+COPBx83pmk8N6AYeY3hfWk8QxkIoD+Lg
 l8zzjBL1NDoBXDUJifgkZ9IN8d3Anjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE5TtQrmubpyjkNxHbe4+xKr3avnmscqQegbKSk1WSk=;
 b=MHRymgTzHXb85rbR1ZzQO+4WRmcu9VGIa81unucDlbss3d22qER0QK7/fgriQz6abS/Jg3
 mqEMLXdO2GHNL8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE5TtQrmubpyjkNxHbe4+xKr3avnmscqQegbKSk1WSk=;
 b=AQubUXfpnWjeDDSpLFBPntzNZxdLL5dylCjOFfL3NJ7lwup/QP7ddwpcY3CiwhJHI3HYDl
 IoSL6JYrT8hiT9pWWL7Wbl9wWiLGCuKVI1V85+COPBx83pmk8N6AYeY3hfWk8QxkIoD+Lg
 l8zzjBL1NDoBXDUJifgkZ9IN8d3Anjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE5TtQrmubpyjkNxHbe4+xKr3avnmscqQegbKSk1WSk=;
 b=MHRymgTzHXb85rbR1ZzQO+4WRmcu9VGIa81unucDlbss3d22qER0QK7/fgriQz6abS/Jg3
 mqEMLXdO2GHNL8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A5B13ADD;
 Wed, 23 Jul 2025 14:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMVJBqXugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:19 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-5-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=3255;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2O+3eGthHllsfx7fpmYKRHuJAhX/T98cTYA7G3P2JNI=;
 b=/auqiYP3+IcAvngdE7Bo53UtpZX3TPiHI+crawUrzpJ+a7CKdF8qv5vPzJGQFfdFnPlca+Wgq
 oyCJF0zU4cWDMKfNx8AxNYUy/Trpk0JIzS++06gF0J7o5bLp//JzkfT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/8] Add ioctl_pidfd03 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that ioctl() returns ESRCH when a process attempts to access
the exit status of an isolated child using `PIDFD_GET_INFO` and
`PIDFD_INFO_EXIT` is not defined in `struct pidfd_info`.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 64 +++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fbb38b1a52ed9d7f6634336d83c226b5cce522e8..7e019675216a59919b137b84b023ebb2969efcdb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -615,6 +615,7 @@ ioctl_fiemap01 ioctl_fiemap01
 
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
+ioctl_pidfd03 ioctl_pidfd03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index a984744a67173b70872446823a6fdeb6a44fe2c8..393ec47fecaed101f413284f28646aeff76cc30b 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -32,3 +32,4 @@
 /ioctl_fiemap01
 /ioctl_pidfd01
 /ioctl_pidfd02
+/ioctl_pidfd03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
new file mode 100644
index 0000000000000000000000000000000000000000..eca4b90f4b5fb9f209c30752ab583a20a31518bc
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() returns ESRCH when a process attempts to access the
+ * exit status of an isolated child using `PIDFD_GET_INFO` and
+ * `PIDFD_INFO_EXIT` is not defined in `struct pidfd_info`.
+ */
+
+#include "ioctl_pidfd.h"
+#include "lapi/sched.h"
+
+static struct tst_clone_args *args;
+static struct pidfd_info *info;
+
+static void run(void)
+{
+	int status;
+	int pidfd = 0;
+	pid_t pid_child;
+
+	memset(args, 0, sizeof(struct tst_clone_args));
+
+	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
+	args->pidfd = (uint64_t)&pidfd;
+	args->exit_signal = SIGCHLD;
+
+	pid_child = SAFE_CLONE(args);
+	if (!pid_child)
+		exit(100);
+
+	info->mask = 0;
+
+	/* child is not reaped, so ioctl() will pass */
+	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, 0);
+
+	SAFE_WAITPID(pid_child, &status, 0);
+
+	/* child is now reaped, so we get ESRCH */
+	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
+	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, 0);
+
+	SAFE_CLOSE(pidfd);
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_info_exit_supported())
+		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{&info, .size = sizeof(*info)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
