Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BCDC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53FAC3D5989
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:27:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3EBF3DA326
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 589D1140098C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A736321966
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a34bl0LPowGmqfaRZqzbJtS6YYtx9Bs1NAWNjRMdrA=;
 b=b1wUe8znlnOtI+5E9YIkgo1w5SB7wgWavfbMCE3ZP0s+WpY4YdqpH6aZRWGY5hPVNHW7XG
 H1m10nly19sauihuejG+ZRz+C5PTSi6skh6InKZjYnKjTxti5wrbgNf1GLYnNQHa6Mrgy4
 JQJZN9/fLWSfIByrf5Uqt7xPZFWApVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a34bl0LPowGmqfaRZqzbJtS6YYtx9Bs1NAWNjRMdrA=;
 b=Hm4CA96zOJFBgI5dqSR1FDpUeOM54R88lrH3+5BmTUuUmeIy7vCQu00Pj7qCvc23fdUNhI
 c+5sno3AwXrTNRAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xfORU7kH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H2omLHwL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a34bl0LPowGmqfaRZqzbJtS6YYtx9Bs1NAWNjRMdrA=;
 b=xfORU7kHUXaKwcXYQoFonCfnueMA15Er6hPdMogFEz3J/xONVBxUjX2tSW/OQsz91kHNRM
 Lq6PYqIx6RxXQ0wo34O1q5TWqw8bHXqlX37ZUyDy5OvqUq2Bs17fCl0wA8cZNM8Y1dgZvv
 tz10XpA1zZeELAyBi2ozQ/UTwDsXaRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a34bl0LPowGmqfaRZqzbJtS6YYtx9Bs1NAWNjRMdrA=;
 b=H2omLHwLRK+hAX31BN5zAaIQ+3XkZnulzP/dE7HVII3CcqnNjVyifWHg2b4LUQFXzTQub3
 gRKb9EARqMCDaDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9813B1361C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IfVOI/EdkGqWawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:25 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:46 +0200
Message-ID: <20260827112157.1748734-21-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A736321966
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 20/31] testcases: sysfs: Add sys_net01
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
 include/tst_path_defs.h                      |   1 +
 runtest/sysfs                                |   1 +
 testcases/kernel/sysfs/class/net/.gitignore  |   1 +
 testcases/kernel/sysfs/class/net/Makefile    |   7 +
 testcases/kernel/sysfs/class/net/sys_net01.c | 145 +++++++++++++++++++
 5 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/sysfs/class/net/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/net/Makefile
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index f2417ecdb..2c9cfcf85 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -97,6 +97,7 @@
 #define PATH_CLASS_BDI				"/sys/class/bdi"
 #define PATH_CLASS_HWMON			"/sys/class/hwmon"
 #define PATH_CLASS_LEDS			"/sys/class/leds"
+#define PATH_CLASS_NET				"/sys/class/net"
 #define PATH_CLASS_RTC				"/sys/class/rtc"
 #define PATH_CLASS_THERMAL			"/sys/class/thermal"
 #define PATH_CLASS_WAKEUP			"/sys/class/wakeup"
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
index 000000000..aa54c0699
--- /dev/null
+++ b/testcases/kernel/sysfs/class/net/sys_net01.c
@@ -0,0 +1,145 @@
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
+ *
+ * Entries directly under /sys/class/net/ that are not actual network
+ * interfaces are skipped: real interfaces are always symlinks to a device
+ * directory (e.g. ../../devices/.../net/eth0), but some drivers also expose
+ * plain control files right there, e.g. bonding_masters (created whenever
+ * the bonding module is loaded, regardless of whether any bond device is
+ * actually configured), used to create/destroy bond devices by writing
+ * ``+bond0``/``-bond0`` to it.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
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
+	TST_SYSFS_READ_STR(addr, sizeof(addr), PATH_CLASS_NET "/%s/address", iface);
+
+	/* An empty address is valid for an interface with addr_len == 0. */
+	octets = addr[0] ? 1 : 0;
+
+	for (p = addr; *p; p++) {
+		if (*p == ':')
+			octets++;
+	}
+
+	TST_SYSFS_EXP_EQ_LI(octets, PATH_CLASS_NET "/%s/addr_len", iface);
+}
+
+static void check_iface(const char *iface)
+{
+	long type, mtu_max = LONG_MAX;
+
+	tst_res(TINFO, "Checking interface '%s'", iface);
+
+	type = TST_SYSFS_READ_LI(PATH_CLASS_NET "/%s/type", iface);
+
+	if (type == ARPHRD_ETHER)
+		mtu_max = MAX_ETHER_MTU;
+
+	TST_SYSFS_ASSERT_RANGELL(1, mtu_max, PATH_CLASS_NET "/%s/mtu", iface);
+	TST_SYSFS_ASSERT_RANGELL(0, MAX_ADDR_LEN, PATH_CLASS_NET "/%s/addr_len", iface);
+
+	check_address(iface);
+	TST_SYSFS_ASSERT_ONEOF(operstates, PATH_CLASS_NET "/%s/operstate", iface);
+}
+
+static int is_iface(const char *name)
+{
+	struct stat st;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_CLASS_NET "/%s", name);
+
+	if (stat(path, &st))
+		return 0;
+
+	return S_ISDIR(st.st_mode);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = TST_SYSFS_TRY_OPENDIR(PATH_CLASS_NET);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		if (!is_iface(ent->d_name)) {
+			tst_res(TINFO, "%s is not a network interface, skipping",
+				ent->d_name);
+			continue;
+		}
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
