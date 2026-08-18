Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD9FC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:19:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C543CD0B3
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:19:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E6773CD2C7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 456F76008A8
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 991A23E67
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TgFNDqTbxwWnOoFBV+1hn5jnLPAvORwQUWs8Cnjqg8=;
 b=pEQkioeHbVojQbHI0qtnEzDkypydAyBzcSLcqgym98U2jlhGP/KEtIcdmPbCWpYM/lX7Up
 bakQr9DY1VCkePNTe6B/Nz+XShRTokoQ2SuWF3togCceGs4KDk9a3VZRBSR0EcOhgwo+7W
 VJElU35qQpa5zC1WO95X6Df/jCzBdtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TgFNDqTbxwWnOoFBV+1hn5jnLPAvORwQUWs8Cnjqg8=;
 b=dKxcecmuod/ulB/vSXbiywNm9z41ZR6cT27vnFwPqCrtNt2xHiBe5W/DWZKHZ25Um2gb6b
 Lcbfex7lwk7sTnBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TgFNDqTbxwWnOoFBV+1hn5jnLPAvORwQUWs8Cnjqg8=;
 b=y9Eh/1fbnvUjhxQ0i175c12l5GOxCveay58Uyd9+rIPX/1HdrUSuQPrSH+26DKNZuGGBX4
 ffczUEnmxHnoRXylDzNSsTDLhiaKImvrlbsBEizUkQamDDWvx+gEDZBXcuGlVdbtqKRY+l
 yErzCVtxHR3cq8d89QB2Hpqe2J4qdMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TgFNDqTbxwWnOoFBV+1hn5jnLPAvORwQUWs8Cnjqg8=;
 b=crtxiGrTm6yKoCx3c6L1ir0KmhCnckX9SNDD/H/mVdT7vlodSUiU5U8R7grUIuKNdVPAoo
 waMsPHhHxGzut+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B272362E
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +XorIZhohGq0cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:44 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:03 +0200
Message-ID: <20260818141311.1265557-24-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 23/31] testcases: sysfs: Add sys_net04
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

Similar to sys_net02 but this time for TUN/TAP devices.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/net/.gitignore  |   1 +
 testcases/kernel/sysfs/class/net/sys_net04.c | 211 +++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net04.c

diff --git a/runtest/sysfs b/runtest/sysfs
index b2cc0005c..290866349 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -18,3 +18,4 @@ sys_thermal01 sys_thermal01
 sys_net01 sys_net01
 sys_net02 sys_net02
 sys_net03 sys_net03
+sys_net04 sys_net04
diff --git a/testcases/kernel/sysfs/class/net/.gitignore b/testcases/kernel/sysfs/class/net/.gitignore
index 8c3782a3b..6e934b7c1 100644
--- a/testcases/kernel/sysfs/class/net/.gitignore
+++ b/testcases/kernel/sysfs/class/net/.gitignore
@@ -1,3 +1,4 @@
 /sys_net01
 /sys_net02
 /sys_net03
