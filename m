Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EFAC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 12:16:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 492F53C9F3F
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 13:16:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E27953C93A9
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 13:16:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41108140163B
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 13:16:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 505AF1F383;
 Thu, 17 Feb 2022 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645100161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CoCRu4jHnDrQ6xq0vND1zJx5DGVHrN5R/igdb/I/w9A=;
 b=EpHDoJscG/coGzTiHBlHyREXJ5NkMVmu5HMJRgY7+O6RbR6itWm2rjOkby+KVUbsNieCTE
 qf+pgc3Syz7gSZWh9pxbigMG3W520wXbYvjasaAYNlgcCoWg0yT+8FRiMcW5r4BrtfkyT7
 nT1SIvHiz7HvF6LGfrBAc/sYQKYs31s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645100161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CoCRu4jHnDrQ6xq0vND1zJx5DGVHrN5R/igdb/I/w9A=;
 b=Zwfzsx5Vpm2Q9NFA1TkpGhYs3c/BVwBLMEJE57UqL/OgkF8yVT4fyDXU0PnurTeeRn78Qt
 /RcdXA+bvOnqhtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CFE513BE2;
 Thu, 17 Feb 2022 12:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9YXvDYE8DmJhdQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 17 Feb 2022 12:16:01 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	ltp@lists.linux.it
Date: Thu, 17 Feb 2022 13:16:00 +0100
Message-Id: <20220217121600.3002-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add test for CVE 2021-22600
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

Fixes #917

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

On a vulnerable system, the test will get stuck in the last setsockopt() call
and become unkillable. Reproducer works reliably on affected SLE kernels.

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/setsockopt/.gitignore     |   1 +
 .../kernel/syscalls/setsockopt/setsockopt09.c | 111 ++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ce6f89f88..6c88454cc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1391,6 +1391,7 @@ setsockopt05 setsockopt05
 setsockopt06 setsockopt06
 setsockopt07 setsockopt07
 setsockopt08 setsockopt08
+setsockopt09 setsockopt09
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index 95a5e43f8..fd3235bb3 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -6,3 +6,4 @@
 /setsockopt06
 /setsockopt07
 /setsockopt08
+/setsockopt09
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
new file mode 100644
index 000000000..2b8dc5171
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC
+ * Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2021-22600
+ *
+ * Check for possible double free of rx_owner_map after switching packet
+ * interface versions. Kernel crash fixed in:
+ *
+ *  commit ec6af094ea28f0f2dda1a6a33b14cd57e36a9755
+ *  Author: Willem de Bruijn <willemb@google.com>
+ *  Date:   Wed Dec 15 09:39:37 2021 -0500
+ *
+ *  net/packet: rx_owner_map depends on pg_vec
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sched.h>
+
+#include "tst_test.h"
+#include "lapi/if_packet.h"
+
+static int sock = -1;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+}
+
+static void run(void)
+{
+	unsigned int version = TPACKET_V3;
+	struct tpacket_req3 req = {
+		.tp_block_size = 16384,
+		.tp_block_nr = 256,
+		.tp_frame_size = TPACKET_ALIGNMENT << 7,
+		.tp_retire_blk_tov = 64,
+		.tp_feature_req_word = TP_FT_REQ_FILL_RXHASH
+	};
+
+	req.tp_frame_nr = req.tp_block_size * req.tp_block_nr;
+	req.tp_frame_nr /= req.tp_frame_size;
+
+	sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, 0);
+	TEST(setsockopt(sock, SOL_PACKET, PACKET_VERSION, &version,
+		sizeof(version)));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL)
+		tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"setsockopt(PACKET_VERSION, TPACKET_V3");
+	}
+
+	/* Allocate owner map and then free it again */
+	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
+	req.tp_block_nr = 0;
+	req.tp_frame_nr = 0;
+	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
+
+	/* Switch interface version and trigger double free of owner map */
+	SAFE_SETSOCKOPT_INT(sock, SOL_PACKET, PACKET_VERSION, TPACKET_V2);
+	SAFE_SETSOCKOPT(sock, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static void cleanup(void)
+{
+	if (sock >= 0)
+		SAFE_CLOSE(sock);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.timeout = 5,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ec6af094ea28"},
+		{"CVE", "2021-22600"},
+		{}
+	}
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
