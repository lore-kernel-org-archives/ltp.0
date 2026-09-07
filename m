Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61354C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1D6F3E86D8
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 10:56:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F6C3E5355
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F0BB100034A
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4B0E1F7AF;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCqDGGcfHpnv3gHx0dyZtYpgAkOP7kz2mUhEQwWe0OA=;
 b=Ya0o5WYkcbsizTDXQ9Z8Pb6IDncqeO3eHBvwKSGiHwNIxYqUMIaveihgQPwPXE1/i42pT7
 tVY52OatVAKMIuqBnR6HMjOpaxzxOMcaJFKfnBkFfz3zRB3eCnZQ0k7JeDVbfQvQBvDlCF
 6+lQQwu/CKzqVCSWTHZ0yRr0sLY+u2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCqDGGcfHpnv3gHx0dyZtYpgAkOP7kz2mUhEQwWe0OA=;
 b=lt89FSBALq6ozLTXcDMNJ3KHL4ZkIM8SS136rC32RVWAnFk+IZ25MeIU0o3TDahunFFtAf
 zE+Rrx2aVm6E6BDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iFRBKU2U;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="of0/esOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCqDGGcfHpnv3gHx0dyZtYpgAkOP7kz2mUhEQwWe0OA=;
 b=iFRBKU2U0omMiGZ+uvUQrmnT784mmHvVAJN+4cHW7kfNlhnJv/eN6trKxUnOsSc/JbIJ7K
 /EKb9lYMbwZORmVqZeAbK8cLV90Udh+kB63g70Bo7Zlnly/Kap7DFKj92cG+bfcDGjvhC9
 LDL4QgikMv3qLaTxTs6ZHTifkJLmi44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCqDGGcfHpnv3gHx0dyZtYpgAkOP7kz2mUhEQwWe0OA=;
 b=of0/esOn10K7+hZ5gjM5P+LN9NUe9dt7OPcHsJpP2D4vxAFx7QgAS2KGJJhwiDwWWCkyo7
 PwyVtCTVV24ODeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C8D51368D;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EACXHPp7nmr3WwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Sep 2026 08:55:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Sep 2026 10:55:16 +0200
MIME-Version: 1.0
Message-Id: <20260907-process_mrelease-v3-1-03bde3e5d77c@suse.com>
References: <20260907-process_mrelease-v3-0-03bde3e5d77c@suse.com>
In-Reply-To: <20260907-process_mrelease-v3-0-03bde3e5d77c@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788771322; l=4275;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=9PmZnNwAlZF/vupew1AW97/ecV5AXZ5CiQ6fHcm2gFI=;
 b=+8SrYEB7OaOo9OlRlqhSmzG2QRUU8Ge59uBw876azzXEyso5hxp7sr3TpmNEO1amMWi4yAdl4
 jyllQiZ6AmaCAadslUwWQtoexbILCx8+td86eG4d7+4KdDDJo5f4m34
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B4B0E1F7AF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add process_mrelease01 test
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

Verify process_mrelease() releases memory from a dying process.
If the child process terminates before the syscall can reap its
address space, retry with larger memory allocations to extend
teardown duration.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
 .../kernel/syscalls/process_mrelease/Makefile      |  7 ++
 .../syscalls/process_mrelease/process_mrelease01.c | 94 ++++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 737c63e31..cfe76efca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1151,6 +1151,8 @@ preadv203_64 preadv203_64
 
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
index 000000000..37001e846
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease01.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test verifies that :manpage:`process_mrelease(2)` syscall releases memory
+ * from a killed process with pending memory allocations.
+ *
+ * [Algorithm]
+ *
+ * - Spawn a child process allocating and dirtying anonymous memory
+ * - Wait until the child is ready via checkpoints
+ * - Obtain child's pidfd and send SIGKILL to the child
+ * - Invoke process_mrelease(pidfd, 0)
+ * - If process_mrelease() fails with ESRCH (child terminated too fast),
+ *   double the allocation size and retry
+ * - Check that process_mrelease() succeeds
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define CHUNK (1 * TST_MB)
+#define MAX_SIZE_MB (1024 * TST_MB)
+
+static void do_child(size_t size)
+{
+	void *mem;
+
+	tst_res(TINFO, "Child: allocate %zu MB", size / TST_MB);
+
+	mem = SAFE_MMAP(NULL,
+		size,
+		PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANON,
+		-1, 0);
+
+	memset(mem, 0, size);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_MUNMAP(mem, size);
+}
+
+static void run(void)
+{
+	size_t mem_size;
+	pid_t pid;
+	int pidfd;
+	int status;
+
+	for (mem_size = CHUNK; mem_size <= MAX_SIZE_MB; mem_size *= 2) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			do_child(mem_size);
+			exit(0);
+		}
+
+		TST_CHECKPOINT_WAIT(0);
+
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+
+		SAFE_KILL(pid, SIGKILL);
+
+		TEST(tst_syscall(__NR_process_mrelease, pidfd, 0));
+
+		SAFE_WAITPID(pid, &status, 0);
+		SAFE_CLOSE(pidfd);
+
+		if (TST_RET == 0) {
+			tst_res(TPASS, "process_mrelease() passed with %zu MB",
+				mem_size / TST_MB);
+			return;
+		}
+
+		if (TST_ERR != ESRCH) {
+			tst_res(TFAIL | TTERRNO, "process_mrelease() failed");
+			return;
+		}
+
+		tst_res(TINFO,
+			"Child terminated before process_mrelease(). Increasing memory size and retrying");
+	}
+
+	tst_res(TFAIL, "All process_mrelease() attempts failed with ESRCH");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
