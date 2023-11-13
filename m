Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F45C4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 06:13:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4EA43CE5B9
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 07:13:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21BAB3CE011
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 07:13:03 +0100 (CET)
Received: from smtp.priv.miraclelinux.com
 (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E46006009E5
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 07:13:00 +0100 (CET)
Received: from localhost.localdomain (21A0035i-SL7B460.priv.miraclelinux.com
 [10.2.1.161])
 by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 9834414007D;
 Mon, 13 Nov 2023 15:12:53 +0900 (JST)
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
To: ltp@lists.linux.it
Date: Mon, 13 Nov 2023 15:02:38 +0900
Message-Id: <080648612d41f8f09275c40beafe625d5e3614ca.1699753620.git.souta.kawahara@miraclelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add test for CVE-2023-31248 and Add AUTOCONF rule
 for nftables tests.
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

Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
---
 ci/debian.cross-compile.sh     |   1 +
 ci/debian.sh                   |   1 +
 ci/fedora.sh                   |   1 +
 ci/tumbleweed.sh               |   1 +
 configure.ac                   |   2 +
 include/mk/config.mk.in        |   2 +
 m4/ltp-libnftnl.m4             |   9 ++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/Makefile         |   2 +
 testcases/cve/cve-2023-31248.c | 200 +++++++++++++++++++++++++++++++++
 11 files changed, 221 insertions(+)
 create mode 100644 m4/ltp-libnftnl.m4
 create mode 100644 testcases/cve/cve-2023-31248.c

diff --git a/ci/debian.cross-compile.sh b/ci/debian.cross-compile.sh
index 95cf11da2..6b71bb428 100755
--- a/ci/debian.cross-compile.sh
+++ b/ci/debian.cross-compile.sh
@@ -21,4 +21,5 @@ apt install -y --no-install-recommends \
 	gcc-${gcc_arch}-linux-gnu \
 	libc6-dev-${ARCH}-cross \
 	libmnl-dev:$ARCH \
+	libnftnl-dev:$ARCH \
 	libtirpc-dev:$ARCH
diff --git a/ci/debian.sh b/ci/debian.sh
index 96b55a35b..33b69c2b5 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -38,6 +38,7 @@ $apt \
 	libkeyutils-dev \
 	libkeyutils1 \
 	libmnl-dev \
+	libnftnl-dev \
 	libnuma-dev \
 	libnuma1 \
 	libselinux1-dev \
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 623dbb5cb..887bcf7f0 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -24,4 +24,5 @@ $yum \
 
 # CentOS 8 fixes
 $yum libmnl-devel || $yum libmnl
+$yum libnftnl-devel || $yum libnftnl
 $yum rubygem-asciidoctor || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 42d62c0e0..ca9923e7f 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -21,6 +21,7 @@ $zyp \
 	libaio-devel \
 	libcap-devel \
 	libmnl-devel \
+	libnftnl-devel \
 	libnuma-devel \
 	libopenssl-devel \
 	libselinux-devel \
diff --git a/configure.ac b/configure.ac
index 3fa350f9e..7da51c16e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -382,6 +382,7 @@ LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
+LTP_CHECK_LIBNFTNL
 LTP_CHECK_LINUX_PTRACE
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_NOMMU_LINUX
@@ -441,6 +442,7 @@ libaio: ${have_libaio:-no} (aio: ${have_aio:-no})
 libcap: $cap_libs (newer: ${has_newer_libcap:-no})
 libcrypto: ${have_libcrypto:-no} (sha: ${have_sha:-no})
 libmnl: ${have_libmnl:-yes}
+libnftnl: ${have_libnftnl:-yes}
 libnuma: ${have_libnuma:-no} (headers: ${have_numa_headers:-yes}, v2 headers: ${have_numa_headers_v2:-no})
 libtirpc: ${have_libtirpc:-no}
 glibc SUN-RPC: ${have_rpc_glibc:-no}
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 145b887fa..5d6794025 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -58,6 +58,8 @@ KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 HAVE_FTS_H		:= @HAVE_FTS_H@
 LIBMNL_LIBS		:= @LIBMNL_LIBS@
 LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
+LIBNFTNL_LIBS		:= @LIBNFTNL_LIBS@
+LIBNFTNL_CFLAGS		:= @LIBNFTNL_CFLAGS@
 
 prefix			:= @prefix@
 
diff --git a/m4/ltp-libnftnl.m4 b/m4/ltp-libnftnl.m4
new file mode 100644
index 000000000..ae0cadb65
--- /dev/null
+++ b/m4/ltp-libnftnl.m4
@@ -0,0 +1,9 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2023 Cybertrust Japan Co., Ltd.
+dnl Author: Souta Kawahara <souta.kawahara@miraclelinux.com>
+
+AC_DEFUN([LTP_CHECK_LIBNFTNL], [
+    PKG_CHECK_MODULES([LIBNFTNL], [libnftnl >= 1.1.8], [
+        AC_DEFINE([HAVE_LIBNFTNL], [1], [Define to 1 if you have libnftnl library and headers])
+	], [have_libnftnl=no])
+])
diff --git a/runtest/cve b/runtest/cve
index 569558af2..1aa61a9b6 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -86,6 +86,7 @@ cve-2022-2590 dirtyc0w_shmem
 cve-2022-23222 bpf_prog07
 cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
+cve-2023-31248 cve-2023-31248
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 3a2b2bed6..c02b75c78 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -13,3 +13,4 @@ cve-2017-17053
 cve-2022-4378
 icmp_rate_limit01
 tcindex01
+cve-2023-31248
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 01b9b9ccb..698f5fe26 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -13,6 +13,8 @@ cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
 cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
+cve-2023-31248: CFLAGS += $(LIBMNL_CFLAGS) $(LIBNFTNL_CFLAGS)
+cve-2023-31248: LDLIBS += $(LIBMNL_LIBS) $(LIBNFTNL_LIBS)
 
 ifneq ($(ANDROID),1)
 cve-2014-0196:  LDLIBS += -lutil
diff --git a/testcases/cve/cve-2023-31248.c b/testcases/cve/cve-2023-31248.c
new file mode 100644
index 000000000..4b2fd5cc5
--- /dev/null
+++ b/testcases/cve/cve-2023-31248.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Cybertrust Japan Co., Ltd.
+ * Author: Souta Kawahara <soute.kawahara@miraclelinux.com>
+ */
+
+/*\
+ * CVE-2023-31248.
+ *
+ * This test add a rule to jump to a deleted chain.
+ * If vulnerable, the operation passed and the rule eventually leads to use-after-free.
+ *
+ * The bug was fixed in:
+ *
+ *  commit 515ad530795c118f012539ed76d02bacfd426d89
+ *  Author: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
+ *  Date:   Wed Jul 05 09:12:55 2023 -0300
+ *
+ *  netfilter: nf_tables: do not ignore genmask when looking up chain by id
+ */
+
+#include "tst_test.h"
+
+#if defined(HAVE_LIBMNL) && defined(HAVE_LIBNFTNL)
+
+#include <sched.h>
+#include <arpa/inet.h>
+
+#include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
+
+#include <libmnl/libmnl.h>
+#include <libnftnl/table.h>
+#include <libnftnl/chain.h>
+#include <libnftnl/rule.h>
+#include <libnftnl/expr.h>
+
+#define TABLE_NAME "ltp_table"
+#define VICTIM_CHAIN_NAME "victim_chain"
+#define TRIGGER_CHAIN_NAME "trigger_chain"
+#define VICTIM_ID 0x1111
+
+static struct mnl_socket *nl;
+static struct nftnl_table *table;
+static struct nftnl_chain *victim_chain, *trigger_chain;
+static struct nftnl_rule *rule;
+static struct nftnl_expr *expr;
+
+static inline int callbacks(const struct mnl_socket *nl, char *buf, size_t sbuf, int seq, int rseq)
+{
+	int ret;
+
+	while (rseq < seq) {
+		ret = mnl_socket_recvfrom(nl, buf, sbuf);
+		if (ret <= 0)
+			return ret;
+		ret = mnl_cb_run(buf, ret, rseq, mnl_socket_get_portid(nl), NULL, NULL);
+		if (ret < 0)
+			return ret;
+		rseq++;
+	}
+	return 0;
+}
+
+static void setup(void)
+{
+	tst_setup_netns();
+
+	nl = mnl_socket_open(NETLINK_NETFILTER);
+	if (nl == NULL)
+		tst_brk(TBROK, "mnl_socket_open faild (errno=%d): %s", errno, strerror(errno));
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
+		tst_brk(TBROK, "mnl_socket_bind faild (errno=%d): %s", errno, strerror(errno));
+
+	table = nftnl_table_alloc();
+	if (table == NULL)
+		tst_brk(TBROK, "nftnl_table_alloc faild (errno=%d): %s", errno, strerror(errno));
+	victim_chain = nftnl_chain_alloc();
+	if (victim_chain == NULL)
+		tst_brk(TBROK, "nftnl_chain_alloc faild (errno=%d): %s", errno, strerror(errno));
+	trigger_chain = nftnl_chain_alloc();
+	if (trigger_chain == NULL)
+		tst_brk(TBROK, "nftnl_chain_alloc faild (errno=%d): %s", errno, strerror(errno));
+	rule = nftnl_rule_alloc();
+	if (rule == NULL)
+		tst_brk(TBROK, "nftnl_rule_alloc faild (errno=%d): %s", errno, strerror(errno));
+	expr = nftnl_expr_alloc("immediate");
+	if (expr == NULL)
+		tst_brk(TBROK, "nftnl_expr_alloc faild (errno=%d): %s", errno, strerror(errno));
+}
+
+static void run(void)
+{
+	struct mnl_nlmsg_batch *batch;
+	struct nlmsghdr *nlh;
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	int ret, rseq, seq = 0;
+
+	nftnl_table_set_u32(table, NFTNL_TABLE_FAMILY, NFPROTO_IPV4);
+	nftnl_table_set_str(table, NFTNL_TABLE_NAME, TABLE_NAME);
+
+	nftnl_chain_set_str(victim_chain, NFTNL_CHAIN_TABLE, TABLE_NAME);
+	nftnl_chain_set_str(victim_chain, NFTNL_CHAIN_NAME, VICTIM_CHAIN_NAME);
+	nftnl_chain_set_u32(victim_chain, NFTNL_CHAIN_ID, VICTIM_ID);
+
+	nftnl_chain_set_str(trigger_chain, NFTNL_CHAIN_TABLE, TABLE_NAME);
+	nftnl_chain_set_str(trigger_chain, NFTNL_CHAIN_NAME, TRIGGER_CHAIN_NAME);
+
+	nftnl_expr_set_u32(expr, NFTNL_EXPR_IMM_DREG, NFT_REG_VERDICT);
+	nftnl_expr_set_u32(expr, NFTNL_EXPR_IMM_VERDICT, NFT_GOTO);
+	nftnl_expr_set_u32(expr, NFTNL_EXPR_IMM_CHAIN_ID, VICTIM_ID);
+
+	nftnl_rule_set_u32(rule, NFTNL_RULE_FAMILY, NFPROTO_IPV4);
+	nftnl_rule_set_str(rule, NFTNL_RULE_TABLE, TABLE_NAME);
+	nftnl_rule_set_str(rule, NFTNL_RULE_CHAIN, TRIGGER_CHAIN_NAME);
+
+	nftnl_rule_add_expr(rule, expr);
+
+	batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
+	nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
+	mnl_nlmsg_batch_next(batch);
+	rseq = seq;
+
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+			NFT_MSG_NEWTABLE, NFPROTO_IPV4, NLM_F_ACK | NLM_F_CREATE, seq++);
+	nftnl_table_nlmsg_build_payload(nlh, table);
+	mnl_nlmsg_batch_next(batch);
+
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+			NFT_MSG_NEWCHAIN, NFPROTO_IPV4, NLM_F_ACK | NLM_F_CREATE, seq++);
+	nftnl_chain_nlmsg_build_payload(nlh, victim_chain);
+	mnl_nlmsg_batch_next(batch);
+
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+			NFT_MSG_DELCHAIN, NFPROTO_IPV4, NLM_F_ACK, seq++);
+	nftnl_chain_nlmsg_build_payload(nlh, victim_chain);
+	mnl_nlmsg_batch_next(batch);
+
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+			NFT_MSG_NEWCHAIN, NFPROTO_IPV4, NLM_F_ACK | NLM_F_CREATE, seq++);
+	nftnl_chain_nlmsg_build_payload(nlh, trigger_chain);
+	mnl_nlmsg_batch_next(batch);
+
+	nlh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
+			NFT_MSG_NEWRULE, NFPROTO_IPV4, NLM_F_ACK | NLM_F_CREATE, seq++);
+	nftnl_rule_nlmsg_build_payload(nlh, rule);
+	mnl_nlmsg_batch_next(batch);
+
+	nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq);
+	mnl_nlmsg_batch_next(batch);
+
+	ret = mnl_socket_sendto(nl, mnl_nlmsg_batch_head(batch), mnl_nlmsg_batch_size(batch));
+	if (ret == -1)
+		tst_brk(TBROK, "mnl_socket_sendto faild (errno=%d): %s", errno, strerror(errno));
+	mnl_nlmsg_batch_stop(batch);
+
+	TEST(callbacks(nl, buf, sizeof(buf), seq, rseq));
+	if ((TST_RET < 0) && (TST_ERR == ENOENT))
+		tst_res(TPASS | TTERRNO, "The operation expectedly failed");
+	else
+		tst_res(TFAIL, "The operation unexpectedly passed");
+}
+
+static void cleanup(void)
+{
+	if (rule)
+		nftnl_rule_free(rule);
+	if (trigger_chain)
+		nftnl_chain_free(trigger_chain);
+	if (victim_chain)
+		nftnl_chain_free(victim_chain);
+	if (table)
+		nftnl_table_free(table);
+
+	if (nl)
+		mnl_socket_close(nl);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_NF_TABLES",
+		"CONFIG_NF_TABLES_IPV4",
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "515ad530795c"},
+		{"CVE", "2023-31248"},
+		{}
+	}
+};
+
+#else
+	TST_TEST_TCONF("libmnl and libnftnl(>= 1.1.8) libraries and headers are required.");
+#endif /* HAVE_LIBMNL && HAVE_LIBNFTNL */
+
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
