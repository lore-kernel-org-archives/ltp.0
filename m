Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF3BC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C14A3C701B
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:42:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DAC33C701B
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D45510009AB
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA29786C50
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0agTdib7d5KUbwrDXXE+GpyPF+VxFTe1cWz0dPUK5E=;
 b=UT8/bwYIGcvMeXxy3JQnjzclbBImsYZpf3r4EPFah/D4c1dROo3ZpURYj49U3vyStXz8yS
 ZqKB8qOSeZcCEMexFvrPRRetYL8ZSh8QvhK/dDYA4C3nvZorZCzUFU9+ZT4RKQ6WW9j6wJ
 9C9BhbRjfX9R0gfdNDSj28mytOiI30c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0agTdib7d5KUbwrDXXE+GpyPF+VxFTe1cWz0dPUK5E=;
 b=PbLaR7tRb9uo3lsrRymFGP4SEMmr72dIb0bvH6zF8/ptPvsqMpVL/66wM01+UOdVngDt5G
 nIFPhxcA49EX9YAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0agTdib7d5KUbwrDXXE+GpyPF+VxFTe1cWz0dPUK5E=;
 b=EI8TOIsGek7hOVnSLilz5iDk+HCKv3fStFBHF5d80v4zBDZspFuSCIJWZwfeC2wfCLX8Nr
 O0dF+4G2KU8OXnfXMSLESVkaw6Ipm4u3Pel7QfYrXmYP+Zl0YGbOJ/E14jE7+iPS17jFoa
 EhPAiU6m633L84BtqTUz1+iadTd2kBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0agTdib7d5KUbwrDXXE+GpyPF+VxFTe1cWz0dPUK5E=;
 b=NunQwFfZBSsOIM01d/s8ZjSD/JD0WnJQNh8QtxxXbCzBc+wxaaH00evDUDu+iqatoVd9g9
 1vBHeeoOGUwcsuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B0913411
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SUdYMEd+jWq9SAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:16 +0200
Message-ID: <20260825113625.1624134-23-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 22/31] testcases: sysfs: Add sys_net03
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

A test for /sys/class/net/*/* files.

Similar to sys_net02 but checks bridge related files after briding a
virtual ethernet interface.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/net/.gitignore  |   1 +
 testcases/kernel/sysfs/class/net/sys_net03.c | 144 +++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net03.c

diff --git a/runtest/sysfs b/runtest/sysfs
index fee8a0b2b..b2cc0005c 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -17,3 +17,4 @@ sys_rtc01 sys_rtc01
 sys_thermal01 sys_thermal01
 sys_net01 sys_net01
 sys_net02 sys_net02
+sys_net03 sys_net03
diff --git a/testcases/kernel/sysfs/class/net/.gitignore b/testcases/kernel/sysfs/class/net/.gitignore
index b70d02158..8c3782a3b 100644
--- a/testcases/kernel/sysfs/class/net/.gitignore
+++ b/testcases/kernel/sysfs/class/net/.gitignore
@@ -1,2 +1,3 @@
 /sys_net01
 /sys_net02
+/sys_net03
diff --git a/testcases/kernel/sysfs/class/net/sys_net03.c b/testcases/kernel/sysfs/class/net/sys_net03.c
new file mode 100644
index 000000000..fcc5c5451
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net03.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verifies that bridge port sysfs attributes correctly appear, hold sane
+ * values, and disappear again as a network device is enslaved to and
+ * released from a bridge.
+ *
+ * The test creates a bridge and a veth pair, then:
+ *
+ * - verifies /sys/class/net/<bridge>/brif/ is empty and
+ *   /sys/class/net/<port>/brport does not exist before enslaving
+ * - enslaves one end of the veth pair to the bridge
+ * - verifies /sys/class/net/<bridge>/brif/<port> appears and
+ *   /sys/class/net/<port>/brport/{state,priority,path_cost} hold sane values
+ * - verifies /sys/class/net/<bridge>/bridge/{stp_state,forward_delay} hold
+ *   sane values
+ * - releases the port from the bridge
+ * - verifies /sys/class/net/<bridge>/brif/ is empty and
+ *   /sys/class/net/<port>/brport does not exist again
+ *
+ * This needs root to create the bridge and veth devices.
+ */
+
+#include <limits.h>
+#include <string.h>
+#include <dirent.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_netdevice.h"
+#include "tst_sysfs_assert.h"
+
+#define BRNAME "ltp_br0"
+#define IFNAME1 "ltp_vethb1"
+#define IFNAME2 "ltp_vethb2"
+
+#define BR_PATH "/sys/class/net/" BRNAME
+#define PORT_PATH "/sys/class/net/" IFNAME1
+
+static int bridge_created;
+static int veth_created;
+
+static int count_dir_entries(const char *path)
+{
+	DIR *d;
+	struct dirent *ent;
+	int count = 0;
+
+	d = SAFE_OPENDIR(path);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		count++;
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	return count;
+}
+
+static void setup(void)
+{
+	NETDEV_ADD_DEVICE(BRNAME, "bridge");
+	bridge_created = 1;
+
+	CREATE_VETH_PAIR(IFNAME1, IFNAME2);
+	veth_created = 1;
+
+	NETDEV_SET_STATE(BRNAME, 1);
+	NETDEV_SET_STATE(IFNAME1, 1);
+	NETDEV_SET_STATE(IFNAME2, 1);
+}
+
+static void check_not_enslaved(const char *desc)
+{
+	int nports = count_dir_entries(BR_PATH "/brif");
+
+	tst_res(TINFO, "%s", desc);
+
+	TST_EXP_EQ_LI(nports, 0);
+
+	if (access(PORT_PATH "/brport", F_OK))
+		tst_res(TPASS, PORT_PATH "/brport does not exist");
+	else
+		tst_res(TFAIL, PORT_PATH "/brport unexpectedly exists");
+}
+
+static void check_enslaved(void)
+{
+	int nports = count_dir_entries(BR_PATH "/brif");
+
+	tst_res(TINFO, "port enslaved to bridge");
+
+	TST_EXP_EQ_LI(nports, 1);
+
+	if (!access(BR_PATH "/brif/" IFNAME1, F_OK))
+		tst_res(TPASS, BR_PATH "/brif/" IFNAME1 " exists");
+	else
+		tst_res(TFAIL, BR_PATH "/brif/" IFNAME1 " does not exist");
+
+	TST_SYSFS_ASSERT_RANGELL(0, 4, PORT_PATH "/brport/state");
+	TST_SYSFS_ASSERT_RANGELL(0, 255, PORT_PATH "/brport/priority");
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, PORT_PATH "/brport/path_cost");
+
+	TST_SYSFS_ASSERT_RANGELL(0, 2, BR_PATH "/bridge/stp_state");
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, BR_PATH "/bridge/forward_delay");
+}
+
+static void run(void)
+{
+	check_not_enslaved("before enslaving");
+
+	NETDEV_SET_MASTER(IFNAME1, BRNAME);
+	check_enslaved();
+
+	NETDEV_SET_MASTER(IFNAME1, NULL);
+	check_not_enslaved("after releasing");
+}
+
+static void cleanup(void)
+{
+	if (veth_created)
+		NETDEV_REMOVE_DEVICE(IFNAME1);
+
+	if (bridge_created)
+		NETDEV_REMOVE_DEVICE(BRNAME);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_VETH",
+		"CONFIG_BRIDGE",
+		NULL
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
