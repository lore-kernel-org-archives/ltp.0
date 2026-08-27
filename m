Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6BDC61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:28:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B21B73D527A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:28:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6F363D20BA
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C4D01000950
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DF7E1F854
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+4EbLxq57QK+/DDU93gGCqlp2CuWClEQJ+BLxSpSKc=;
 b=x/a7XQeMBwExswqrjXRhTDowypD1TZTZ4SDaerdHls7p0tgxG0pmMR3p3h09r8yK9k/A6e
 xFkNo8WYxp7mMB+ejzzSjbo0w4Yi3dFs4r+RjPq2RRVHmjyqxF9b+KutHqZBZw3GNDg6xA
 V1+evhVwf4Y0F6P+YDacnEeu+CNoYgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+4EbLxq57QK+/DDU93gGCqlp2CuWClEQJ+BLxSpSKc=;
 b=owsKgpZfTlwSetB9QTv5GDJvop6x6DWil9Yyzv5T1jZqUjHevc9yOflyVCPbOBUbBZgPha
 UeiNHF7nIwPR4JCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+4EbLxq57QK+/DDU93gGCqlp2CuWClEQJ+BLxSpSKc=;
 b=z+LU1HzTVLVDIrYjDjQY7Hph1Iz3W3EZc5IUgnGsZr4UzEMey904w4pkGtHMYYp6PxmuBx
 l5myrBCf23+8OibpopNyNiLz5JNjMv6AYCKkH3TBcBVvWwhliF5tX2mmDLBS6lqYgIxqiL
 f79a8Y2uEmPnqqLJOeLWRGY3fz2omz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+4EbLxq57QK+/DDU93gGCqlp2CuWClEQJ+BLxSpSKc=;
 b=cLqr+L7Wm5Sg9sVBcQfmsUkMlxzZz/9Lq5aUCEvUvfJRASvigjE8OXbB2Dpd25rMUFlP5P
 +vONBtvzGoKr6ZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07F3B13682
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IOh0APIdkGqZawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:47 +0200
Message-ID: <20260827112157.1748734-22-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
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
Subject: [LTP] [PATCH v4 21/31] testcases: sysfs: Add sys_net02
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

This test, unlike sys_net01, creates a virtual ethernet interface so
that it can change various attributes and verify that they are mirrored
into the sysfs correctly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/class/net/.gitignore   |   1 +
 testcases/kernel/sysfs/class/net/sys_net02.c  | 187 ++++++++++++++++++
 .../kernel/sysfs/class/net/sys_net_common.h   |  97 +++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net02.c
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net_common.h

diff --git a/runtest/sysfs b/runtest/sysfs
index 90e4d2b8e..fee8a0b2b 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -16,3 +16,4 @@ sys_wakeup01 sys_wakeup01
 sys_rtc01 sys_rtc01
 sys_thermal01 sys_thermal01
 sys_net01 sys_net01
+sys_net02 sys_net02
diff --git a/testcases/kernel/sysfs/class/net/.gitignore b/testcases/kernel/sysfs/class/net/.gitignore
index f5ef57b75..b70d02158 100644
--- a/testcases/kernel/sysfs/class/net/.gitignore
+++ b/testcases/kernel/sysfs/class/net/.gitignore
@@ -1 +1,2 @@
 /sys_net01
