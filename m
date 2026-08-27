Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B01C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:28:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 093193D9495
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:28:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1FD3D9493
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0E62600798
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F27B211AB
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhyWHG/ni8m10ZVq2Yj5yiQ5SnTq8p68paL+6ijAVwg=;
 b=H7R43wZC+rv8mTKJQ3IfcjRyDaoKCaI6pAcvAsB6ojg8x8doziEP6xBvOs0cyby3kAQTOz
 K/iQBs4nIge3ZUtXBqeRvB5BqPUahOnAfbxmdjPrnIgyYkAO9+7CrO0IuDVAQyCgCR4IMH
 kqbja+Zrlj015ECHg0Cp9poQFHU3vmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhyWHG/ni8m10ZVq2Yj5yiQ5SnTq8p68paL+6ijAVwg=;
 b=S3qLpucvfWmAcFNbt3YWo9UmGX51/zNYj0lfrycLai5XkMkYjITVJU8JIgnwF5OKMJ1Vs7
 ij8AyMWl/0BrcKAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhyWHG/ni8m10ZVq2Yj5yiQ5SnTq8p68paL+6ijAVwg=;
 b=Jb0pyjrsna8G1nMjPg4U8G+VVXHkT7ZbAJEnYN6Gvy2hlITz5yC+n3Wbt/6/NHT/Y01uZZ
 TexeIDua7Vpp8+w4xvXmgeq5MvKGWNd1WL+ujBl5tyydNetlh06pRgvTGHxSiC2FbwaMdO
 VtvmzDPcqVyYlGS/RLwgyXuPwhhFmDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhyWHG/ni8m10ZVq2Yj5yiQ5SnTq8p68paL+6ijAVwg=;
 b=SsbaArOdTimbcvzxksSxCg/zLrYggB2IATjejRF40qfcAgdIeeZKw8hAjo0W2cxtIT04yy
 Ra8TLBVoBlY0OWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADCE13685
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vSfgHPIdkGqbawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:48 +0200
Message-ID: <20260827112157.1748734-23-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 22/31] testcases: sysfs: Add sys_net03
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
 testcases/kernel/sysfs/class/net/sys_net03.c | 145 +++++++++++++++++++
 3 files changed, 147 insertions(+)
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
index 000000000..eb8c484f4
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net03.c
@@ -0,0 +1,145 @@
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
+#include "tst_path_defs.h"
+
+#define BRNAME "ltp_br0"
+#define IFNAME1 "ltp_vethb1"
+#define IFNAME2 "ltp_vethb2"
+
+#define BR_PATH PATH_CLASS_NET "/" BRNAME
+#define PORT_PATH PATH_CLASS_NET "/" IFNAME1
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
+	d = TST_SYSFS_TRY_OPENDIR(path);
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
