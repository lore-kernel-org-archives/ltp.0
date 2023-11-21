Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62864C61D90
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 15:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78D313CC3C9
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 16:43:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28E2E3C8206
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13D7020175B
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10EB021959;
 Tue, 21 Nov 2023 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700581356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mraC6vglWZPBH7WITVJyn1s31xT8Qt42oW4z/olYJQY=;
 b=WF0lOkWz/i2zvZfZYKT72BVflosdJtMFR4UZ84dppCANn4mWu0HdnGcmH66UVf+jPOj1E/
 TKunSGVrh9ZpXSpzBUczIKuAYeKAbTN98jexGpXMQCcGHlEWevBqvXMKIav/YcjGeMfrgB
 0MQYSFFeX2gZXhEBrWljN6bJ3bjNSYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700581356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mraC6vglWZPBH7WITVJyn1s31xT8Qt42oW4z/olYJQY=;
 b=YcDIW4vGnYNopX1pAopA0rU+LP/y2M0B/wDT5q4hYvnkz2WdNHN8X/gWjRjCecwKoi8Y/4
 +3FWholpIUxO6BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF1C139FD;
 Tue, 21 Nov 2023 15:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YGG+NOvPXGX+fQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 21 Nov 2023 15:42:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Nov 2023 16:42:26 +0100
Message-ID: <20231121154234.24668-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121154234.24668-1-mdoucha@suse.cz>
References: <20231121154234.24668-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] Add test for CVE 2023-31248
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

Fixes #1058

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Co-Developed-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
---

Changes since v1: New patch
Changes since v2:
- Use netfilter GOTO rule jumping into the deleted chain
- Check for ENOENT error instead of kernel taint

Changes since v3: Code style and typo fixes

The test does not use any external utilities so I've decided not to add it
to the net.tcp_cmds runfile.

 runtest/cve                           |   1 +
 testcases/network/iptables/.gitignore |   1 +
 testcases/network/iptables/Makefile   |   2 +-
 testcases/network/iptables/nft02.c    | 216 ++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 testcases/network/iptables/.gitignore
 create mode 100644 testcases/network/iptables/nft02.c

diff --git a/runtest/cve b/runtest/cve
index 569558af2..1d1d87597 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -86,6 +86,7 @@ cve-2022-2590 dirtyc0w_shmem
 cve-2022-23222 bpf_prog07
 cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
+cve-2023-31248 nft02
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/network/iptables/.gitignore b/testcases/network/iptables/.gitignore
new file mode 100644
index 000000000..0f47a7313
--- /dev/null
+++ b/testcases/network/iptables/.gitignore
@@ -0,0 +1 @@
+nft02
diff --git a/testcases/network/iptables/Makefile b/testcases/network/iptables/Makefile
index 1b42f25db..02e228cbc 100644
--- a/testcases/network/iptables/Makefile
+++ b/testcases/network/iptables/Makefile
@@ -5,7 +5,7 @@
 
 top_srcdir		?= ../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
