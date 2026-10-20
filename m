Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC10606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UDQZ53R3;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2AgbXXyG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DmVHJPaQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jkfvy293
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B518D3E6145
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:38:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 910FD3EA610
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:37:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C4D21400332
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:37:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07D8221DBB;
 Tue, 20 Oct 2026 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792492652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzy3UDg6xs/tT/QbFdhbtHNh/1EP58U6Kycm4W2ehMU=;
 b=UDQZ53R3dUFqa/vigeJ+Il5CVn2DiAkXCMZFxo1OZa1yC8MNyUJTH9iP8l4yckHb/tElRG
 WrLyS9fxCqhEjc2uV6u1nwIqaFqcVydGlCZkpDGWzNqdSfgFs70jklyewwhpEEMUlISSRW
 14ghYk0ySoVfsyBF15TBZXoo4qM0zYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792492652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzy3UDg6xs/tT/QbFdhbtHNh/1EP58U6Kycm4W2ehMU=;
 b=2AgbXXyG/drF9LUq0d/GWkFXjOS3A3F+02xW5qA/+cwCjzqYp+woT8kfsMdedWv2kWCTMt
 1WJiDVNp6vUA4uBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DmVHJPaQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jkfvy293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792492651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzy3UDg6xs/tT/QbFdhbtHNh/1EP58U6Kycm4W2ehMU=;
 b=DmVHJPaQkCktzU2Uy9iUa3YQpbKd15JKJEEKxSSpd+CPBsHQTFRYg0xeht18EvBqsnjtzN
 MDDaW64Ep+BKmoUuM9YqFt+4aHb/00Svk5+OA9W8LB3oN3vJKbsqY1kynE1+tP4miLLm06
 2jNXmCJoT0wDqwri5WVxnYFLO7YhZ+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792492651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzy3UDg6xs/tT/QbFdhbtHNh/1EP58U6Kycm4W2ehMU=;
 b=Jkfvy293p6B87/6mIeI9pbB99qLGxTXYGE18nMbG+ICuEj5W46yNRbFjQ6GgW5mb1tL84Z
 Y0Yp6eHKMBZUSkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAE33137DB;
 Tue, 20 Oct 2026 10:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wwr3FWpE12rQSAAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:37:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:37:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fix_process_vm_writev_permissions-v3-2-1e92d7a29aef@suse.com>
References: <20261020-fix_process_vm_writev_permissions-v3-0-1e92d7a29aef@suse.com>
In-Reply-To: <20261020-fix_process_vm_writev_permissions-v3-0-1e92d7a29aef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492650; l=4796;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PekHxBw9K9BhN4pUTjX3UHgOD1h7KKc8/ONNqvk8JAU=;
 b=fo3vHm++AkY+CybXdlO7LIf/gf7MyDFLItHE9k+Q1evzVOdiMeG9duQiebVCW4JxC7H15gugj
 pqNq7tKXqqhAgtMr+E7bE/Kxn2oWOw4byARIpCYqleAnOeGF7W01QfD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 07D8221DBB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] syscalls/cma: Handle Yama ptrace_scope in tests
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

With Yama LSM enabled, process_vm_readv() and process_vm_writev() fail
with EPERM when a sibling process accesses the target's memory.

Let the target child declare its parent as ptracer, so that mode 1
works for unprivileged users too. Require CAP_SYS_PTRACE for mode 2
and skip on mode 3, where access is never allowed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/cma/cma.h                | 38 ++++++++++++++++++++++
 testcases/kernel/syscalls/cma/process_vm_readv02.c |  5 +++
 testcases/kernel/syscalls/cma/process_vm_readv03.c |  5 +++
 .../kernel/syscalls/cma/process_vm_writev02.c      |  5 +++
 4 files changed, 53 insertions(+)

diff --git a/testcases/kernel/syscalls/cma/cma.h b/testcases/kernel/syscalls/cma/cma.h
new file mode 100644
index 000000000..6636cb5a3
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/cma.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef CMA_H__
+#define CMA_H__
+
+#include <sys/prctl.h>
+#include "tst_test.h"
+#include "tst_capability.h"
+
+#define PTRACE_SCOPE "/proc/sys/kernel/yama/ptrace_scope"
+
+static inline void cma_check_ptrace_scope(void)
+{
+	struct tst_cap cap = TST_CAP(TST_CAP_REQ, CAP_SYS_PTRACE);
+	int scope;
+
+	if (access(PTRACE_SCOPE, F_OK))
+		return;
+
+	SAFE_FILE_SCANF(PTRACE_SCOPE, "%d", &scope);
+
+	if (scope >= 3)
+		tst_brk(TCONF, "Yama ptrace_scope=%d forbids process_vm_*()", scope);
+
+	if (scope == 2)
+		tst_cap_action(&cap);
+}
+
+static inline void cma_allow_parent_ptracer(void)
+{
+	if (prctl(PR_SET_PTRACER, getppid(), 0, 0, 0) && errno != EINVAL)
+		tst_brk(TBROK | TERRNO, "prctl(PR_SET_PTRACER)");
+}
+
+#endif /* CMA_H__ */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 1e2ac38fa..ceff77e29 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -17,6 +17,7 @@
 #include <sys/wait.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "cma.h"
 
 static uintptr_t *data_ptr;
 
@@ -29,6 +30,8 @@ static void child_alloc(const char *data)
 
 	tst_res(TINFO, "child 0: memory allocated and initialized");
 
+	cma_allow_parent_ptracer();
+
 	/* wake and wait until child_invoke is done reading from our VM */
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 }
@@ -64,6 +67,8 @@ static void setup(void)
 	/* Just a sanity check of the existence of syscall */
 	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
+	cma_check_ptrace_scope();
+
 	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
 						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 95d35c422..831f79c89 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -20,6 +20,7 @@
 #include <sys/wait.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "cma.h"
 
 #define MAX_IOVECS 1024
 
@@ -80,6 +81,8 @@ static void child_alloc(const int *sizes, int nr_iovecs)
 
 	tst_res(TINFO, "child_alloc: memory allocated and initialized");
 
+	cma_allow_parent_ptracer();
+
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 }
 
@@ -139,6 +142,8 @@ static void setup(void)
 {
 	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
+	cma_check_ptrace_scope();
+
 	data_ptr = SAFE_MMAP(NULL, sizeof(void *) * MAX_IOVECS, PROT_READ | PROT_WRITE,
 			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 15bd66a44..78b98200f 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -16,6 +16,7 @@
 #include <sys/uio.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "cma.h"
 
 static uintptr_t *data_ptr;
 static char *str_buffsize;
@@ -33,6 +34,8 @@ static void child_alloc_and_verify(int buffsize)
 	memset(foo, 'a', buffsize);
 	*data_ptr = (uintptr_t)foo;
 
+	cma_allow_parent_ptracer();
+
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	err = 0;
@@ -81,6 +84,8 @@ static void setup(void)
 	if (tst_parse_int(str_buffsize, &bufsize, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid buffer size '%s'", str_buffsize);
 
+	cma_check_ptrace_scope();
+
 	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
 			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
