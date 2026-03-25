Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E154E109C032
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:26:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 600683E525E
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:26:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B5E83E5C7A
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC14D20116B
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6784D244;
 Wed, 25 Mar 2026 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpLgrW++8iuqCubIwxfNamBOdOGZK/B5FR3Ua2Wsrr4=;
 b=J5XTFK8dolaqgzOBuwY3bq4CKnT/EDJBM31+eKGi0vVQtFbUWg28hLItnkl9aC4GF/gLZ7
 u29DoE8llC1Cu7EY/GtJxKMHoBp4KvaXKEQHZAoH+eCfbDKbdb/7dzDcv/us4f3jVhuD60
 0uzXY1UJD+Pw+OuMsC3KkTKbSSmOcLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpLgrW++8iuqCubIwxfNamBOdOGZK/B5FR3Ua2Wsrr4=;
 b=IIGy+kQg9LO2d5vYm8UpavA/vyxvo72hDyQtaKcwmPRFvNwcprMniFEr8rwb8sIjUioa8T
 Zgj0WJUTJVIwxiBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpLgrW++8iuqCubIwxfNamBOdOGZK/B5FR3Ua2Wsrr4=;
 b=J5XTFK8dolaqgzOBuwY3bq4CKnT/EDJBM31+eKGi0vVQtFbUWg28hLItnkl9aC4GF/gLZ7
 u29DoE8llC1Cu7EY/GtJxKMHoBp4KvaXKEQHZAoH+eCfbDKbdb/7dzDcv/us4f3jVhuD60
 0uzXY1UJD+Pw+OuMsC3KkTKbSSmOcLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpLgrW++8iuqCubIwxfNamBOdOGZK/B5FR3Ua2Wsrr4=;
 b=IIGy+kQg9LO2d5vYm8UpavA/vyxvo72hDyQtaKcwmPRFvNwcprMniFEr8rwb8sIjUioa8T
 Zgj0WJUTJVIwxiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4009344483;
 Wed, 25 Mar 2026 15:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0IHrDW/+w2nhBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 15:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 16:25:35 +0100
MIME-Version: 1.0
Message-Id: <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
In-Reply-To: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774452334; l=7236;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=t6TRpxCohboi/szgSf5UcaFzTXKd9T//Kagx+pEsr/0=;
 b=8MW698TtApFPo952jlJX9uIh4EvlCudldP0vcxz25IqkCVqVORo8+HOOJ3lfhDPpiyHnbNnF2
 riR2lDF3z84BJtM8I4g5Dp6qQegRo5fo8/aisIS+3FD2MFzAmPB2EH4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
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

Test for use-after-free in RDMA UCMA triggered by racing CREATE_ID,
BIND_IP, and LISTEN operations. Three threads concurrently issue
these commands to /dev/infiniband/rdma_cm and the test checks for
kernel taint (KASAN use-after-free detection).

The bug was fixed by kernel commit 5fe23f262e05
("ucma: fix a use-after-free in ucma_resolve_ip()").

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                               |   1 +
 testcases/kernel/device-drivers/Makefile          |   1 +
 testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
 testcases/kernel/device-drivers/rdma/Makefile     |   7 +
 testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
 5 files changed, 218 insertions(+)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 78f00d305fea10367fb4fd2845f25dd151a833ea..dcc3c0a44fb52a968f91a52758dbd43a3ce7a9ec 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -3,6 +3,7 @@ kmsg01 kmsg01
 fw_load fw_load
 rtc01 rtc01
 rtc02 rtc02
+ucma_uaf01 ucma_uaf01
 block_dev block_dev
 tpci tpci
 tbio tbio
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 229a50683f5f629904ff591daa6fcd4f1c35fdf1..538df555395bf21062906ffa4125da4c767c1e24 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -11,6 +11,7 @@ SUBDIRS		:= acpi \
 		   locking \
 		   pci \
 		   rcu \
+		   rdma \
 		   rtc \
 		   tbio \
 		   uaccess \
