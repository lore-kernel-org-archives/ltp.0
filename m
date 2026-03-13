Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C00105F78C
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E2873E48FF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:50:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4DCB3E4934
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06600600271
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65F2B4D3D5;
 Fri, 13 Mar 2026 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6mtZrXJKKkow9nMhwoaNLDT3ocqE1yeK2OlX3vNq1o=;
 b=w5ZwcpNQjZVFNejBNkvfvoHz4ITuKLimWERq5z3MLiuuYFXZ+CZ1DwYz/fBLKsuP6ru73y
 pVjgociA3AzEJ4bkdHngk7XbsbSp1svzBr/7wsL171UrIj37jV347KtUSvpWjXeHYPO+u8
 cX5KPD7TGU3zNdfZ3q0n3uNjZda+XfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6mtZrXJKKkow9nMhwoaNLDT3ocqE1yeK2OlX3vNq1o=;
 b=bzGGY8E85jOa1LEqI5NzBnqIKsmfUWn6cJCGL9u2lFUs1HqmO0xv4ebVftOan8pF6u/Pb8
 OgIOikX7EORInbDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6mtZrXJKKkow9nMhwoaNLDT3ocqE1yeK2OlX3vNq1o=;
 b=w5ZwcpNQjZVFNejBNkvfvoHz4ITuKLimWERq5z3MLiuuYFXZ+CZ1DwYz/fBLKsuP6ru73y
 pVjgociA3AzEJ4bkdHngk7XbsbSp1svzBr/7wsL171UrIj37jV347KtUSvpWjXeHYPO+u8
 cX5KPD7TGU3zNdfZ3q0n3uNjZda+XfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6mtZrXJKKkow9nMhwoaNLDT3ocqE1yeK2OlX3vNq1o=;
 b=bzGGY8E85jOa1LEqI5NzBnqIKsmfUWn6cJCGL9u2lFUs1HqmO0xv4ebVftOan8pF6u/Pb8
 OgIOikX7EORInbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8F2404E6;
 Fri, 13 Mar 2026 11:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sHl6EIX5s2lZGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:48:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:48:23 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v2-5-38384fae9b1f@suse.com>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
In-Reply-To: <20260313-listns-v2-0-38384fae9b1f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773402500; l=3953;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bXakJk9Q8eiN/rOisZr5zEGTsCg62pP5Q8uT3/fPSHQ=;
 b=+kA1f1Q02AuRCxO4hYt1eFoQEF/Qb+VRjmVVbnHBuVmkzXXR5WZ4wJkMZuA9pJf2Cd7prQroX
 qnNGlce9g7mBkfh9KOf+TMlBog35tF+QCT1MotYv6dGEzrQvTXHUgp7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] syscalls: add listns02 functionality test
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

Add a simple test that create a namespace and verifies that listns02 is
listing it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/listns/.gitignore |   1 +
 testcases/kernel/syscalls/listns/listns02.c | 109 ++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 769ce4a89a325ea09fdf2cfd42576697f23352c4..7d67f6ed2489e7281a07ae9f059b7485dd5f5f44 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -760,6 +760,7 @@ listmount03 listmount03
 listmount04 listmount04
 
 listns01 listns01
+listns02 listns02
 
 listxattr01 listxattr01
 listxattr02 listxattr02
diff --git a/testcases/kernel/syscalls/listns/.gitignore b/testcases/kernel/syscalls/listns/.gitignore
index 396d6b6fbfb3e34f17c79bfa3d5cc60f76477584..26d31ae372c54e0031a71b56f68cad44f32e5962 100644
--- a/testcases/kernel/syscalls/listns/.gitignore
+++ b/testcases/kernel/syscalls/listns/.gitignore
@@ -1 +1,2 @@
 listns01
+listns02
diff --git a/testcases/kernel/syscalls/listns/listns02.c b/testcases/kernel/syscalls/listns/listns02.c
new file mode 100644
index 0000000000000000000000000000000000000000..8afe70ff952d0a49c9f32186485fc4ee7549c346
--- /dev/null
+++ b/testcases/kernel/syscalls/listns/listns02.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Basic listns() functionality test.
+ *
+ * [Algorithm]
+ *
+ * - Fork a child into a new namespace.
+ * - Read the child's namespace ID via NS_GET_ID ioctl on /proc/<pid>/ns/<type>.
+ * - Call listns() filtered by that namespace type.
+ * - Verify the child's namespace ID appears in the returned list.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/ioctl_ns.h"
+#include "lapi/listns.h"
+
+#define NS_BUF_SIZE 256
+
+static pid_t child_pid = -1;
+static struct listns_req *req;
+
+static struct tcase {
+	const char *desc;
+	int clone_flag;
+	const char *ns_proc_name;
+} tcases[] = {
+	{ "mount namespace", CLONE_NEWNS,  "mnt" },
+	{ "UTS namespace",   CLONE_NEWUTS, "uts" },
+};
+
+static void verify_listns(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	char ns_path[64];
+	uint64_t ns_id;
+	uint64_t buf[NS_BUF_SIZE];
+	int fd, found;
+
+	req->size = NS_ID_REQ_SIZE_VER0;
+	req->ns_type = tc->clone_flag;
+
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		TST_CHECKPOINT_WAIT(0);
+		SAFE_UNSHARE(tc->clone_flag);
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	snprintf(ns_path, sizeof(ns_path), "/proc/%d/ns/%s",
+		 child_pid, tc->ns_proc_name);
+
+	fd = SAFE_OPEN(ns_path, O_RDONLY);
+	SAFE_IOCTL(fd, NS_GET_ID, &ns_id);
+	SAFE_CLOSE(fd);
+
+	TEST(listns(req, buf, ARRAY_SIZE(buf), 0));
+
+	TST_CHECKPOINT_WAKE(0);
+
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO, "listns() failed for %s", tc->desc);
+		return;
+	}
+
+	found = 0;
+	for (int i = 0; i < TST_RET; i++) {
+		tst_res(TDEBUG, "buf[%d] = %lu", i, buf[i]);
+		if (buf[i] == ns_id) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found)
+		tst_res(TFAIL, "listns() did not return the created %s (ns_id=%lu)",
+			tc->desc, (unsigned long)ns_id);
+	else
+		tst_res(TPASS, "listns() correctly listed the created %s",
+			tc->desc);
+}
+
+static void setup(void)
+{
+	struct listns_req req = { .size = NS_ID_REQ_SIZE_VER0 };
+
+	tst_syscall(__NR_listns, &req, NULL, 0, 0);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_listns,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&req, .size = sizeof(*req)},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
