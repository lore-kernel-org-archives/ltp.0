Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A7C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:40:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 185AB3E4DA2
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:40:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D843E56AF
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDEE61A00799
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF4DB3E5F;
 Tue, 14 Jul 2026 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xzT1fVEng8JemFZt2Ycy1HrFkWGbg3m0mG4cnPFpOw=;
 b=FzZ7ayTNVE0CbXnYrnRHR8iIHayzxEsBBVEkX5LpQQd8gt2aXULTDZ1z/OADwNhnP8jB/x
 pdD+pO/0RFLfMZsoxGJxGV54BDvT+aR+n4VB7FXkup5WAvO7hfi/sIiEOvtB5jKpncbXrY
 y6KP0d+vypSbzao1wuyN4m+lr7HXN8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xzT1fVEng8JemFZt2Ycy1HrFkWGbg3m0mG4cnPFpOw=;
 b=67vhBjdUwFdWgRbhSRtfSz3BYcVFFwtIBrnlC2UxfPC3Iiua/eSis4atYZvSFhIStUsTti
 l+m20IUSrkTcGQBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FzZ7ayTN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=67vhBjdU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xzT1fVEng8JemFZt2Ycy1HrFkWGbg3m0mG4cnPFpOw=;
 b=FzZ7ayTNVE0CbXnYrnRHR8iIHayzxEsBBVEkX5LpQQd8gt2aXULTDZ1z/OADwNhnP8jB/x
 pdD+pO/0RFLfMZsoxGJxGV54BDvT+aR+n4VB7FXkup5WAvO7hfi/sIiEOvtB5jKpncbXrY
 y6KP0d+vypSbzao1wuyN4m+lr7HXN8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xzT1fVEng8JemFZt2Ycy1HrFkWGbg3m0mG4cnPFpOw=;
 b=67vhBjdUwFdWgRbhSRtfSz3BYcVFFwtIBrnlC2UxfPC3Iiua/eSis4atYZvSFhIStUsTti
 l+m20IUSrkTcGQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DC12779AF;
 Tue, 14 Jul 2026 08:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yIrAI6T1VWo3OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 08:39:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:39:01 +0200
MIME-Version: 1.0
Message-Id: <20260714-cve-2026-46331-v5-4-bab4ac23c1f7@suse.com>
References: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
In-Reply-To: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784018339; l=11074;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=4a/F2apb+orIxuDclcVuBRO+ftam8pD53r3GQu9mCxM=;
 b=t4qzwHiky82abYwvcwbTFkHSxMsKoI1VexrUtXqcBwOURxW2ZQqAGLGl+Q+0Wr8go6Z4/n2ob
 18aviyUnnMKBwiq/QK2krx5+g7x5r3gYFdHboKM2r4yB9chU4oOCgrE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CF4DB3E5F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/4] cve: Add act_pedit page-cache corruption test
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