diff --git a/testcases/kernel/device-drivers/rdma/.gitignore b/testcases/kernel/device-drivers/rdma/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..399ea290e4f9abd6b66800b21f4aea3eb33d3799
--- /dev/null
+++ b/testcases/kernel/device-drivers/rdma/.gitignore
@@ -0,0 +1 @@
+/ucma_uaf01
diff --git a/testcases/kernel/device-drivers/rdma/Makefile b/testcases/kernel/device-drivers/rdma/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..5df01972aeab257b6ef24a928204b6b722c1cdef
--- /dev/null
+++ b/testcases/kernel/device-drivers/rdma/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/rdma/ucma_uaf01.c b/testcases/kernel/device-drivers/rdma/ucma_uaf01.c
new file mode 100644
index 0000000000000000000000000000000000000000..313e2aee0ea0114ce37f006eca93ea66d86ddeea
--- /dev/null
+++ b/testcases/kernel/device-drivers/rdma/ucma_uaf01.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Test for use-after-free in RDMA UCMA triggered by concurrent CREATE_ID,
+ * BIND_IP, and LISTEN operations via /dev/infiniband/rdma_cm.
+ *
+ * Requires root to open /dev/infiniband/rdma_cm.
+ *
+ * Three threads race to create, bind, and listen on RDMA connection manager
+ * IDs. On vulnerable kernels, this triggers a use-after-free in
+ * cma_listen_on_all() detected by KASAN.
+ *
+ * Based on a syzbot reproducer:
+ * syzbot+db1c219466daac1083df@syzkaller.appspotmail.com
+ *
+ * Fixed in:
+ *
+ *  commit 5fe23f262e05
+ *  ucma: fix a use-after-free in ucma_resolve_ip()
+ */
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/rdma_user_cm.h"
+
+#define RDMA_CM_DEV "/dev/infiniband/rdma_cm"
+
+static int cmfd = -1;
+static volatile uint32_t shared_id;
+static volatile int stop_threads;
+
+static void destroy_id(uint32_t id)
+{
+	ssize_t ret;
+
+	struct {
+		struct rdma_ucm_cmd_hdr hdr;
+		struct rdma_ucm_destroy_id destroy;
+	} msg = {
+		.hdr = {
+			.cmd = RDMA_USER_CM_CMD_DESTROY_ID,
+			.out = sizeof(struct rdma_ucm_create_id_resp),
+		},
+		.destroy = {
+			.id = id,
+		},
+	};
+	struct rdma_ucm_create_id_resp resp;
+
+	msg.destroy.response = (uintptr_t)&resp;
+
+	/* Errors expected due to racing with stale IDs */
+	ret = write(cmfd, &msg, sizeof(msg));
+	(void)ret;
+}
+
+static void *thread_create(void *arg)
+{
+	uint32_t id, prev_id = 0;
+	int has_prev = 0;
+
+	while (!stop_threads) {
+		struct {
+			struct rdma_ucm_cmd_hdr hdr;
+			struct rdma_ucm_create_id create;
+		} msg = {
+			.hdr = {
+				.cmd = RDMA_USER_CM_CMD_CREATE_ID,
+				.out = sizeof(id),
+			},
+			.create = {
+				.response = (uintptr_t)&id,
+				.ps = RDMA_PS_IPOIB,
+			},
+		};
+
+		if (write(cmfd, &msg, sizeof(msg)) > 0) {
+			if (has_prev)
+				destroy_id(prev_id);
+			prev_id = id;
+			has_prev = 1;
+			shared_id = id;
+		}
+	}
+
+	if (has_prev)
+		destroy_id(prev_id);
+
+	return arg;
+}
+
+static void *thread_bind(void *arg)
+{
+	ssize_t ret;
+
+	while (!stop_threads) {
+		struct {
+			struct rdma_ucm_cmd_hdr hdr;
+			struct rdma_ucm_bind_ip bind;
+		} msg = {
+			.hdr = {
+				.cmd = RDMA_USER_CM_CMD_BIND_IP,
+			},
+			.bind = {
+				.addr = {
+					.sin6_family = AF_INET6,
+					.sin6_addr = {
+						.s6_addr = { 0xff },
+					},
+				},
+				.id = shared_id,
+			},
+		};
+
+		/* Errors expected due to racing with stale IDs */
+		ret = write(cmfd, &msg, sizeof(msg));
+		(void)ret;
+	}
+
+	return arg;
+}
+
+static void *thread_listen(void *arg)
+{
+	ssize_t ret;
+
+	while (!stop_threads) {
+		struct {
+			struct rdma_ucm_cmd_hdr hdr;
+			struct rdma_ucm_listen listen;
+		} msg = {
+			.hdr = {
+				.cmd = RDMA_USER_CM_CMD_LISTEN,
+			},
+			.listen = {
+				.id = shared_id,
+			},
+		};
+
+		/* Errors expected due to racing with stale IDs */
+		ret = write(cmfd, &msg, sizeof(msg));
+		(void)ret;
+	}
+
+	return arg;
+}
+
+static void setup(void)
+{
+	cmfd = open(RDMA_CM_DEV, O_WRONLY);
+	if (cmfd < 0) {
+		if (errno == ENOENT || errno == ENXIO)
+			tst_brk(TCONF, RDMA_CM_DEV " not available");
+		tst_brk(TBROK | TERRNO, "open(" RDMA_CM_DEV ")");
+	}
+}
+
+static void cleanup(void)
+{
+	if (cmfd != -1)
+		SAFE_CLOSE(cmfd);
+}
+
+static void run(void)
+{
+	pthread_t threads[3];
+
+	stop_threads = 0;
+
+	SAFE_PTHREAD_CREATE(&threads[0], NULL, thread_create, NULL);
+	SAFE_PTHREAD_CREATE(&threads[1], NULL, thread_bind, NULL);
+	SAFE_PTHREAD_CREATE(&threads[2], NULL, thread_listen, NULL);
+
+	while (tst_remaining_runtime())
+		sleep(1);
+
+	stop_threads = 1;
+
+	SAFE_PTHREAD_JOIN(threads[0], NULL);
+	SAFE_PTHREAD_JOIN(threads[1], NULL);
+	SAFE_PTHREAD_JOIN(threads[2], NULL);
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Kernel is vulnerable (use-after-free in UCMA)");
+	else
+		tst_res(TPASS, "No kernel taint detected");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.runtime = 300,
+	.needs_root = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_INFINIBAND",
+		"CONFIG_INFINIBAND_USER_ACCESS",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5fe23f262e05"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