+/sys_net04
diff --git a/testcases/kernel/sysfs/class/net/sys_net04.c b/testcases/kernel/sysfs/class/net/sys_net04.c
new file mode 100644
index 000000000..a47cf44fa
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net04.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verifies that the link state attributes exported under
+ * /sys/class/net/<iface>/ correctly mirror the attach/detach state of a TUN
+ * device's file descriptor, and that TUN/TAP-specific sysfs attributes hold
+ * sane values.
+ *
+ * Unlike veth, a TUN device has no peer network device: instead, its carrier
+ * is controlled by whether a userspace process currently has the device's
+ * /dev/net/tun file descriptor attached to it (tun_attach()/tun_detach() in
+ * the kernel call netif_carrier_on()/netif_carrier_off() respectively). The
+ * device is created persistent (TUNSETPERSIST) so that it survives the file
+ * descriptor being closed, which is what allows the attach/detach cycle to
+ * be exercised here without the interface disappearing. The test checks
+ * that closing and reopening the attachment is reflected in:
+ *
+ * - carrier - 1 while a file descriptor is attached, 0 while detached
+ * - operstate - "up" while attached, "down" while detached. Unlike veth,
+ *   this is plain "down" rather than "lowerlayerdown": the latter is only
+ *   reported when the carrier-down state is attributable to a registered
+ *   upper/lower netdevice relationship (a veth peer, a bond slave, a VLAN's
+ *   parent, ...), whereas a TUN device's carrier is driven by a userspace
+ *   file descriptor attachment, which is not a netdevice dependency at all.
+ * - carrier_up_count / carrier_down_count - incremented by exactly one on
+ *   each corresponding transition
+ * - carrier_changes - always equal to carrier_up_count + carrier_down_count
+ *
+ * These four attributes are generic net_device core statistics updated by
+ * netif_carrier_on()/off() regardless of the underlying driver, so the
+ * expected behavior mirrors the veth peer test in sys_net02.c, aside from
+ * the "down" vs "lowerlayerdown" difference above.
+ *
+ * The very first attach happens as part of the same TUNSETIFF call that
+ * registers the netdevice, before which netif_carrier_on() skips updating
+ * carrier_up_count/operstate for it. setup() therefore performs a throwaway
+ * detach/reattach cycle so that run() starts from a state where carrier
+ * tracking already behaves normally.
+ *
+ * The test also checks attributes that are not tied to the attach state:
+ *
+ * - mtu - directly writable via sysfs; a few valid values are written and
+ *   read back, and one syntactically invalid value is rejected (with the mtu
+ *   left unchanged)
+ * - tun_flags - reflects (at least) the IFF_TUN, IFF_NO_PI and IFF_PERSIST
+ *   bits the device was created/configured with, and never has IFF_TAP set
+ * - owner / group - default to -1 (no restriction) since neither
+ *   TUNSETOWNER nor TUNSETGROUP was used
+ * - a second, TAP-mode device is created solely to cross-check that type and
+ *   addr_len correctly differ between the two: a TUN device has no
+ *   link-layer header (type == ARPHRD_NONE, addr_len == 0), while a TAP
+ *   device behaves like Ethernet (type == ARPHRD_ETHER, addr_len == 6)
+ *
+ * This needs root to create the TUN/TAP devices.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+
+#include "tst_test.h"
+#include "tst_netdevice.h"
+#include "tst_safe_file_ops.h"
+#include "tst_sysfs_assert.h"
+
+#define TUN_PATH "/dev/net/tun"
+
+#define IFNAME_TUN "ltp_tun0"
+#define IFNAME_TAP "ltp_tap0"
+#define IFACE_PATH "/sys/class/net/" IFNAME_TUN
+
+/* include/uapi/linux/if_arp.h, avoided pulling in the whole header. */
+#define ARPHRD_ETHER 1
+#define ARPHRD_NONE 0xFFFE
+
+static int tun_fd = -1;
+static int tap_fd = -1;
+static int tun_created;
+static int tap_created;
+
+static long read_mtu(void)
+{
+	return TST_SYSFS_READ_LI(IFACE_PATH "/mtu");
+}
+
+#include "sys_net_common.h"
+
+static int open_tun(const char *ifname, short flags)
+{
+	struct ifreq ifr = { .ifr_flags = flags };
+	int fd = SAFE_OPEN(TUN_PATH, O_RDWR);
+
+	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
+	SAFE_IOCTL(fd, TUNSETIFF, (void *)&ifr);
+
+	return fd;
+}
+
+static void setup(void)
+{
+	tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
+	SAFE_IOCTL(tun_fd, TUNSETPERSIST, 1);
+	tun_created = 1;
+
+	/*
+	 * The initial attach above happens as part of the same TUNSETIFF call
+	 * that registers the netdevice, before which netif_carrier_on() skips
+	 * updating carrier_up_count/operstate for it. Detach and reattach
+	 * once here so run() starts from a state where carrier tracking
+	 * already behaves normally, see the top comment.
+	 */
+	SAFE_CLOSE(tun_fd);
+	NETDEV_SET_STATE(IFNAME_TUN, 1);
+	tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
+
+	tap_fd = open_tun(IFNAME_TAP, IFF_TAP | IFF_NO_PI);
+	SAFE_IOCTL(tap_fd, TUNSETPERSIST, 1);
+	tap_created = 1;
+}
+
+static void check_tun_flags(void)
+{
+	unsigned long flags;
+
+	flags = TST_SYSFS_READ_LX(IFACE_PATH "/tun_flags");
+
+	tst_res(TINFO, "%s/tun_flags = 0x%lx", IFACE_PATH, flags);
+
+	TST_EXP_EQ_LI(flags & IFF_TUN, IFF_TUN);
+	TST_EXP_EQ_LI(flags & IFF_TAP, 0);
+	TST_EXP_EQ_LI(flags & IFF_NO_PI, IFF_NO_PI);
+	TST_EXP_EQ_LI(flags & IFF_PERSIST, IFF_PERSIST);
+}
+
+static void check_owner_group(void)
+{
+	TST_SYSFS_EXP_EQ_LI(-1, IFACE_PATH "/owner");
+	TST_SYSFS_EXP_EQ_LI(-1, IFACE_PATH "/group");
+}
+
+static void check_tun_vs_tap_type(void)
+{
+	TST_SYSFS_EXP_EQ_LI(ARPHRD_NONE, "/sys/class/net/" IFNAME_TUN "/type");
+	TST_SYSFS_EXP_EQ_LI(0, "/sys/class/net/" IFNAME_TUN "/addr_len");
+
+	TST_SYSFS_EXP_EQ_LI(ARPHRD_ETHER, "/sys/class/net/" IFNAME_TAP "/type");
+	TST_SYSFS_EXP_EQ_LI(6, "/sys/class/net/" IFNAME_TAP "/addr_len");
+}
+
+static void run(void)
+{
+	struct netdev_state s0, s1, s2;
+
+	read_state(&s0);
+	check_state(&s0, 1, "up", "tun attached and up");
+
+	SAFE_CLOSE(tun_fd);
+	read_state(&s1);
+	check_state(&s1, 0, "down", "tun detached");
+	check_state_delta(&s0, &s1, 0, 1, "detach transition");
+
+	tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
+	read_state(&s2);
+	check_state(&s2, 1, "up", "tun reattached");
+	check_state_delta(&s1, &s2, 1, 0, "reattach transition");
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
+	check_tun_flags();
+	check_owner_group();
+	check_tun_vs_tap_type();
+}
+
+static void cleanup(void)
+{
+	if (tun_fd >= 0)
+		SAFE_CLOSE(tun_fd);
+
+	if (tap_fd >= 0)
+		SAFE_CLOSE(tap_fd);
+
+	if (tun_created)
+		NETDEV_REMOVE_DEVICE(IFNAME_TUN);
+
+	if (tap_created)
+		NETDEV_REMOVE_DEVICE(IFNAME_TAP);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_TUN",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
