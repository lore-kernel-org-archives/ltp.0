Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B2C71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:07:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37EA23CA115
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:07:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8253CA085
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCD951000BD9
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23F4A1F451;
 Mon,  7 Jul 2025 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/eNOaY+AgVslJO9H4HocySA0BDwAIy+GKVwawY1kzg=;
 b=Bs+WNkGgdoh61AwSzjs2JVGehiB0u1n5EH/cNPba162N38hAxtHfir669sL35fbZEXqrD5
 BsaPKJHUf0vhneUo+N5Jy5HGK2qsLmpF5MqEC2q44C+wBL7rVirim6nmsBB4C8lrCo7/OY
 XeOwr3wr5FBxMzPR5crgQcxwe/f40Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/eNOaY+AgVslJO9H4HocySA0BDwAIy+GKVwawY1kzg=;
 b=l+x91U/9JzlLT6Oei6RseOQsbgottZQjY1A0zI8TufiLUIHUbbzc8ZfK62neFT8TzB/NoO
 VScpeKaOQs+5jpBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/eNOaY+AgVslJO9H4HocySA0BDwAIy+GKVwawY1kzg=;
 b=Bs+WNkGgdoh61AwSzjs2JVGehiB0u1n5EH/cNPba162N38hAxtHfir669sL35fbZEXqrD5
 BsaPKJHUf0vhneUo+N5Jy5HGK2qsLmpF5MqEC2q44C+wBL7rVirim6nmsBB4C8lrCo7/OY
 XeOwr3wr5FBxMzPR5crgQcxwe/f40Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/eNOaY+AgVslJO9H4HocySA0BDwAIy+GKVwawY1kzg=;
 b=l+x91U/9JzlLT6Oei6RseOQsbgottZQjY1A0zI8TufiLUIHUbbzc8ZfK62neFT8TzB/NoO
 VScpeKaOQs+5jpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C008C13A66;
 Mon,  7 Jul 2025 17:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EFWjKXH+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:46 +0200
MIME-Version: 1.0
Message-Id: <20250707-ioctl_pidfd_suite-v3-5-22ba4d15ee02@suse.com>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=3175;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=d4paHk+K3pi277qu0vRj9u5wcfz/JgD9We+PtWkSTQE=;
 b=UvD/fhXvFTN6/XBbP/AlY4j9DOwUgbfsX5n98RpAixKBY2M1iZ5mhQu1lSouRJdTncDEuEvdI
 Vsb/z1ki5nYArCWU/UqfyHHhkhp/4gKn/gM2Hnkbeq+ArSfP/avhlD/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/8] Add ioctl_pidfd03 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 62 +++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 23f335846663d62a39e6de3a8f6948c1b0acf8a5..8eec613a941a83b1fed25f96cdce617da0b0ef34 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -614,6 +614,7 @@ ioctl_fiemap01 ioctl_fiemap01
 
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
+ioctl_pidfd03 ioctl_pidfd03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 1c81c2bed8db952af0c93fb1ce5bfbad82794b60..08387dc8f2bc43f8f3a75264841da4beee28bfac 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -31,3 +31,4 @@
 /ioctl_fiemap01
 /ioctl_pidfd01
 /ioctl_pidfd02
+/ioctl_pidfd03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
new file mode 100644
index 0000000000000000000000000000000000000000..39acc301f0b4ac2105ad97fca91d16c20af92131
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -0,0 +1,62 @@
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
+}
+
+static void setup(void)
+{
+	if (!ioctl_pidfd_supported())
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
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
