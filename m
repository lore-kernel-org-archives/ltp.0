Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A1606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qs7x5fl/;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZFPjv3AT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qs7x5fl/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZFPjv3AT
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55CEC3EA601
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:17:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06293E9E10
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21B5A1400B73
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80E301F7B4;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVyQAJ2XWdW/pyGwwi/RoDgOAuKZKVshoe9qX+d+IHU=;
 b=qs7x5fl/75JZ9/A71qqCh+Meo3KOOs3I/Pi1k56bGO5bRAcOr7rLThioWzw14RHhH/a+nA
 VJjTogSffzdQ93X8DaSQSGfp2pn8+4Ts64ccJ++7SOB2QJcllWmC6gizATsXO73L4fDKBX
 4XeLUT5UYcU3WX4hbz1r54WvQD8wpD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVyQAJ2XWdW/pyGwwi/RoDgOAuKZKVshoe9qX+d+IHU=;
 b=ZFPjv3ATnizFk+DcFvhmr9VYSPdtqGp5rICQdddHpa0wpSLNd36426V3TijricFOTJgKyz
 MWdRWbyuYssCf2Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qs7x5fl/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZFPjv3AT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVyQAJ2XWdW/pyGwwi/RoDgOAuKZKVshoe9qX+d+IHU=;
 b=qs7x5fl/75JZ9/A71qqCh+Meo3KOOs3I/Pi1k56bGO5bRAcOr7rLThioWzw14RHhH/a+nA
 VJjTogSffzdQ93X8DaSQSGfp2pn8+4Ts64ccJ++7SOB2QJcllWmC6gizATsXO73L4fDKBX
 4XeLUT5UYcU3WX4hbz1r54WvQD8wpD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVyQAJ2XWdW/pyGwwi/RoDgOAuKZKVshoe9qX+d+IHU=;
 b=ZFPjv3ATnizFk+DcFvhmr9VYSPdtqGp5rICQdddHpa0wpSLNd36426V3TijricFOTJgKyz
 MWdRWbyuYssCf2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E473B13872;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T9
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-8-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3562;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Sc6EnmXcJVL07u/2DfSGOgFo5HuTtqRSqReuW39TMXI=;
 b=UrxY6VvH/jHQNZBGfryKVUzUjZiPli31TVBAQ21mYFxa6wynVlQTly0CuTB8qSzizwbCIQXPb
 PctlD3gTbbmAEsNUFmlMZo+h+zk7f7Ya/obzlpeyvfUc7AczbxqQcvD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 80E301F7B4
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 08/14] fchroot07: test execve blocked by failfs root
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

Verify that after fchroot() moved the root into failfs, loading a
binary by absolute path fails with EOPNOTSUPP. The exec runs in a
grandchild so a wrongly successful exec is still detected through
the exit code.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore       |  2 +
 testcases/kernel/syscalls/fchroot/fchroot07.c      | 58 ++++++++++++++++++++++
 .../kernel/syscalls/fchroot/fchroot07_child.c      | 16 ++++++
 4 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8b688cbe2..bc2dffdca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -322,6 +322,7 @@ fchroot03 fchroot03
 fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
+fchroot07 fchroot07
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 12151270a..bfa2a8ce1 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -4,3 +4,5 @@ fchroot03
 fchroot04
 fchroot05
 fchroot06
+fchroot07
+fchroot07_child
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
new file mode 100644
index 000000000..0bd16890d
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`execve(2)` is blocked under the failfs root.
+ *
+ * After :manpage:`fchroot(2)` moved the process root into failfs, loading
+ * a binary by absolute path fails with ``EOPNOTSUPP``.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define CHILD_EXEC "fchroot07_child"
+
+static char child_path[PATH_MAX];
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	if (!SAFE_FORK()) {
+		TST_EXP_FAIL(execl(child_path, CHILD_EXEC, NULL), EOPNOTSUPP,
+			"absolute exec blocked by the failfs root");
+		return;
+	}
+
+	SAFE_WAIT(NULL);
+}
+
+static void setup(void)
+{
+	if (tst_get_path(CHILD_EXEC, child_path, sizeof(child_path)))
+		tst_brk(TCONF, "Couldn't find %s in $PATH", CHILD_EXEC);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+};
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07_child.c b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
new file mode 100644
index 000000000..3d731781c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+
+	tst_res(TFAIL, "child executed");
+
+	return 0;
+}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
