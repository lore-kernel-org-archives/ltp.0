Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F26C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:19:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075A03E7019
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:19:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB5FD3E701F
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B440B1A01002
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D63AA805F7;
 Fri,  7 Aug 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4M6eTUHvBZ0cLy2afAK8JdKqh5EuiIfAlEQe65prec=;
 b=RH1A3w8DbJLTnNEcrNDgSqn3pJ6f/9VM10ydpVouwrKrlq4huT3uDrrWvahPCPwDngx0Bt
 ZSbqR5VDpvNSECUCpic+jyKXbYbA5tInjvmx+vBS0OhAPb1BRRNfh6p1futzR89GcMvDc/
 Jo0z7NLme1F1ICaoklHzcoBqiHZ+BrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4M6eTUHvBZ0cLy2afAK8JdKqh5EuiIfAlEQe65prec=;
 b=Ir2jUnrlzxvUTsjPml9fw9Kh+7lRmr85SkJifdRsYPO8m7Tl/S9nV9MYY6sJxRqZBfbU62
 Ojz84QZimDkgd3AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kdM6pwNK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZHC4CQTI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4M6eTUHvBZ0cLy2afAK8JdKqh5EuiIfAlEQe65prec=;
 b=kdM6pwNKecyk1nEQl5ZmfF3QcN00G9EG3z4Pu/VmhchM3VJv+3ihVaNy/4NGbPfTdLHq03
 UdPmm4vdRg19CETXb/Ud3s5PnhTaGgp10WpGpq/NVCADIeA9CHv+UibMFZe9c+J+afINSf
 +jJi4Gp1DJGbYh9kLUUFXb95NL/4rPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4M6eTUHvBZ0cLy2afAK8JdKqh5EuiIfAlEQe65prec=;
 b=ZHC4CQTIAZGS28lqv7vv29Oo01t36py9F/GUyJ7DEkQqmoU2H2ccxxNBo6WhQwn1jRiJV4
 OnhG99ovPVlnvLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BFDB779E0;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oBuQO87MdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:16 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-7-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=2967;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Lr341xA71VwyEl4Z3y5bxdHqLkty1DQN39YaMT6NzBw=;
 b=mHpkiK4s80B+JMte86w61QPJqVpA0aBqa1SC14j4trEzS9AgRIuR1FTnR+iLc4u/Z8dHuYZf6
 ySRD8p2Ne9aBGO7wCZgCkrWBN5LDOj14y3Tfq1LAox/mtTuizcEJmSK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D63AA805F7
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/7] mremap09: Add test for expanding over unmapped
 gap
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

Add a test case for mremap() without MREMAP_MAYMOVE where we map
three pages, unmap the middle one to create a hole, and then
attempt to expand the first page to cover all three. The mremap()
call must fail with ENOMEM since the third page is occupied.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/mremap/.gitignore |  1 +
 testcases/kernel/syscalls/mremap/mremap09.c | 59 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ede795a48..5166886c4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -947,6 +947,7 @@ mremap05 mremap05
 mremap06 mremap06
 mremap07 mremap07
 mremap08 mremap08
+mremap09 mremap09
 
 mseal01 mseal01
 mseal02 mseal02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index dd4bf4e8e..a7ae3b643 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -6,3 +6,4 @@
 /mremap06
 /mremap07
 /mremap08
+/mremap09
diff --git a/testcases/kernel/syscalls/mremap/mremap09.c b/testcases/kernel/syscalls/mremap/mremap09.c
new file mode 100644
index 000000000..28ab9e310
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap09.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify that :manpage:`mremap(2)` fails with errno ``ENOMEM`` when it is used
+ * to expand an existing mapping in place, if the region cannot be expanded at
+ * the current virtual address and the ``MREMAP_MAYMOVE`` flag is not set.
+ *
+ * [Algorithm]
+ *
+ * - map an anonymous region of three pages
+ * - unmap the middle page to create a gap
+ * - call mremap() on the first page to grow it to three pages with ``flags``
+ *   set to 0
+ * - expect the call to fail with ``MAP_FAILED`` and ``ENOMEM`` since the
+ *   third page is occupied.
+ */
+
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include "tst_test.h"
+
+static size_t pagesize;
+static void *addr = MAP_FAILED;
+
+static void setup(void)
+{
+	pagesize = getpagesize();
+}
+
+static void run(void)
+{
+	size_t map_size = 3 * pagesize;
+	size_t old_size = 1 * pagesize;
+	size_t new_size = 3 * pagesize;
+
+	addr = SAFE_MMAP(NULL, map_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	/* unmap the middle page to create a gap */
+	SAFE_MUNMAP((char *)addr + pagesize, pagesize);
+
+	TST_EXP_FAIL_PTR_VOID(mremap(addr, old_size, new_size, 0), ENOMEM);
+
+	if (TST_RET_PTR != MAP_FAILED) {
+		SAFE_MUNMAP(TST_RET_PTR, new_size);
+		return;
+	}
+
+	SAFE_MUNMAP(addr, pagesize);
+	SAFE_MUNMAP((char *)addr + 2 * pagesize, pagesize);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