+/sys_net02
diff --git a/testcases/kernel/sysfs/class/net/sys_net02.c b/testcases/kernel/sysfs/class/net/sys_net02.c
new file mode 100644
index 000000000..6045156f2
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net02.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verifies that the link state attributes exported under
+ * /sys/class/net/<iface>/ correctly mirror the administrative state of a
+ * veth peer.
+ *
+ * A veth device's carrier is expected to be up only while its peer is up:
+ * veth_open()/veth_close() call netif_carrier_on()/netif_carrier_off() based
+ * on whether the peer is running. The test creates a veth pair and checks
+ * that bringing the peer down and back up is reflected in:
+ *
+ * - carrier - 1 while the peer is up, 0 while it is down
+ * - operstate - ``up`` while the peer is up, ``lowerlayerdown`` while it is
+ *   down
+ * - carrier_up_count / carrier_down_count - incremented by exactly one on
+ *   each corresponding transition
+ * - carrier_changes - always equal to carrier_up_count + carrier_down_count
+ *
+ * Note that while the NETDEV_SET_STATE() netlink call itself is synchronous,
+ * operstate is not: veth_open()/veth_close() call netif_carrier_on()/off(),
+ * but the kernel's linkwatch mechanism (net/core/link_watch.c) applies the
+ * resulting operstate transition asynchronously via a workqueue, so reading
+ * it right after the netlink call can still observe the previous value for
+ * a little while, particularly on a loaded/slow system. The test retries
+ * (see read_operstate() in sys_net_common.h) rather than using
+ * poll(2)/select(2): unlike some other sysfs attributes,
+ * /sys/class/net/<iface>/carrier does not support poll() based notification
+ * on Linux, link state changes are reported to userspace via rtnetlink
+ * instead.
+ *
+ * The test also checks attributes that are not tied to the peer's state:
+ *
+ * - mtu - directly writable via sysfs; a few valid values are written and
+ *   read back, and one syntactically invalid value is rejected (with the mtu
+ *   left unchanged)
+ * - address - read-only in sysfs, changed via rtnetlink instead (the
+ *   interface is brought down first since most drivers require this); while
+ *   doing so, the IFF_UP bit in ``flags`` is also cross-checked against the
+ *   interface's own administrative state
+ * - netdev_group and ifalias - directly writable via sysfs, a value is
+ *   written and read back
+ *
+ * This needs root to create the veth pair.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <net/if.h>
+
+#include "tst_test.h"
+#include "tst_netdevice.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+#define IFNAME1 "ltp_vethp1"
+#define IFNAME2 "ltp_vethp2"
+#define IFACE_PATH PATH_CLASS_NET "/" IFNAME1
+
+static int veth_created;
+
+static long read_mtu(void)
+{
+	return TST_SYSFS_READ_LI(IFACE_PATH "/mtu");
+}
+
+#include "sys_net_common.h"
+
+static void setup(void)
+{
+	CREATE_VETH_PAIR(IFNAME1, IFNAME2);
+	veth_created = 1;
+
+	NETDEV_SET_STATE(IFNAME1, 1);
+	NETDEV_SET_STATE(IFNAME2, 1);
+}
+
+static unsigned long read_flags(void)
+{
+	return TST_SYSFS_READ_LX(IFACE_PATH "/flags");
+}
+
+static void check_address(void)
+{
+	static const unsigned char new_addr[6] = {0x02, 0, 0, 0, 0, 0x01};
+	char actual[32];
+	long iff_up;
+
+	tst_res(TINFO, "IFNAME1 is up before the address change");
+	iff_up = read_flags() & IFF_UP;
+	TST_EXP_EQ_LI(iff_up, IFF_UP);
+
+	NETDEV_SET_STATE(IFNAME1, 0);
+	tst_res(TINFO, "IFNAME1 is down for the address change");
+	iff_up = read_flags() & IFF_UP;
+	TST_EXP_EQ_LI(iff_up, 0);
+
+	NETDEV_SET_HWADDR(IFNAME1, new_addr, sizeof(new_addr));
+	NETDEV_SET_STATE(IFNAME1, 1);
+	tst_res(TINFO, "IFNAME1 is up again after the address change");
+	iff_up = read_flags() & IFF_UP;
+	TST_EXP_EQ_LI(iff_up, IFF_UP);
+
+	TST_SYSFS_READ_STR(actual, sizeof(actual), IFACE_PATH "/address");
+
+	TST_EXP_EQ_STR(actual, "02:00:00:00:00:01");
+}
+
+static void check_netdev_group(void)
+{
+	long group;
+
+	if (FILE_PRINTF(IFACE_PATH "/netdev_group", "%d", 7)) {
+		tst_res(TFAIL, "Failed to set netdev_group");
+		return;
+	}
+
+	group = TST_SYSFS_READ_LI(IFACE_PATH "/netdev_group");
+
+	TST_EXP_EQ_LI(group, 7);
+}
+
+static void check_ifalias(void)
+{
+	char alias[64];
+
+	if (FILE_PRINTF(IFACE_PATH "/ifalias", "%s", "ltp-test-alias")) {
+		tst_res(TFAIL, "Failed to set ifalias");
+		return;
+	}
+
+	TST_SYSFS_READ_STR(alias, sizeof(alias), IFACE_PATH "/ifalias");
+	TST_EXP_EQ_STR(alias, "ltp-test-alias");
+}
+
+static void run(void)
+{
+	struct netdev_state s0, s1, s2;
+
+	TST_RETRY_FUNC(read_operstate(&s0, "up"), TST_RETVAL_EQ0);
+	check_state(&s0, 1, "up", "both ends up");
+
+	NETDEV_SET_STATE(IFNAME2, 0);
+	TST_RETRY_FUNC(read_operstate(&s1, "lowerlayerdown"), TST_RETVAL_EQ0);
+	check_state(&s1, 0, "lowerlayerdown", "peer down");
+	check_state_delta(&s0, &s1, 0, 1, "peer down transition");
+
+	NETDEV_SET_STATE(IFNAME2, 1);
+	TST_RETRY_FUNC(read_operstate(&s2, "up"), TST_RETVAL_EQ0);
+	check_state(&s2, 1, "up", "peer back up");
+	check_state_delta(&s1, &s2, 1, 0, "peer up transition");
+
+	check_mtu_valid(68);
+	check_mtu_valid(1500);
+	check_mtu_valid(9000);
+	check_mtu_valid(65535);
+	check_mtu_invalid("-1");
+	check_mtu_invalid("0");
+	check_mtu_invalid("67");
+	check_mtu_invalid("70000");
+
+	check_address();
+
+	check_netdev_group();
+	check_ifalias();
+}
+
+static void cleanup(void)
+{
+	if (veth_created)
+		NETDEV_REMOVE_DEVICE(IFNAME1);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_VETH",
+		NULL
+	},
+};
diff --git a/testcases/kernel/sysfs/class/net/sys_net_common.h b/testcases/kernel/sysfs/class/net/sys_net_common.h
new file mode 100644
index 000000000..06f5c38c5
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net_common.h
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SYS_NET_COMMON
+#define SYS_NET_COMMON
+
+struct netdev_state {
+	long carrier;
+	long carrier_changes;
+	long carrier_up_count;
+	long carrier_down_count;
+	char operstate[32];
+};
+
+static void read_state(struct netdev_state *st)
+{
+	st->carrier = TST_SYSFS_READ_LI(IFACE_PATH "/carrier");
+	st->carrier_changes = TST_SYSFS_READ_LI(IFACE_PATH "/carrier_changes");
+	st->carrier_up_count = TST_SYSFS_READ_LI(IFACE_PATH "/carrier_up_count");
+	st->carrier_down_count = TST_SYSFS_READ_LI(IFACE_PATH "/carrier_down_count");
+	TST_SYSFS_READ_STR(st->operstate, sizeof(st->operstate), IFACE_PATH "/operstate");
+}
+
+/*
+ * operstate is not updated synchronously with the event that changes the
+ * underlying carrier (netif_carrier_on()/off(), called either directly, or
+ * indirectly e.g. via veth_open()/veth_close() reacting to the peer's
+ * administrative state): the kernel's linkwatch mechanism
+ * (net/core/link_watch.c) applies the operstate transition asynchronously
+ * via a workqueue, so it may still read the previous state for a little
+ * while after the event that changes the carrier, particularly on a
+ * loaded/slow system. Callers should wrap this in TST_RETRY_FUNC() rather
+ * than assume operstate is already settled right after such an event.
+ */
+static int read_operstate(struct netdev_state *st, const char *expected_state)
+{
+	read_state(st);
+	return strcmp(st->operstate, expected_state);
+}
+
+static void check_state(const struct netdev_state *st, long carrier,
+			const char *operstate, const char *desc)
+{
+	tst_res(TINFO, "%s", desc);
+
+	TST_EXP_EQ_LI(st->carrier, carrier);
+	TST_EXP_EQ_STR(st->operstate, operstate);
+	TST_EXP_EQ_LI(st->carrier_changes,
+		      st->carrier_up_count + st->carrier_down_count);
+}
+
+static void check_state_delta(const struct netdev_state *prev,
+			      const struct netdev_state *cur, long up_delta,
+			      long down_delta, const char *desc)
+{
+	long got_up = cur->carrier_up_count - prev->carrier_up_count;
+	long got_down = cur->carrier_down_count - prev->carrier_down_count;
+	long got_changes = cur->carrier_changes - prev->carrier_changes;
+
+	tst_res(TINFO, "%s", desc);
+
+	TST_EXP_EQ_LI(got_up, up_delta);
+	TST_EXP_EQ_LI(got_down, down_delta);
+	TST_EXP_EQ_LI(got_changes, up_delta + down_delta);
+}
+
+static void check_mtu_valid(long mtu)
+{
+	char mtu_str[16];
+
+	snprintf(mtu_str, sizeof(mtu_str), "%ld", mtu);
+
+	if (FILE_PRINTF(IFACE_PATH "/mtu", "%s", mtu_str)) {
+		tst_res(TFAIL, "Failed to set mtu to %ld", mtu);
+		return;
+	}
+
+	TST_EXP_EQ_LI(read_mtu(), mtu);
+}
+
+static void check_mtu_invalid(const char *mtu_str)
+{
+	long before = read_mtu();
+
+	if (!FILE_PRINTF(IFACE_PATH "/mtu", "%s", mtu_str)) {
+		tst_res(TFAIL, "Writing mtu '%s' unexpectedly succeeded",
+			mtu_str);
+		return;
+	}
+
+	tst_res(TINFO, "Writing mtu '%s' was rejected as expected", mtu_str);
+	TST_EXP_EQ_LI(read_mtu(), before);
+}
+
+#endif /* SYS_NET_COMMON */
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
