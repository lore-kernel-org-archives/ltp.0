Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F3CECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 735B13CAC38
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:21:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AB403CA900
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:21:34 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23C9714012C8
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:21:30 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 28EDLJCa012872;
 Wed, 14 Sep 2022 21:21:19 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.12.119) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Sep 2022
 21:21:18 +0800
From: Dylan Jhong <dylan@andestech.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Sep 2022 21:19:50 +0800
Message-ID: <20220914131950.1783054-1-dylan@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.12.119]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 28EDLJCa012872
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kernel/uevent: Adjust the number of uevents
 dynamically in uevent02
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
Cc: alankao@andestech.com, minachou@andestech.com, dminus@andestech.com,
 x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When CONFIG_SMP is not selected, CONFIG_RPS will not be enabled. Causes the
kernel to not create rx queues in sysfs[*1] when creating tun devices.
uevent02 will check if the rx queue exists, so we have to dynamically adjust
the number of uevents to pass this testcase.

[*1]: https://github.com/torvalds/linux/blob/3245cb65fd91cd514801bf91f5a3066d562f0ac4/net/core/net-sysfs.c#L1109

Signed-off-by: Dylan Jhong <dylan@andestech.com>
---
 testcases/kernel/uevents/uevent02.c | 146 ++++++++++++++--------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index ce0cf757d..059320f1c 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -19,11 +19,71 @@
 #include <linux/if_tun.h>
 
 #include "tst_test.h"
+#include "tst_private.h"
 
 #include "uevent.h"
 
 #define TUN_PATH "/dev/net/tun"
 
+#define MAX_UEVENT 7
+
+struct uevent_desc add = {
+	.msg = "add@/devices/virtual/net/ltp-tun0",
+	.value_cnt = 4,
+	.values = (const char*[]) {
+		"ACTION=add",
+		"DEVPATH=/devices/virtual/net/ltp-tun0",
+		"SUBSYSTEM=net",
+		"INTERFACE=ltp-tun0",
+	}
+};
+struct uevent_desc add_rx = {
+	.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
+	.value_cnt = 3,
+	.values = (const char*[]) {
+		"ACTION=add",
+		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
+		"SUBSYSTEM=queues",
+	}
+};
+struct uevent_desc add_tx = {
+	.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
+	.value_cnt = 3,
+	.values = (const char*[]) {
+		"ACTION=add",
+		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
+		"SUBSYSTEM=queues",
+	}
+};
+struct uevent_desc rem_rx = {
+	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
+	.value_cnt = 3,
+	.values = (const char*[]) {
+		"ACTION=remove",
+		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
+		"SUBSYSTEM=queues",
+	}
+};
+struct uevent_desc rem_tx = {
+	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
+	.value_cnt = 3,
+	.values = (const char*[]) {
+		"ACTION=remove",
+		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
+		"SUBSYSTEM=queues",
+	}
+};
+struct uevent_desc rem = {
+	.msg = "remove@/devices/virtual/net/ltp-tun0",
+	.value_cnt = 4,
+	.values = (const char*[]) {
+		"ACTION=remove",
+		"DEVPATH=/devices/virtual/net/ltp-tun0",
+		"SUBSYSTEM=net",
+		"INTERFACE=ltp-tun0",
+	}
+};
+
 static void generate_tun_uevents(void)
 {
 	int fd = SAFE_OPEN(TUN_PATH, O_RDWR);
@@ -42,79 +102,19 @@ static void generate_tun_uevents(void)
 
 static void verify_uevent(void)
 {
-	int pid, fd;
-
-	struct uevent_desc add = {
-		.msg = "add@/devices/virtual/net/ltp-tun0",
-		.value_cnt = 4,
-		.values = (const char*[]) {
-			"ACTION=add",
-			"DEVPATH=/devices/virtual/net/ltp-tun0",
-			"SUBSYSTEM=net",
-			"INTERFACE=ltp-tun0",
-		}
-	};
-
-	struct uevent_desc add_rx = {
-		.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
-		.value_cnt = 3,
-		.values = (const char*[]) {
-			"ACTION=add",
-			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
-			"SUBSYSTEM=queues",
-		}
-	};
-
-	struct uevent_desc add_tx = {
-		.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
-		.value_cnt = 3,
-		.values = (const char*[]) {
-			"ACTION=add",
-			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
-			"SUBSYSTEM=queues",
-		}
-	};
-
-	struct uevent_desc rem_rx = {
-		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
-		.value_cnt = 3,
-		.values = (const char*[]) {
-			"ACTION=remove",
-			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
-			"SUBSYSTEM=queues",
-		}
-	};
-
-	struct uevent_desc rem_tx = {
-		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
-		.value_cnt = 3,
-		.values = (const char*[]) {
-			"ACTION=remove",
-			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
-			"SUBSYSTEM=queues",
-		}
-	};
-
-	struct uevent_desc rem = {
-		.msg = "remove@/devices/virtual/net/ltp-tun0",
-		.value_cnt = 4,
-		.values = (const char*[]) {
-			"ACTION=remove",
-			"DEVPATH=/devices/virtual/net/ltp-tun0",
-			"SUBSYSTEM=net",
-			"INTERFACE=ltp-tun0",
-		}
-	};
-
-	const struct uevent_desc *const uevents[] = {
-		&add,
-		&add_rx,
-		&add_tx,
-		&rem_rx,
-		&rem_tx,
-		&rem,
-		NULL
-	};
+	const struct uevent_desc *uevents[MAX_UEVENT];
+	int pid, fd, i = 0;
+	int has_RPS = tst_kconfig_get("CONFIG_RPS");
+
+	uevents[i++] = &add;
+	if (has_RPS)
+		uevents[i++] = &add_rx;
+	uevents[i++] = &add_tx;
+	if (has_RPS)
+		uevents[i++] = &rem_rx;
+	uevents[i++] = &rem_tx;
+	uevents[i++] = &rem;
+	uevents[i++] = NULL;
 
 	pid = SAFE_FORK();
 	if (!pid) {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
