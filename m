Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33915C001DF
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 13:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7A9E3CE34D
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 15:28:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B5AE3CB64B
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 15:28:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C85BB14052EF
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 15:28:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81C331F8B0
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691155692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyDb3MleVObgbOmco7Kz8TqtEcMWw+qCOn1+QdISDhk=;
 b=0kWrfaFS2qZwJ9F8sg2b8M29TibvqmXx8jluINk+fFsKANyVF0aezIeQAVR2wFSi6/s5OF
 06m1ZDszkBiEO2g9CMKsu8x492ZrKqJvjG9uCtrURutOyKhv50m7gk1/sB0dVd5TSSldeg
 CgiC4kyjzf+xhODNXX2eXw9Lus0CCJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691155692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyDb3MleVObgbOmco7Kz8TqtEcMWw+qCOn1+QdISDhk=;
 b=zV/35PCMQi7DBgFYiqvWtU4DH8hzvqlmDWEXXPMjwshluOu+mi7iccob2HSjuebVI8O0OB
 EyFDdsW3nHnQthCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5406A133B5
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 13:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c3WuEez8zGR8FgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 04 Aug 2023 13:28:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Aug 2023 15:28:03 +0200
Message-ID: <20230804132811.24534-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727150013.31835-1-mdoucha@suse.cz>
References: <20230727150013.31835-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] Add test for CVE 2023-1829
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

Fixes #1053

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Fixed typo in .gitignore
- Removed unnecessary TCA_TCINDEX_ACT attribute tree from filter config
- Added credit for the original reproducer

Reproducer was tested on both affected and fixed SLE-15SP5 kernels.

 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/tcindex01.c | 141 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 testcases/cve/tcindex01.c

diff --git a/runtest/cve b/runtest/cve
index 7d1e84f89..f9b36a182 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -84,6 +84,7 @@ cve-2021-38604 mq_notify03
 cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
 cve-2022-23222 bpf_prog07
+cve-2023-1829 tcindex01
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 90e8b191c..3a2b2bed6 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -12,3 +12,4 @@ cve-2017-16939
 cve-2017-17053
 cve-2022-4378
 icmp_rate_limit01
+tcindex01
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
new file mode 100644
index 000000000..9bd7de9dd
--- /dev/null
+++ b/testcases/cve/tcindex01.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * CVE-2023-1829
+ *
+ * Test for use-after-free after removing tcindex traffic filter with certain
+ * parameters.
+ *
+ * Tcindex filter removed in:
+ *
+ *  commit 8c710f75256bb3cf05ac7b1672c82b92c43f3d28
+ *  Author: Jamal Hadi Salim <jhs@mojatatu.com>
+ *  Date:   Tue Feb 14 08:49:14 2023 -0500
+ *
+ *  net/sched: Retire tcindex classifier
+ */
+
+#include <linux/netlink.h>
+#include <linux/pkt_sched.h>
+#include <linux/pkt_cls.h>
+#include "tst_test.h"
+#include "tst_rtnetlink.h"
+#include "tst_netdevice.h"
+#include "lapi/sched.h"
+#include "lapi/if_ether.h"
+#include "lapi/rtnetlink.h"
+
+#define DEVNAME "ltp_dummy1"
+
+static const uint32_t qd_handle = TC_H_MAKE(1 << 16, 0);
+static const uint32_t clsid = TC_H_MAKE(1 << 16, 1);
+static const uint32_t shift = 10;
+static const uint16_t mask = 0xffff;
+
+/* rtnetlink payloads */
+static const struct tc_htb_glob qd_opt = {
+	.rate2quantum = 10,
+	.version = 3,
+	.defcls = 30
+};
+static struct tc_htb_opt cls_opt = {};
+
+/* htb qdisc and class options */
+static const struct tst_rtnl_attr_list qd_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+		{TCA_HTB_INIT, &qd_opt, sizeof(qd_opt), NULL},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+static const struct tst_rtnl_attr_list cls_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+		{TCA_HTB_PARMS, &cls_opt, sizeof(cls_opt), NULL},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+/* tcindex filter options */
+static const struct tst_rtnl_attr_list f_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+		{TCA_TCINDEX_MASK, &mask, sizeof(mask), NULL},
+		{TCA_TCINDEX_SHIFT, &shift, sizeof(shift), NULL},
+		{TCA_TCINDEX_CLASSID, &clsid, sizeof(clsid), NULL},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static void setup(void)
+{
+	tst_setup_netns();
+	NETDEV_ADD_DEVICE(DEVNAME, "dummy");
+
+	cls_opt.rate.rate = cls_opt.ceil.rate = 256000;
+	cls_opt.buffer = 1000000 * 1600 / cls_opt.rate.rate;
+	cls_opt.cbuffer = 1000000 * 1600 / cls_opt.ceil.rate;
+}
+
+static void run(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < 100; i++) {
+		NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle,
+			"htb", qd_config);
+		NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb",
+			cls_config);
+		NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
+			"tcindex", f_config);
+		NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
+			1, "tcindex");
+
+		/* Wait at least one jiffy for use-after-free */
+		usleep(10000);
+
+		NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle,
+			"htb");
+	}
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened (yet)");
+}
+
+static void cleanup(void)
+{
+	NETDEV_REMOVE_DEVICE(DEVNAME);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_VETH",
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		"CONFIG_NET_SCH_HTB",
+		"CONFIG_NET_CLS_TCINDEX",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "8c710f75256b"},
+		{"CVE", "2023-1829"},
+		{}
+	}
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