Regression test for CVE-2026-46331. The act_pedit
action computed a stale COW range, letting a TCP-typed
key write past it into page-cache pages placed in the
skb by sendfile.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_netdevice.h        |   7 ++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 274 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 2394f9c7fd6f58cd390ac38e3426858ffe402f1f..2617bb149cf7409e2ca7be00a6442f35a260551e 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -146,6 +146,13 @@ int tst_netdev_remove_qdisc(const char *file, const int lineno, int strict,
 #define NETDEV_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
 	tst_netdev_remove_qdisc(__FILE__, __LINE__, 1, (ifname), (family), \
 		(parent), (handle), (qd_kind))
+/*
+ * Same as NETDEV_REMOVE_QDISC() but does not fail when the qdisc is
+ * missing (strict=0), so it can be used to clear a possibly absent qdisc.
+ */
+#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
+	tst_netdev_remove_qdisc(__FILE__, __LINE__, 0, (ifname), (family), \
+		(parent), (handle), (qd_kind))
 
 /*
  * Add traffic class to queueing discipline. Network interface name is
diff --git a/runtest/cve b/runtest/cve
index 27e12e0c1536fc479471ef4fcc7a461834c57398..3bbcfd6a2f2fb204fc6ae4ba89b5a7554c2fcbc5 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -99,3 +99,4 @@ cve-2026-43284 xfrm01
 cve-2026-43494 io_uring04
 cve-2026-46300 xfrm02
 cve-2026-46300-skb-segment xfrm03
+cve-2026-46331 cve-2026-46331
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index dc1dad5b0d0d02a3ab57e72516c33ee7949c8431..bc1af0dd2c8086e4f5f78a3b15b91fafbd8f5936 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -15,3 +15,4 @@ icmp_rate_limit01
 tcindex01
 cve-2025-38236
 cve-2025-21756
+cve-2026-46331
diff --git a/testcases/cve/cve-2026-46331.c b/testcases/cve/cve-2026-46331.c
new file mode 100644
index 0000000000000000000000000000000000000000..c33d358396f21024d8a68e9cd5c4cae0a9339a9f
--- /dev/null
+++ b/testcases/cve/cve-2026-46331.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that the ``act_pedit`` traffic-control action correctly COW's
+ * all modified regions of an skb before writing, so that page-cache
+ * pages referenced via :manpage:`sendfile(2)` are not corrupted.
+ *
+ * ``tcf_pedit_act()`` computed the COW range for
+ * ``skb_ensure_writable()`` once before the key loop using
+ * ``tcfp_off_max_hint``, but the hint did not account for the runtime
+ * header offset added by typed keys. An egress pedit rule whose first
+ * ``NETWORK`` key inflates the IP header length (IHL 15) pushes
+ * subsequent ``TCP``-typed key writes past the stale COW boundary,
+ * allowing them to scribble directly into page-cache pages that
+ * :manpage:`sendfile(2)` placed in the skb.
+ *
+ * [Algorithm]
+ *
+ * - Create a 4 KiB file with a sequential byte pattern and set its
+ *   permissions to read-only (0444)
+ * - Reopen the file ``O_RDONLY``
+ * - Add a ``clsact`` qdisc on ``lo`` and establish a TCP connection
+ *   on loopback
+ * - After the handshake, install a ``matchall`` egress filter carrying
+ *   a two-key pedit action: key 0 sets IP IHL to 15 (NETWORK type),
+ *   key 1 writes a 4-byte marker at TCP-relative offset 512
+ * - :manpage:`sendfile(2)` the file through the TCP socket so the
+ *   pedit action fires on the page-cache-backed skb
+ * - Reread the file through the same ``O_RDONLY`` descriptor and
+ *   compare with the original pattern; any difference means the
+ *   page cache was corrupted
+ */
+
+#include <sys/sendfile.h>
+#include <linux/rtnetlink.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_netdevice.h"
+#include "lapi/if_ether.h"
+#include "lapi/pkt_sched.h"
+#include "lapi/pkt_cls.h"
+#include "lapi/tc_pedit.h"
+#include "lapi/sched.h"
+#include "lapi/tcp.h"
+
+#define TESTFILE	"pagecache_test"
+#define DATA_SIZE	4096
+#define PORT		4445
+
+#define NKEYS		2
+#define IHL_VALUE	0x4fu		/* IP version 4, IHL 15 (max) */
+#define IHL_MASK	0xffffff00u	/* keep TOS / tot_len bytes */
+#define MARKER_OFFSET	512		/* TCP-relative key offset */
+#define MARKER_VALUE	0xccccccccu	/* 4-byte marker written by pedit */
+
+/*
+ * Pedit selector buffer: struct tc_pedit_sel followed by NKEYS keys.
+ * sizeof(struct tc_pedit_sel) does not include the flexible array, so
+ * the trailing keys[] array provides storage for it.
+ */
+static struct {
+	struct tc_pedit_sel sel;
+	struct tc_pedit_key keys[NKEYS];
+} pedit_sel_buf;
+
+/* --- Nested attribute lists for the matchall + pedit filter config --- */
+
+static uint16_t key0_htype = TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+static uint16_t key0_cmd   = TCA_PEDIT_KEY_EX_CMD_SET;
+static uint16_t key1_htype = TCA_PEDIT_KEY_EX_HDR_TYPE_TCP;
+static uint16_t key1_cmd   = TCA_PEDIT_KEY_EX_CMD_SET;
+
+static const struct tst_netlink_attr_list key0_ex[] = {
+	{TCA_PEDIT_KEY_EX_HTYPE, &key0_htype, sizeof(key0_htype), NULL},
+	{TCA_PEDIT_KEY_EX_CMD,   &key0_cmd,   sizeof(key0_cmd),   NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list key1_ex[] = {
+	{TCA_PEDIT_KEY_EX_HTYPE, &key1_htype, sizeof(key1_htype), NULL},
+	{TCA_PEDIT_KEY_EX_CMD,   &key1_cmd,   sizeof(key1_cmd),   NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list keys_ex[] = {
+	{TCA_PEDIT_KEY_EX, NULL, 0, key0_ex},
+	{TCA_PEDIT_KEY_EX, NULL, 0, key1_ex},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list pedit_opts[] = {
+	{TCA_PEDIT_PARMS_EX, &pedit_sel_buf, sizeof(pedit_sel_buf), NULL},
+	{TCA_PEDIT_KEYS_EX,  NULL, 0, keys_ex},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list action_entry[] = {
+	{TCA_ACT_KIND,    "pedit", sizeof("pedit"), NULL},
+	{TCA_ACT_OPTIONS, NULL, 0, pedit_opts},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list action_list[] = {
+	{1, NULL, 0, action_entry},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list matchall_opts[] = {
+	{TCA_MATCHALL_ACT, NULL, 0, action_list},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list filter_config[] = {
+	{TCA_OPTIONS, NULL, 0, matchall_opts},
+	{0, NULL, -1, NULL}
+};
+
+static uint8_t original[DATA_SIZE];
+static int file_fd = -1;
+static int listen_fd = -1;
+static int cli_fd = -1;
+static int acc_fd = -1;
+
+static void setup(void)
+{
+	struct sockaddr_in addr;
+	int i;
+
+	tst_setup_netns();
+	NETDEV_SET_STATE("lo", 1);
+
+	listen_fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_SETSOCKOPT_INT(listen_fd, SOL_SOCKET, SO_REUSEADDR, 1);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = htons(PORT);
+
+	SAFE_BIND(listen_fd, (struct sockaddr *)&addr, sizeof(addr));
+	SAFE_LISTEN(listen_fd, 1);
+
+	for (i = 0; i < DATA_SIZE; i++)
+		original[i] = (uint8_t)(i & 0xff);
+
+	memset(&pedit_sel_buf, 0, sizeof(pedit_sel_buf));
+	pedit_sel_buf.sel.nkeys = NKEYS;
+	pedit_sel_buf.sel.action = TC_ACT_PIPE;
+
+	/* Key 0: inflate IP IHL to 15 (push TCP header offset to 60) */
+	pedit_sel_buf.keys[0].off  = 0;
+	pedit_sel_buf.keys[0].val  = IHL_VALUE;
+	pedit_sel_buf.keys[0].mask = IHL_MASK;
+
+	/* Key 1: write marker via TCP-typed offset (past stale COW) */
+	pedit_sel_buf.keys[1].off  = MARKER_OFFSET;
+	pedit_sel_buf.keys[1].val  = MARKER_VALUE;
+	pedit_sel_buf.keys[1].mask = 0;
+}
+
+static void run(void)
+{
+	struct sockaddr_in addr;
+	uint8_t readback[DATA_SIZE];
+	off_t off = 0;
+	int wr_fd;
+
+	wr_fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
+	SAFE_WRITE(SAFE_WRITE_ALL, wr_fd, original, DATA_SIZE);
+	SAFE_CLOSE(wr_fd);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+
+	/*
+	 * Clean-slate clsact qdisc so no filter is active during the
+	 * TCP handshake (the IHL-inflating key would corrupt SYN/ACK).
+	 */
+	NETDEV_MAY_REMOVE_QDISC("lo", AF_UNSPEC, TC_H_CLSACT,
+				TC_H_MAKE(TC_H_CLSACT, 0), "clsact");
+	NETDEV_ADD_QDISC("lo", AF_UNSPEC, TC_H_CLSACT,
+			 TC_H_MAKE(TC_H_CLSACT, 0), "clsact", NULL);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = htons(PORT);
+
+	cli_fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_CONNECT(cli_fd, (struct sockaddr *)&addr, sizeof(addr));
+	acc_fd = SAFE_ACCEPT(listen_fd, NULL, NULL);
+
+	/* Arm the pedit filter AFTER the handshake completes */
+	NETDEV_ADD_TRAFFIC_FILTER("lo",
+				  TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_EGRESS),
+				  0, ETH_P_ALL, 1, "matchall",
+				  filter_config);
+
+	SAFE_SETSOCKOPT_INT(cli_fd, IPPROTO_TCP, TCP_NODELAY, 1);
+
+	/*
+	 * sendfile places page-cache pages in the skb. With
+	 * TCP_NODELAY the 4 KiB payload fits a single segment whose
+	 * egress path -- including the pedit action -- completes
+	 * synchronously inside dev_queue_xmit on loopback.
+	 */
+	if (sendfile(cli_fd, file_fd, &off, DATA_SIZE) < 0)
+		tst_brk(TBROK | TERRNO, "sendfile() failed");
+
+	SAFE_CLOSE(cli_fd);
+	cli_fd = -1;
+	SAFE_CLOSE(acc_fd);
+	acc_fd = -1;
+
+	/*
+	 * Read back through the same O_RDONLY fd that sendfile used.
+	 * sendfile with a non-NULL offset does not change the fd's
+	 * file position, so it is still at 0. Keeping the same fd
+	 * guarantees we hit the same page-cache pages.
+	 */
+	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_CLOSE(file_fd);
+	file_fd = -1;
+
+	if (memcmp(readback, original, DATA_SIZE) != 0)
+		tst_res(TFAIL,
+			"Page cache corrupted via act_pedit partial COW bypass");
+	else
+		tst_res(TPASS, "Page cache was not corrupted");
+
+	SAFE_UNLINK(TESTFILE);
+}
+
+static void cleanup(void)
+{
+	if (cli_fd != -1)
+		SAFE_CLOSE(cli_fd);
+
+	if (acc_fd != -1)
+		SAFE_CLOSE(acc_fd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+
+	if (listen_fd != -1)
+		SAFE_CLOSE(listen_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		"CONFIG_NET_SCH_INGRESS",
+		"CONFIG_NET_CLS_MATCHALL",
+		"CONFIG_NET_ACT_PEDIT",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "899ee91156e5"},
+		{"CVE", "2026-46331"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
