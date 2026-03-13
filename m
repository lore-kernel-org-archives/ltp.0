Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9F6105F79A
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:07:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A73B53E52A3
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:07:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 966D43C2AF4
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC38E600ADD
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 498474D3B3;
 Fri, 13 Mar 2026 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6O2i0T2Nv7JtIlJruYfMwQFjhfiek82h8ilBrMRbj8=;
 b=OmQnMTDOnet+7C1u+TWAmk4RKB/c9yMJ5afCXKZQNzJBd8yON3xN02zEw4w8JiHEKX39c7
 SPk6j3hFpXsx4RJqQeUnj+B7bLjMRMW8wdwIP4E7zTbHAOI+KK0439N+CNvOEDyddRHqgo
 3jldrdsHiki+fQnGkDyfklRAg0kSREg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6O2i0T2Nv7JtIlJruYfMwQFjhfiek82h8ilBrMRbj8=;
 b=+/aqASam1NdfwuHyUk+K6mX7yFCS9+/c2wOc2tw5szML97gVduNIrJmJfUgcZb4YwLrryO
 aELb+SqwEguz2KBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OmQnMTDO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+/aqASam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6O2i0T2Nv7JtIlJruYfMwQFjhfiek82h8ilBrMRbj8=;
 b=OmQnMTDOnet+7C1u+TWAmk4RKB/c9yMJ5afCXKZQNzJBd8yON3xN02zEw4w8JiHEKX39c7
 SPk6j3hFpXsx4RJqQeUnj+B7bLjMRMW8wdwIP4E7zTbHAOI+KK0439N+CNvOEDyddRHqgo
 3jldrdsHiki+fQnGkDyfklRAg0kSREg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6O2i0T2Nv7JtIlJruYfMwQFjhfiek82h8ilBrMRbj8=;
 b=+/aqASam1NdfwuHyUk+K6mX7yFCS9+/c2wOc2tw5szML97gVduNIrJmJfUgcZb4YwLrryO
 aELb+SqwEguz2KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E580404BD;
 Fri, 13 Mar 2026 11:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KWNCfLvs2ndbAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:07:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:07:31 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v1-5-04ef0081a377@suse.com>
References: <20260313-listns-v1-0-04ef0081a377@suse.com>
In-Reply-To: <20260313-listns-v1-0-04ef0081a377@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773400049; l=3775;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=VlKdHFBTVfH66L80giEXtHN60X4cTHf9GZIq1tfjeRY=;
 b=xo0i75Ps6GI6eGet8ofSHHWgnOCBCyTUut3sqWtbFNzjN6tXQq7RFcMQ6co8w3CnKc6d64BRQ
 Hp6wph1MLkqB+yADjEqTBumH39Vxr6aJVhYrT6C9NP7R+jxTnGAk2mA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 498474D3B3
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] syscalls: add basic listns02 functionality test
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
 testcases/kernel/syscalls/listns/.gitignore |   1 +
 testcases/kernel/syscalls/listns/listns02.c | 121 ++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/testcases/kernel/syscalls/listns/.gitignore b/testcases/kernel/syscalls/listns/.gitignore
index 396d6b6fbfb3e34f17c79bfa3d5cc60f76477584..26d31ae372c54e0031a71b56f68cad44f32e5962 100644
--- a/testcases/kernel/syscalls/listns/.gitignore
+++ b/testcases/kernel/syscalls/listns/.gitignore
@@ -1 +1,2 @@
 listns01
+listns02
diff --git a/testcases/kernel/syscalls/listns/listns02.c b/testcases/kernel/syscalls/listns/listns02.c
new file mode 100644
index 0000000000000000000000000000000000000000..5bb5e4c189e034f0722b94e67925c5777b830cd4
--- /dev/null
+++ b/testcases/kernel/syscalls/listns/listns02.c
@@ -0,0 +1,121 @@
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
+	SAFE_WAITPID(child_pid, NULL, 0);
+	child_pid = -1;
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
+static void cleanup(void)
+{
+	if (child_pid > 0) {
+		SAFE_KILL(child_pid, SIGKILL);
+		SAFE_WAITPID(child_pid, NULL, 0);
+		child_pid = -1;
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_listns,
+	.setup = setup,
+	.cleanup = cleanup,
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
