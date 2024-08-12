Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D727C52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 11:47:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8F213D210B
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 13:47:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 596FA3CD80A
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67FF1200339
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 219D022454;
 Mon, 12 Aug 2024 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji+vC1FS9WVqLV+1r+v8tt0dhQ8PyQFZM6PBxlWvkUw=;
 b=npeiT57WwKLs6RFacdKfeHwV1AQxJeaN8BTqQZlx6fI4yXXvV2Qo+T7l3p7lz4/GHiHcjs
 zuYJM55diMetsschj6CPrp9GVH3uSWOpBo5tkdMhFCzMky71GTwqdLeJ8FHQ0IpWo8oC1b
 1OtVKX5E6D3ZrsurRpBM+2CkRC+SEqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji+vC1FS9WVqLV+1r+v8tt0dhQ8PyQFZM6PBxlWvkUw=;
 b=JQRFBzSjRWfkcItk1O2YYHzpxL+8kHNx7yqj6uj5bZhXqj3647e0AEk+RyNdQ2yT7hf3tx
 7rm5DUKpMEgIrfAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji+vC1FS9WVqLV+1r+v8tt0dhQ8PyQFZM6PBxlWvkUw=;
 b=npeiT57WwKLs6RFacdKfeHwV1AQxJeaN8BTqQZlx6fI4yXXvV2Qo+T7l3p7lz4/GHiHcjs
 zuYJM55diMetsschj6CPrp9GVH3uSWOpBo5tkdMhFCzMky71GTwqdLeJ8FHQ0IpWo8oC1b
 1OtVKX5E6D3ZrsurRpBM+2CkRC+SEqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji+vC1FS9WVqLV+1r+v8tt0dhQ8PyQFZM6PBxlWvkUw=;
 b=JQRFBzSjRWfkcItk1O2YYHzpxL+8kHNx7yqj6uj5bZhXqj3647e0AEk+RyNdQ2yT7hf3tx
 7rm5DUKpMEgIrfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA1CA13AD8;
 Mon, 12 Aug 2024 11:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aHBPNxX2uWYTWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 12 Aug 2024 11:46:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 12 Aug 2024 13:46:29 +0200
MIME-Version: 1.0
Message-Id: <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
In-Reply-To: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723463189; l=5646;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=yndh7l7u/5t2gDO/JAxbFDMFFctCk1Lge2Vnu0CXGc8=;
 b=8tXmpnTzlfvXuFkc9GKXku9O/Y/dPrXtOjHWIKA4qgDUNc7uqCoB1PJMwM8qaSVyZkALlWcQP
 A8diTv4BJAMCTEYK/bAYtCkLn24SF8Gdol6tWaUIkq8XEor+G0x2wkT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Add process_mrelease01 test
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
 .../kernel/syscalls/process_mrelease/Makefile      |   7 +
 .../syscalls/process_mrelease/process_mrelease01.c | 168 +++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 706dd56dc..de90e9ba3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1073,6 +1073,8 @@ preadv203_64 preadv203_64
 
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
index 000000000..8a0a2c3b4
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease01.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesaend_addr <andrea.cervesaend_addr@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that process_mrelease() syscall is releasing memory start_addr
+ * a killed process with memory allocation pending.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/syscalls.h"
+
+#define CHUNK (1 * TST_MB)
+#define MAX_SIZE_MB (128 * TST_MB)
+
+static unsigned long *mem_addr;
+static volatile int mem_size;
+
+static void do_child(int size)
+{
+	void *mem;
+
+	tst_res(TINFO, "Child: allocate %d bytes", size);
+
+	mem = SAFE_MMAP(NULL,
+		size,
+		PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANON,
+		0, 0);
+
+	memset(mem, 0, size);
+
+	*mem_addr = (unsigned long)mem;
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	tst_res(TINFO, "Child: releasing memory");
+
+	SAFE_MUNMAP(mem, size);
+}
+
+static int memory_is_mapped(pid_t pid, unsigned long start, unsigned long end)
+{
+	FILE *fmaps;
+	int mapped = 0;
+	char buff[1024];
+	char pid_maps[128] = {0};
+	unsigned long start_addr, end_addr;
+
+	snprintf(pid_maps, sizeof(pid_maps), "/proc/%d/maps", pid);
+	fmaps = SAFE_FOPEN(pid_maps, "r");
+
+	while (!feof(fmaps)) {
+		memset(buff, 0, sizeof(buff));
+
+		if (!fgets(buff, sizeof(buff), fmaps))
+			break;
+
+		if (sscanf(buff, "%lx-%lx", &start_addr, &end_addr) != 2) {
+			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/%ud/maps line.", pid);
+			break;
+		}
+
+		if (start == start_addr && end == end_addr) {
+			mapped = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(fmaps);
+
+	return mapped;
+}
+
+static void run(void)
+{
+	int ret;
+	int pidfd;
+	int status;
+	pid_t pid;
+	int restart;
+
+	for (mem_size = CHUNK; mem_size < MAX_SIZE_MB; mem_size += CHUNK) {
+		restart = 0;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			do_child(mem_size);
+			exit(0);
+		}
+
+		TST_CHECKPOINT_WAIT(0);
+
+		tst_disable_oom_protection(pid);
+
+		if (!memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size)) {
+			tst_res(TFAIL, "Memory is not mapped");
+			break;
+		}
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
+				tst_res(TINFO, "Parent: child terminated before "
+					"process_mrelease(). Increase memory size and "
+					"restart test");
+
+				restart = 1;
+			} else {
+				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
+			}
+		} else {
+			int timeout_ms = 1000;
+
+			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
+
+			while (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size) &&
+				timeout_ms--)
+				usleep(1000);
+
+			if (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size))
+				tst_res(TFAIL, "Memory is still mapped inside child memory");
+			else
+				tst_res(TPASS, "Memory has been released");
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
+	mem_addr = SAFE_MMAP(NULL,
+		sizeof(unsigned long),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANON,
+		0, 0);
+}
+
+static void cleanup(void)
+{
+	if (mem_addr)
+		SAFE_MUNMAP(mem_addr, sizeof(unsigned long));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
