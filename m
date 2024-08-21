Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EC9C52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 13:49:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C3FE3D226B
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 15:49:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A81A3D115D
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 24C3310006AB
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 885DF1FB45
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvV+SYu2k+BZ1RMqyryMLk6uEeoXr7IIvCTYrWybpSE=;
 b=v/sZ5AE6dPDiz6k5ueDCQIiVI/RC2OJu7DikPhJuVPetZkOzBRiJzw7drtRet/Wf4OE+f4
 kK0biEnc1oZuJ2r2fzdfcGjhNPwi3RNfNfSEqjvxdfi6L05xQa8t9tX1faPc2q7iV6YR9H
 /ld4hU5b4NSaL2Mkv4BsEsdFampVBCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvV+SYu2k+BZ1RMqyryMLk6uEeoXr7IIvCTYrWybpSE=;
 b=yB9gbZ8Mh+4pEvroKzBMATs5NsIFFMZcalgdVm0FBes3QSY9j1dvRXzJHZz7J8m3g/M7yR
 KmWXwpp1tejoSIBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="v/sZ5AE6";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yB9gbZ8M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvV+SYu2k+BZ1RMqyryMLk6uEeoXr7IIvCTYrWybpSE=;
 b=v/sZ5AE6dPDiz6k5ueDCQIiVI/RC2OJu7DikPhJuVPetZkOzBRiJzw7drtRet/Wf4OE+f4
 kK0biEnc1oZuJ2r2fzdfcGjhNPwi3RNfNfSEqjvxdfi6L05xQa8t9tX1faPc2q7iV6YR9H
 /ld4hU5b4NSaL2Mkv4BsEsdFampVBCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvV+SYu2k+BZ1RMqyryMLk6uEeoXr7IIvCTYrWybpSE=;
 b=yB9gbZ8Mh+4pEvroKzBMATs5NsIFFMZcalgdVm0FBes3QSY9j1dvRXzJHZz7J8m3g/M7yR
 KmWXwpp1tejoSIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7036713B1E
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CNR4GWPwxWbeKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Aug 2024 15:49:14 +0200
MIME-Version: 1.0
Message-Id: <20240821-landlock_houdini-v3-2-15fc43055d02@suse.com>
References: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
In-Reply-To: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724248163; l=3797;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QKMhGicsSkl4w+IZDfpOx3+KhtDKhEyRSvDAMhX3NMI=;
 b=wF3ZHPVpKN87TjHvsLkp0GWoK2iA7KhlRqYEU0d7xP+ZcOqQl7xhLg0ik8lvQDoKDRH+C/2T4
 7+vhpv6hgFYAa9kScmFAfuo1eicYXecClRWNKtsKkUbuQk1dqFLo3fD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 885DF1FB45
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add landlock07 test
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

This test is a reproducer for the CVE-2024-42318 bug, also known as
landlock Houdini.

More information at:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock07.c | 109 ++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fea0c9828..a9fc8c432 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -706,6 +706,7 @@ landlock03 landlock03
 landlock04 landlock04
 landlock05 landlock05
 landlock06 landlock06
+landlock07 landlock07
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index 315ac1dca..db11bff2f 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -5,3 +5,4 @@ landlock03
 landlock04
 landlock05
 landlock06
+landlock07
diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
new file mode 100644
index 000000000..68045da3b
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/**
+ * [Description]
+ *
+ * CVE-2024-42318
+ *
+ * Test to check if sysem is affected by Landlock Houdini bug:
+ * https://www.suse.com/security/cve/CVE-2024-42318.html
+ *
+ * Kernel bug fixed in:
+ *
+ *  commit 39705a6c29f8a2b93cf5b99528a55366c50014d1
+ *  Author: Jann Horn <jannh@google.com>
+ *  Date:   Wed Jul 24 14:49:01 2024 +0200
+ *
+ *  landlock: Don't lose track of restrictions on cred_transfer
+ */
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+#include "lapi/keyctl.h"
+#include "tst_test_macros.h"
+#include "landlock_common.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static int ruleset_fd;
+
+static pid_t spawn_houdini(void)
+{
+	pid_t pid;
+
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+		SAFE_KEYCTL(KEYCTL_SESSION_TO_PARENT, 0, 0, 0, 0);
+		exit(0);
+	}
+
+	return pid;
+}
+
+static void run(void)
+{
+	pid_t pid_houdini;
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
+
+	TST_EXP_FAIL(open("/dev/null", O_WRONLY), EACCES);
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		return;
+	}
+
+	pid_houdini = spawn_houdini();
+	SAFE_WAITPID(pid_houdini, NULL, 0);
+
+	TST_EXP_FAIL(open("/dev/null", O_WRONLY), EACCES);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	verify_landlock_is_enabled();
+
+	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE;
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr,
+		sizeof(struct landlock_ruleset_attr),
+		0);
+}
+
+static void cleanup(void)
+{
+	if (ruleset_fd != -1)
+		SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "39705a6c29f8"},
+		{"CVE", "2024-42318"},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