diff --git a/testcases/network/iptables/nft02.c b/testcases/network/iptables/nft02.c
new file mode 100644
index 000000000..8b7248c69
--- /dev/null
+++ b/testcases/network/iptables/nft02.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * CVE-2023-31248
+ *
+ * Test for use-after-free when adding a new rule to a chain deleted
+ * in the same netlink message batch.
+ *
+ * Kernel bug fixed in:
+ *
+ *  commit 515ad530795c118f012539ed76d02bacfd426d89
+ *  Author: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
+ *  Date:   Wed Jul 5 09:12:55 2023 -0300
+ *
+ *  netfilter: nf_tables: do not ignore genmask when looking up chain by id
+ */
+
+#include <linux/netlink.h>
+#include <linux/tcp.h>
+#include <arpa/inet.h>
+#include <linux/netfilter.h>
+#include "lapi/nf_tables.h"
+#include <linux/netfilter/nfnetlink.h>
+#include "tst_test.h"
+#include "tst_netlink.h"
+
+#define TABNAME "ltp_table1"
+#define SRCCHAIN "ltp_chain_src"
+#define DESTCHAIN "ltp_chain_dest"
+#define DESTCHAIN_ID 77
+
+static uint32_t chain_id;
+static uint32_t imm_dreg, imm_verdict;
+static struct tst_netlink_context *ctx;
+
+/* Table creation config */
+static const struct tst_netlink_attr_list table_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+/* Chain creation and deletion config */
+static const struct tst_netlink_attr_list destchain_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_CHAIN_NAME, DESTCHAIN, strlen(DESTCHAIN) + 1, NULL},
+	{NFTA_CHAIN_ID, &chain_id, sizeof(chain_id), NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list delchain_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_CHAIN_NAME, DESTCHAIN, strlen(DESTCHAIN) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list srcchain_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_CHAIN_NAME, SRCCHAIN, strlen(SRCCHAIN) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+/* Rule creation config */
+static const struct tst_netlink_attr_list rule_verdict_config[] = {
+	{NFTA_VERDICT_CODE, &imm_verdict, sizeof(imm_verdict), NULL},
+	{NFTA_VERDICT_CHAIN_ID, &chain_id, sizeof(chain_id), NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_data_config[] = {
+	{NFTA_IMMEDIATE_DREG, &imm_dreg, sizeof(imm_dreg), NULL},
+	{NFTA_IMMEDIATE_DATA, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_DATA_VERDICT, NULL, 0, rule_verdict_config},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_expr_config[] = {
+	{NFTA_LIST_ELEM, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_EXPR_NAME, "immediate", 10, NULL},
+		{NFTA_EXPR_DATA, NULL, 0, rule_data_config},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_config[] = {
+	{NFTA_RULE_EXPRESSIONS, NULL, 0, rule_expr_config},
+	{NFTA_RULE_TABLE, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_RULE_CHAIN, SRCCHAIN, strlen(SRCCHAIN) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+static void setup(void)
+{
+	tst_setup_netns();
+
+	chain_id = htonl(DESTCHAIN_ID);
+	imm_dreg = htonl(NFT_REG_VERDICT);
+	imm_verdict = htonl(NFT_GOTO);
+}
+
+static void run(void)
+{
+	int ret;
+	struct nlmsghdr header;
+	struct nfgenmsg nfpayload;
+
+	memset(&header, 0, sizeof(header));
+	memset(&nfpayload, 0, sizeof(nfpayload));
+	nfpayload.version = NFNETLINK_V0;
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_NETFILTER);
+
+	/* Start netfilter batch */
+	header.nlmsg_type = NFNL_MSG_BATCH_BEGIN;
+	header.nlmsg_flags = NLM_F_REQUEST;
+	nfpayload.nfgen_family = AF_UNSPEC;
+	nfpayload.res_id = htons(NFNL_SUBSYS_NFTABLES);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+
+	/* Add table */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWTABLE;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, table_config);
+
+	/* Add destination chain */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWCHAIN;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, destchain_config);
+
+	/* Delete destination chain */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_DELCHAIN;
+	header.nlmsg_flags = NLM_F_REQUEST;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, delchain_config);
+
+	/* Add source chain */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWCHAIN;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, srcchain_config);
+
+	/* Add rule to source chain. Require ACK and check for ENOENT error. */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWRULE;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_APPEND | NLM_F_CREATE |
+		NLM_F_ACK;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, rule_config);
+
+	/* End batch */
+	header.nlmsg_type = NFNL_MSG_BATCH_END;
+	header.nlmsg_flags = NLM_F_REQUEST;
+	nfpayload.nfgen_family = AF_UNSPEC;
+	nfpayload.res_id = htons(NFNL_SUBSYS_NFTABLES);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+
+	ret = NETLINK_SEND_VALIDATE(ctx);
+	TST_ERR = tst_netlink_errno;
+	NETLINK_DESTROY_CONTEXT(ctx);
+	ctx = NULL;
+
+	if (ret)
+		tst_res(TFAIL, "Netfilter chain list is corrupted");
+	else if (TST_ERR == ENOENT)
+		tst_res(TPASS, "Deleted netfilter chain cannot be referenced");
+	else if (TST_ERR == EOPNOTSUPP || TST_ERR == EINVAL)
+		tst_brk(TCONF, "Test requires unavailable netfilter features");
+	else
+		tst_brk(TBROK | TTERRNO, "Unknown nfnetlink error");
+}
+
+static void cleanup(void)
+{
+	NETLINK_DESTROY_CONTEXT(ctx);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NF_TABLES",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "515ad530795c"},
+		{"CVE", "2023-31248"},
+		{}
+	}
+};
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
