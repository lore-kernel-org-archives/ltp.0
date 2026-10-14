Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8967CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 421DD3E9A6E
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:35:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1BFF3E6C83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:34:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 484AA60098E
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:34:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 902291F444;
 Wed, 14 Oct 2026 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791977688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H9d2A46ORDLBbuK7JfN02hEZRuvpoVEIgiNloYQ+0RM=;
 b=qsfKKOEPdKXw9pWyaZuzOxR1p88h99IoC1JJ4b0g5R+GN43dXtuWVU4WFO6m6XDkcLUrQk
 4hsqxun+zbbEtnZxJ56w3aeOlBFH793WN1VyAMUnECyZd790aiypoBjTXt60U9jFexHDtD
 qiw5Z5eLskHY6PvMPYKfcTzqMtBf+r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791977688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H9d2A46ORDLBbuK7JfN02hEZRuvpoVEIgiNloYQ+0RM=;
 b=mJ0bTWXRiF5j0LWicUDvGIWICO6sMJ1deih+d5y5GBxdI7R5UxhPKdFXxv6gq4xxbddbZN
 a82qbxtooexzVNBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qsfKKOEP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mJ0bTWXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791977688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H9d2A46ORDLBbuK7JfN02hEZRuvpoVEIgiNloYQ+0RM=;
 b=qsfKKOEPdKXw9pWyaZuzOxR1p88h99IoC1JJ4b0g5R+GN43dXtuWVU4WFO6m6XDkcLUrQk
 4hsqxun+zbbEtnZxJ56w3aeOlBFH793WN1VyAMUnECyZd790aiypoBjTXt60U9jFexHDtD
 qiw5Z5eLskHY6PvMPYKfcTzqMtBf+r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791977688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H9d2A46ORDLBbuK7JfN02hEZRuvpoVEIgiNloYQ+0RM=;
 b=mJ0bTWXRiF5j0LWicUDvGIWICO6sMJ1deih+d5y5GBxdI7R5UxhPKdFXxv6gq4xxbddbZN
 a82qbxtooexzVNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46775133F1;
 Wed, 14 Oct 2026 11:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BwpuOtdoz2oaPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 14 Oct 2026 11:34:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Oct 2026 13:34:45 +0200
MIME-Version: 1.0
Message-Id: <20261014-fix_process_vm_writev_permissions-v2-1-17710f74606c@suse.com>
X-B4-Tracking: v=1; b=H4sIANRoz2oC/5WOQQ6CMBREr0K6toY20oAr72FIU8qvfBMo6YeqI
 dzdFk/g8iUzb2ZjBAGB2LXYWICIhH5KIE8Fs4OZHsCxT8xkKZUoxYU7fOs5eAtEOo76FXCBqGc
 II1IuE1fOGlU1dd+4jiXPHCCVjo17+2NauyfYJYtzYkBafPgcJ6LIuX/2ouCCK+McgOxNXTU3W
 gnO1o+s3ff9C/jn/BzjAAAA
X-Change-ID: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791977688; l=5392;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uzOgJPtq4P8F6y9rZCUV1CAlfigy1ja4N8J8cB+61vI=;
 b=VQBUJVUGs9tG27G0ZC5blOPUxNTY5r7b8O5E3u0UxuYbF7FZZiDSTpQqhnzCShP1YautID8gq
 r+gzUBgehD0BSIfxSuxjseA7E1QhClYxVLJAzlfjkX+SIGWF04avWqB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 902291F444
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/cma: Handle Yama ptrace_scope in tests
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

With Yama LSM enabled, process_vm_readv() and process_vm_writev() fail
with EPERM when a sibling process accesses the target's memory.

Let the target child declare its parent as ptracer, so that mode 1
works for unprivileged users too. Require CAP_SYS_PTRACE for mode 2
and skip on mode 3, where access is never allowed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
The cma testing suite started to fail on modern systems enabling YAMA.
Unfortunately, using CAP_PTRACE capability for users is not enough to
avoid an EPERM. For this reason, it's better to require root and fix the
whole suite in one shot.
---
Changes in v2:
- consider mode 1, 2, 3 and user
- Link to v1: https://lore.kernel.org/20261014-fix_process_vm_writev_permissions-v1-1-6affee2da859@suse.com
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

---
base-commit: 1aae0e4d9d1e2e7818fda773b372cee8fb856de7
change-id: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
