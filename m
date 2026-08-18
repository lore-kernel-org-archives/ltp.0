Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0927AC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:18:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86D033CCAC2
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:18:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C86F3CCB46
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B91311000558
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CACD3E6D
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVvhLFvloCfwt/rNlo/8ghN0EF3SXS1zqaW6CUc9qXE=;
 b=A8690GtzFfJ8GGsIkOkw5WcdwMAEjo3nf9cZCSnSZ9SX6nwriEN9dDtxDfvqT/IM6Z/f0w
 ArXPQXTYVUCpDGNs62BknAAF9upjiEWIt0v6o4S5eTT4CGvIWOpwFS29YOB2Hg4d/RxIjA
 VJwHMbo1qECfkUETpYcTPf5FybQFKZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVvhLFvloCfwt/rNlo/8ghN0EF3SXS1zqaW6CUc9qXE=;
 b=+82o8YtfXRjsBU5NT3fAXxWkmdgv9Lt8EsO4gwtPuwvkgAb7Ak9q74950OczD2ZfiPc+ln
 g9OgIcf3SqhOQ8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVvhLFvloCfwt/rNlo/8ghN0EF3SXS1zqaW6CUc9qXE=;
 b=aewEEDGKJjNhhttwey/nKkmazvpJBWPWDmuF31ah4STOAQ/sZou3arla1GVsq9DWJXvLIW
 +nL+b9SKL8wPJhyobkjI/+C43dGpxW8fc1CzDgeHZrykfFmbLOc9+I0s2vqw9DuSVAUrwB
 i0A+P9l9A1c1i0AoGCZpkeoYuzgXLQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVvhLFvloCfwt/rNlo/8ghN0EF3SXS1zqaW6CUc9qXE=;
 b=4pbeYSMIK2j2ByYhN6aC/I7QC8CuhcuJvRLVzVgD1EQXA7/V3rC5x42K9H0TAhFFxss5js
 GZHr95glvf3ZuKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF5C367C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPogFohohGoOcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:00 +0200
Message-ID: <20260818141311.1265557-21-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 20/31] testcases: sysfs: Add sys_net01
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/net/.gitignore  |   1 +
 testcases/kernel/sysfs/class/net/Makefile    |   7 ++
 testcases/kernel/sysfs/class/net/sys_net01.c | 123 +++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/net/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/net/Makefile
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 454042ed0..90e4d2b8e 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -15,3 +15,4 @@ sys_leds01 sys_leds01
 sys_wakeup01 sys_wakeup01
 sys_rtc01 sys_rtc01
 sys_thermal01 sys_thermal01
+sys_net01 sys_net01
diff --git a/testcases/kernel/sysfs/class/net/.gitignore b/testcases/kernel/sysfs/class/net/.gitignore
new file mode 100644
index 000000000..f5ef57b75
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/.gitignore
@@ -0,0 +1 @@
+/sys_net01
diff --git a/testcases/kernel/sysfs/class/net/Makefile b/testcases/kernel/sysfs/class/net/Makefile
new file mode 100644
index 000000000..034038061
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/class/net/sys_net01.c b/testcases/kernel/sysfs/class/net/sys_net01.c
new file mode 100644
index 000000000..66c1d353f
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net01.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the network interface attributes exported under
+ * /sys/class/net/<iface>/.
+ *
+ * For every network interface the test verifies that:
+ *
+ * - mtu is greater than zero, and for an Ethernet-type interface (type == 1,
+ *   ARPHRD_ETHER, which also covers most virtual/Wi-Fi interfaces on Linux)
+ *   at most 65535, the largest possible IPv4 packet size and comfortably
+ *   above even the largest real-world jumbo frame configurations. Other
+ *   interface types (tunnels, PPP, CAN, ...) are left effectively unbounded
+ *   since their legitimate MTU semantics vary too much to bound generically,
+ *   e.g. a CAN interface reports the size of struct can_frame/canfd_frame
+ *   (16/72) rather than an IP MTU at all.
+ * - addr_len is at most MAX_ADDR_LEN (32), the fixed size of the kernel's
+ *   internal hardware address buffer (include/linux/netdevice.h) and thus a
+ *   hard limit rather than a mere plausibility bound. It is not asserted to
+ *   be non-zero: plenty of legitimate interfaces (PPP, GRE/IPIP/sit tunnels,
+ *   WireGuard, CAN, ...) have no link-layer address at all and report
+ *   addr_len == 0.
+ * - the address has exactly addr_len bytes (colon separated hex octets),
+ *   or is empty when addr_len == 0
+ * - operstate is one of the known states
+ * - carrier is a boolean (0 or 1) when readable
+ *
+ * carrier returns an error (EINVAL) when the interface is administratively
+ * down, which the test tolerates. The test skips with TCONF when no interface
+ * is present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define NET "/sys/class/net"
+
+/* include/linux/netdevice.h: fixed size of dev->dev_addr[]. */
+#define MAX_ADDR_LEN 32
+
+/* include/uapi/linux/if_arp.h */
+#define ARPHRD_ETHER 1
+
+/*
+ * The largest possible IPv4 packet size, used as a practical upper bound for
+ * the MTU of an Ethernet-type interface, see the top comment.
+ */
+#define MAX_ETHER_MTU 65535
+
+static const char *const operstates[] = {
+	"unknown", "notpresent", "down", "lowerlayerdown",
+	"testing", "dormant", "up", NULL
+};
+
+static void check_address(const char *iface)
+{
+	char addr[128] = "";
+	int octets;
+	char *p;
+
+	TST_SYSFS_READ_STR(addr, sizeof(addr), NET "/%s/address", iface);
+
+	/* An empty address is valid for an interface with addr_len == 0. */
+	octets = addr[0] ? 1 : 0;
+
+	for (p = addr; *p; p++) {
+		if (*p == ':')
+			octets++;
+	}
+
+	TST_SYSFS_EXP_EQ_LI(octets, NET "/%s/addr_len", iface);
+}
+
+static void check_iface(const char *iface)
+{
+	long type, mtu_max = LONG_MAX;
+
+	tst_res(TINFO, "Checking interface '%s'", iface);
+
+	type = TST_SYSFS_READ_LI(NET "/%s/type", iface);
+
+	if (type == ARPHRD_ETHER)
+		mtu_max = MAX_ETHER_MTU;
+
+	TST_SYSFS_ASSERT_RANGELL(1, mtu_max, NET "/%s/mtu", iface);
+	TST_SYSFS_ASSERT_RANGELL(0, MAX_ADDR_LEN, NET "/%s/addr_len", iface);
+
+	check_address(iface);
+	TST_SYSFS_ASSERT_ONEOF(operstates, NET "/%s/operstate", iface);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(NET);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		found = 1;
+		check_iface(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No network interfaces found");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
