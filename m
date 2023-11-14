Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AE9C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 12:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F3013CE4F8
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 13:31:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27353CC27C
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9B571000995
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F7A3218F6;
 Tue, 14 Nov 2023 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699965102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIX0EZVEmbOe9hYj0aUXBcpQk767m8/Q6FfnauFb9+8=;
 b=lYWfPCyFbre0Qn1SUCed33V80HTePZqaxjAhh5tJnM58p1MJXVbDjpK81BzepPRwLXqRps
 wQH2zYVmhC/kgpYsAEgxteGwJWWw58rDfXXbdn92TMTv50QEsB+mky/pe64ez5EJSnvT8S
 7MCFHNLX5epCl6Ce7g927ec9KnDmzJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699965102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIX0EZVEmbOe9hYj0aUXBcpQk767m8/Q6FfnauFb9+8=;
 b=X27x5QJZG3L8zeXUhVjfsob1fHlHlixjBuaOITRArag0ToXA/J4+P5F75gGCq+OhwiS478
 TQ4oosldGAGINzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14E2313ADB;
 Tue, 14 Nov 2023 12:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KBhSBK5oU2UibAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 14 Nov 2023 12:31:42 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Tue, 14 Nov 2023 13:31:26 +0100
Message-ID: <20231114123140.1144-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114123140.1144-1-mdoucha@suse.cz>
References: <20231114123140.1144-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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
---

Changes since v1: New patch

 testcases/network/iptables/Makefile |   2 +-
 testcases/network/iptables/nft02.c  | 211 ++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 testcases/network/iptables/nft02.c

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
index 000000000..4cea7ce64
--- /dev/null
+++ b/testcases/network/iptables/nft02.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC
+ * Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
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
+#include <linux/netfilter/nf_tables.h>
+#include <linux/netfilter/nfnetlink.h>
+#include "tst_test.h"
+#include "tst_netlink.h"
+
+#define TABNAME "ltp_table1"
+#define CHAINNAME "ltp_chain1"
+
+static const uint8_t rule_proto = IPPROTO_TCP;
+static const uint32_t rule_dport = 80;
+
+static uint32_t chain_id;
+static uint32_t cmp_sreg;
+static uint32_t cmp_op;
+static struct tst_netlink_context *ctx;
+
+/* Table creation config */
+static const struct tst_netlink_attr_list table_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+/* Chain creation and deletion config */
+static const struct tst_netlink_attr_list newchain_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_CHAIN_NAME, CHAINNAME, strlen(CHAINNAME) + 1, NULL},
+	{NFTA_CHAIN_ID, &chain_id, sizeof(chain_id), NULL},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list delchain_config[] = {
+	{NFTA_TABLE_NAME, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_CHAIN_NAME, CHAINNAME, strlen(CHAINNAME) + 1, NULL},
+	{0, NULL, -1, NULL}
+};
+
+/* Rule creation config */
+static const struct tst_netlink_attr_list rule_data_config1[] = {
+	{NFTA_CMP_SREG, &cmp_sreg, sizeof(cmp_sreg), NULL},
+	{NFTA_CMP_OP, &cmp_op, sizeof(cmp_op), NULL},
+	{NFTA_CMP_DATA, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_DATA_VALUE, &rule_proto, sizeof(rule_proto), NULL},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_data_config2[] = {
+	{NFTA_CMP_SREG, &cmp_sreg, sizeof(cmp_sreg), NULL},
+	{NFTA_CMP_OP, &cmp_op, sizeof(cmp_op), NULL},
+	{NFTA_CMP_DATA, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_DATA_VALUE, &rule_dport, sizeof(rule_dport), NULL},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_expr_config[] = {
+	{NFTA_LIST_ELEM, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_EXPR_NAME, "cmp", 4, NULL},
+		{NFTA_EXPR_DATA, NULL, 0, rule_data_config1},
+		{0, NULL, -1, NULL}
+	}},
+	{NFTA_LIST_ELEM, NULL, 0, (const struct tst_netlink_attr_list[]) {
+		{NFTA_EXPR_NAME, "cmp", 4, NULL},
+		{NFTA_EXPR_DATA, NULL, 0, rule_data_config2},
+		{0, NULL, -1, NULL}
+	}},
+	{0, NULL, -1, NULL}
+};
+
+static const struct tst_netlink_attr_list rule_config[] = {
+	{NFTA_RULE_EXPRESSIONS, NULL, 0, rule_expr_config},
+	{NFTA_RULE_TABLE, TABNAME, strlen(TABNAME) + 1, NULL},
+	{NFTA_RULE_CHAIN_ID, &chain_id, sizeof(chain_id), NULL},
+	{0, NULL, -1, NULL}
+};
+
+static void setup(void)
+{
+	tst_setup_netns();
+
+	chain_id = htonl(77);
+	cmp_sreg = htonl(NFT_REG_1);
+	cmp_op = htonl(NFT_CMP_EQ);
+}
+
+static void run(void)
+{
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
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_ACK;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, table_config);
+
+	/* Add chain */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWCHAIN;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_ACK;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, newchain_config);
+
+	/* Delete the above chain */
+	header.nlmsg_type = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_DELCHAIN;
+	header.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	nfpayload.nfgen_family = NFPROTO_IPV4;
+	nfpayload.res_id = htons(0);
+	NETLINK_ADD_MESSAGE(ctx, &header, &nfpayload, sizeof(nfpayload));
+	NETLINK_ADD_ATTR_LIST(ctx, delchain_config);
+
+	/* Add rule to deleted chain */
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
+	NETLINK_SEND_VALIDATE(ctx);
+	NETLINK_DESTROY_CONTEXT(ctx);
+	ctx = NULL;
+
+	/* Wait for kernel page fault error */
+	usleep(100000);
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
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
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
