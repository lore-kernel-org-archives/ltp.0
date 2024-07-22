Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B9AC3DA5D
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:30:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 241AA3D1BE9
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:30:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A2173D0C06
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04F3F601405
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCE1921BB0;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkFxdFl7jR6KujdwGsx679ej3wa5LeF4hx9ZkitGN+4=;
 b=w3REsMKW3E14xbjQjGa8yqA7XEYWP16SB3nMPPPSEaxgYayoXJpJDjDWEHwn8YoUQS5/5t
 eoVnxXIuMpnPHYUbzA1c1Qmyinj7lHEl1O+T/9bKN0IU50KUWUsHFgLRjoufwHSEyIoC7O
 a4Xbq9BEk2onwgCmHP1rA+PVYpHbZ1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkFxdFl7jR6KujdwGsx679ej3wa5LeF4hx9ZkitGN+4=;
 b=+aRT4jtmgsa4QNi8raRW79By07XsvbCbtng45dGIWyBWXqDrdom0Y34V/5NT1xf4Z8MXP9
 Ux8dCKsIyaqP/0Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w3REsMKW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+aRT4jtm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkFxdFl7jR6KujdwGsx679ej3wa5LeF4hx9ZkitGN+4=;
 b=w3REsMKW3E14xbjQjGa8yqA7XEYWP16SB3nMPPPSEaxgYayoXJpJDjDWEHwn8YoUQS5/5t
 eoVnxXIuMpnPHYUbzA1c1Qmyinj7lHEl1O+T/9bKN0IU50KUWUsHFgLRjoufwHSEyIoC7O
 a4Xbq9BEk2onwgCmHP1rA+PVYpHbZ1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkFxdFl7jR6KujdwGsx679ej3wa5LeF4hx9ZkitGN+4=;
 b=+aRT4jtmgsa4QNi8raRW79By07XsvbCbtng45dGIWyBWXqDrdom0Y34V/5NT1xf4Z8MXP9
 Ux8dCKsIyaqP/0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF9AB136A9;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKHGLMRsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:42 +0200
MIME-Version: 1.0
Message-Id: <20240722-cachestat-v3-3-a0386f7cdaaa@suse.com>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
In-Reply-To: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3337;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=K6xA0fn1iDZYMw0xNXuyJ3O4Zu5xvambteVvR9rSyHY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmyveIO8ZgjFsY1fXM168DzkavZhzLV03Xo6c
 EZVBxVTMyGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5srwAKCRDLzBqyILPm
 Rsy9DACKnvxmWHp0IlfZ68NdF1RFd12H0tscGlI0HehuIJZ0IOSxWERfBioE5rpGUAawL7LqJuY
 fnm+nEYo+Gz5JxW/+vIivuH4ZRutyaMUPsRuUrZfEC7W278Tu6m/aeuRKxSuULz+dLJRbZEmH4q
 NhqE+RdPGGXepWLEUviNqIqkY+zilx8nTl2iRG1LYZH/VTtBtn6rOz8/y/jPB0/5/KV/CyqJI/u
 Ab1IcaoFw+ZCEkM2RHk8bI4uRukfnNey0mZpoaau9ekbWJsNvV9u6aISZqewa01upYgPa0yGE4Z
 pblSwafjo1fFUW5HMpYmMZ5eCPDbgiEexBd5mjd7T4Xh8Xpr5L44aDdEUyQ3HMqVmYHtQ2TNhpe
 q11oMj1qjwwQXhKOFcNe8Am1dCFkerEBvPbr6Ef44ABqU93qFVF29arT3RTzkjVrGMp7rzYQDjP
 y3RfB7qHweN8bbkm4UwKzeoXDtuU9bWTRCrTtI/gZwvliy5dN/WVNgb8uhxk/50d0TE7I=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DCE1921BB0
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] Add cachestat02 test
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

This test verifies that cachestat() syscall is properly counting cached
pages written inside a shared memory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/cachestat/.gitignore    |  1 +
 testcases/kernel/syscalls/cachestat/cachestat02.c | 90 +++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ce974b317..294e3cebf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -63,6 +63,7 @@ capset04 capset04
 cacheflush01 cacheflush01
 
 cachestat01 cachestat01
+cachestat02 cachestat02
 
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
index daea1f4be..0f70fb801 100644
--- a/testcases/kernel/syscalls/cachestat/.gitignore
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -1 +1,2 @@
 cachestat01
+cachestat02
diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
new file mode 100644
index 000000000..deaaa6d32
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that cachestat() syscall is properly counting cached pages
+ * written inside a shared memory.
+ *
+ * [Algorithm]
+ *
+ * - create a shared memory with a specific amount of pages
+ * - monitor file with cachestat()
+ * - check if the right amount of pages have been moved into cache
+ */
+
+#include <stdlib.h>
+#include "cachestat.h"
+
+#define FILENAME "myfile.bin"
+
+static int page_size;
+static char *page_data;
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static void test_cached_pages(const int num_pages)
+{
+	int fd, file_size;
+
+	tst_res(TINFO, "Number of pages: %d", num_pages);
+
+	memset(cs, 0, sizeof(struct cachestat));
+
+	fd = shm_open(FILENAME, O_RDWR | O_CREAT, 0600);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "shm_open error");
+
+	file_size = page_size * num_pages;
+
+	cs_range->off = 0;
+	cs_range->len = file_size;
+
+	SAFE_FTRUNCATE(fd, file_size);
+	for (int i = 0; i < num_pages; i++)
+		SAFE_WRITE(0, fd, page_data, page_size);
+
+	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
+	print_cachestat(cs);
+
+	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, num_pages);
+
+	SAFE_CLOSE(fd);
+	shm_unlink(FILENAME);
+}
+
+static void run(void)
+{
+	for (int i = 0; i < 10; i++)
+		test_cached_pages(1 << i);
+}
+
+static void setup(void)
+{
+	page_size = (int)sysconf(_SC_PAGESIZE);
+
+	page_data = SAFE_MALLOC(page_size);
+	memset(page_data, 'a', page_size);
+}
+
+static void cleanup(void)
+{
+	if (page_data)
+		free(page_data);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "6.5",
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
