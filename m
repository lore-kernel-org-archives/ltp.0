Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A46AC25B7A
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 14:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0312E3D00F9
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 16:33:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9CE23CEB69
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:44 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D275A2079EB
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CA2A22C10;
 Wed, 22 May 2024 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkVIitkWTj5uQPtzz9FkVhu9WG1Fm8C+7Jsq5Qy2qQw=;
 b=ES/pMQOeSuQ/S0ZyIgbIfQ4YtT64fyxkniOu425kcvVjZpvkmKPOdYtx0aENJUVaEp7gLe
 AyaLGIBGiL+ONF6Lnli8i56p+x7DAiqPiuotZx77o0vwyvxTrgf21Y+UtZy+KHMtPp9dtd
 i8V2Rn2k5ik+q1yqZ0DV2f4mGn2wut4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkVIitkWTj5uQPtzz9FkVhu9WG1Fm8C+7Jsq5Qy2qQw=;
 b=wol33jxN4xYw+lGwkea8E6VuKadZpXQuRqrbbMwwbLMcDWIiqc3EbjDsgf2cy/g0+uFDzf
 PkyzhgJH3itWjqAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ES/pMQOe";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wol33jxN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkVIitkWTj5uQPtzz9FkVhu9WG1Fm8C+7Jsq5Qy2qQw=;
 b=ES/pMQOeSuQ/S0ZyIgbIfQ4YtT64fyxkniOu425kcvVjZpvkmKPOdYtx0aENJUVaEp7gLe
 AyaLGIBGiL+ONF6Lnli8i56p+x7DAiqPiuotZx77o0vwyvxTrgf21Y+UtZy+KHMtPp9dtd
 i8V2Rn2k5ik+q1yqZ0DV2f4mGn2wut4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkVIitkWTj5uQPtzz9FkVhu9WG1Fm8C+7Jsq5Qy2qQw=;
 b=wol33jxN4xYw+lGwkea8E6VuKadZpXQuRqrbbMwwbLMcDWIiqc3EbjDsgf2cy/g0+uFDzf
 PkyzhgJH3itWjqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3637E13A6B;
 Wed, 22 May 2024 14:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMCrCkcCTmaJOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 May 2024 14:33:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 May 2024 16:33:06 +0200
MIME-Version: 1.0
Message-Id: <20240522-process_mrelease-v1-2-41fe2fa44194@suse.com>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
In-Reply-To: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=PwLcQfkUrQekE664H1X+AYTSyOCsurlB+3xweaAIpXw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTgJG7W/ERy7eMd76iGJPYNCsXP+u2rNbbCr2U
 K63lmQYkG+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZk4CRgAKCRDLzBqyILPm
 RhcKC/wLfJFiBYY+EyPWGRKbaJ+wQRUaD9PZsM6VZ9YJBAFOQ3wh6gETnGgRgxA94+nbjEeDvU+
 wHd+1ZtJ5AKrn1IU8fR/n2r8+9BCgXza8kn3dwlZx4Dnx3aktnGQfYW1rQrs/zmz83o7mJj3Gpj
 vLz7A8gLfIJbYKBedDxKcaLziH9YmL82rNsfkU9zL7DBzZfBImjsz4JuOomrNAZRUSeHsuusuIy
 kHPQTDgPAWprxctrhR+tI7cfKjVaDgsD2DKaNX5Cn3jAnUfnsbRgnlFVeHKeklVAVvpCoITbTvw
 4k2CTIkYp1BSMbzkziWuc2LuvWLpqZrW7J3I9Mq8z2U9YRCdA0WtQeg08x4X4sxtMk4rVzRuJ4U
 A+1uOhXYWIQreZ3klFQEHm2V41MDWTGvEodLNggVv1DT/QASc9XM7vf+c3UduAuyg5MWnIbb6Da
 2Dga+rdVIA2XbGCsRqazQGgkxzBeeSZyWzGU7HyprIb3ZLMwSs+4mbxu3tV+ZoDDMgS3g=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5CA2A22C10
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Add process_mrelease01 test
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

This test verifies that process_mrelease() syscall is releasing memory
from a killed process with memory allocation pending.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   2 +
 .../kernel/syscalls/process_mrelease/.gitignore    |   1 +
 .../kernel/syscalls/process_mrelease/Makefile      |   7 ++
 .../syscalls/process_mrelease/process_mrelease01.c | 118 +++++++++++++++++++++
 4 files changed, 128 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..46a85fd31 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1050,6 +1050,8 @@ preadv203_64 preadv203_64
 
 profil01 profil01
 
+process_mrelease01 process_mrelease01
+
 process_vm_readv01 process_vm01 -r
 process_vm_readv02 process_vm_readv02
 process_vm_readv03 process_vm_readv03
diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
new file mode 100644
index 000000000..673983858
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
@@ -0,0 +1 @@
+/process_mrelease01
diff --git a/testcases/kernel/syscalls/process_mrelease/Makefile b/testcases/kernel/syscalls/process_mrelease/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease01.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease01.c
new file mode 100644
index 000000000..aa7c9960c
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that process_mrelease() syscall is releasing memory from
+ * a killed process with memory allocation pending.
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define CHUNK (1 * TST_MB)
+#define MAX_SIZE_MB (128 * TST_MB)
+
+static void *mem;
+static volatile int *mem_size;
+
+static void do_child(int size)
+{
+	tst_res(TINFO, "Child: allocate %d bytes", size);
+
+	mem = SAFE_MMAP(NULL,
+		size,
+		PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANON,
+		0, 0);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	tst_res(TINFO, "Child: releasing memory");
+
+	SAFE_MUNMAP(mem, size);
+}
+
+static void run(void)
+{
+	int ret;
+	int pidfd;
+	int status;
+	pid_t pid;
+	volatile int restart;
+
+	for (*mem_size = CHUNK; *mem_size < MAX_SIZE_MB; *mem_size += CHUNK) {
+		restart = 0;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			do_child(*mem_size);
+			exit(0);
+		}
+
+		TST_CHECKPOINT_WAIT(0);
+
+		tst_disable_oom_protection(pid);
+
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+
+		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
+
+		SAFE_KILL(pid, SIGKILL);
+
+		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
+		if (ret == -1) {
+			if (errno == ESRCH) {
+				tst_res(TINFO, "Parent: child terminated before process_mrelease()."
+					" Increase memory size and restart test");
+
+				restart = 1;
+			} else {
+				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
+			}
+		} else {
+			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
+		}
+
+		SAFE_WAITPID(-1, &status, 0);
+		SAFE_CLOSE(pidfd);
+
+		if (!restart)
+			break;
+	}
+}
+
+static void setup(void)
+{
+	mem_size = SAFE_MMAP(
+		NULL,
+		sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+}
+
+static void cleanup(void)
+{
+	if (mem)
+		SAFE_MUNMAP(mem, *mem_size);
+
+	if (mem_size)
+		SAFE_MUNMAP((void *)mem_size, sizeof(int));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_MMU=y",
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
