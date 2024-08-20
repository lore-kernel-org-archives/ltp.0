Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55D1C3DA4A
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 12:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027DE3CE321
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 14:09:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23F5F3C01D3
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 14:09:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4DC6C1401256
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 14:09:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 425A021CB3;
 Tue, 20 Aug 2024 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724155773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tzpBx2bkp4Ekq0KSdoBy0fQJ4iawZRGBRdM1XwcPZ8=;
 b=k59uTt5T4d/row269k8AXm/4W/OltBlL4S9DhEkrWwaJZGpl4SfcNe40aw4yMhNEirzILf
 6xoBwjSVUPR8jCW/XEwWmUSg6c+ONefcs8/7rlGT/21xyPTGL95IOAydlwlK5+6KfwOMSy
 yGmd6yjCWEpf9gtMc1JVGSvK87XaRNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724155773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tzpBx2bkp4Ekq0KSdoBy0fQJ4iawZRGBRdM1XwcPZ8=;
 b=uZ/YT/Gk4sC1Z1gsbKXAGyHUq8bxmhKUb7MFDEHwbu7xlMNdEMG1vthxJz74DtN6DbN9mD
 XFCRqMtCxgq9JiBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k59uTt5T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uZ/YT/Gk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724155773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tzpBx2bkp4Ekq0KSdoBy0fQJ4iawZRGBRdM1XwcPZ8=;
 b=k59uTt5T4d/row269k8AXm/4W/OltBlL4S9DhEkrWwaJZGpl4SfcNe40aw4yMhNEirzILf
 6xoBwjSVUPR8jCW/XEwWmUSg6c+ONefcs8/7rlGT/21xyPTGL95IOAydlwlK5+6KfwOMSy
 yGmd6yjCWEpf9gtMc1JVGSvK87XaRNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724155773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tzpBx2bkp4Ekq0KSdoBy0fQJ4iawZRGBRdM1XwcPZ8=;
 b=uZ/YT/Gk4sC1Z1gsbKXAGyHUq8bxmhKUb7MFDEHwbu7xlMNdEMG1vthxJz74DtN6DbN9mD
 XFCRqMtCxgq9JiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25AF913A17;
 Tue, 20 Aug 2024 12:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TIxBB32HxGYYdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Aug 2024 12:09:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Aug 2024 14:09:31 +0200
MIME-Version: 1.0
Message-Id: <20240820-landlock_houdini-v1-1-ff3bffc93eaa@suse.com>
X-B4-Tracking: v=1; b=H4sIAHqHxGYC/x3MQQqAIBBA0avErBNsMpKuEhGhYw2JhlIE0d2Tl
 m/x/wOZElOGoXog0cWZYyho6grMtoSVBNtiQIlKapTCL8H6aPZ5i6flwMKhUq5D0r1poWRHIsf
 3vxyn9/0AtIzy/2IAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724155773; l=4162;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Sp6JuoCjirNObeMBOEkLoHtr14GjMjuOavQCh4+Yhjg=;
 b=+aBAM8Msh2B+Rucwyg8/HrVI+701IvK8iVqh18R9yzIReyOGnRhc+7BWVtYOh7fD+EDuZM7ZR
 Tony60zO9ymAJgh8nuyA5xfsPNhwu2V2ZyMEAWfKgoTBLull8oU8MkV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 425A021CB3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add landlock07 test
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
More information at:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock07.c | 114 ++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

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
index 000000000..f82442329
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -0,0 +1,114 @@
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
+#include "lapi/landlock.h"
+#include "tst_test_macros.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static int ruleset_fd;
+
+static void create_keyring(const int operation)
+{
+	TEST(keyctl(operation, NULL, 0, 0, 0));
+	if (TST_RET == -1)
+		tst_brk(TERRNO | TBROK, "keyctl() failed");
+}
+
+static pid_t spawn_houdini(void)
+{
+	pid_t pid;
+
+	create_keyring(KEYCTL_JOIN_SESSION_KEYRING);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		create_keyring(KEYCTL_JOIN_SESSION_KEYRING);
+		create_keyring(KEYCTL_SESSION_TO_PARENT);
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

---
base-commit: c02d8ddc5f9d312ca5c384317141e213412a5c42
change-id: 20240820-landlock_houdini-f244f52e87c3

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
