Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0861CC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716279385; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=05ly0GBezRMw2LRCFDJVKwwb+3neIuZKoVal9aXPn1s=;
 b=YidObdyc5CQS4RQXOa7rK5mi3Q4fdkUci/iz5pdBRE+QZsc6uueHUJqH4RggadJC24GbB
 mt19eq4PpQ17hu/JUcKXsXj0MMmrWORxmwOLKP1Ew02+5Q2wTUmn4+IOLmMpkKRXvBc1Jwj
 T+nvrzNXxosOAzQOltGeAZwdkHD0S5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EECA3CFF64
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:16:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F58B3C02C0
 for <ltp@lists.linux.it>; Tue, 21 May 2024 10:16:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CEA060095E
 for <ltp@lists.linux.it>; Tue, 21 May 2024 10:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716279363; x=1747815363;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kGYBDPajtg3+1xhcokVmZh1O5A7em+5nN2H7NVx/tZM=;
 b=tXpf7cO56eYe1wd2DAhQNBRT2d7R0KPgEsmbxIAbztQMj/f/9dnqyyzm
 x2SGVBpzdwaoY6G3cFXiW/ydkgwJY4IWP8ljeIwk58sOoTNAkOYrC3Rd5
 dmQ4xO+AGXNJbJTm6VFotrMfeoVJBSXYFWTpRVjxwhE8I69MnDEMAZDLk
 Fd4elqNMJKiQSfZAj/j1heBn1IZGVAoRIhAdyBdY0BlLD+r17Afwjg2bS
 METlRj8iy9JqWZ70lnvFTayG+ksFUutLojDMecZcidCW85H59T/WeHvFR
 K+FNrLp9pUPXGB44ZVulK/5R8giBqXMThJRu9ENPBLTqpppMa1ZgfwkhH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="146541120"
X-IronPort-AV: E=Sophos;i="6.08,177,1712588400"; d="scan'208";a="146541120"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 17:15:59 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BCB81D64AB
 for <ltp@lists.linux.it>; Tue, 21 May 2024 17:15:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F0659A361B
 for <ltp@lists.linux.it>; Tue, 21 May 2024 17:15:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 858D320094ACE
 for <ltp@lists.linux.it>; Tue, 21 May 2024 17:15:56 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3044A1A0002;
 Tue, 21 May 2024 16:15:56 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 16:15:52 +0800
Message-Id: <20240521081552.2162-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28400.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28400.006
X-TMASE-Result: 10--14.840100-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiJSuJfEWZSQfDyjd/AizytB9v33UW8WNYDqWOQST6GEByxX
 wd9S2XGhF8NKa4AxCmDMau1T20usrlo8LOaXS5gWTuctSpiuWyU2ZWOmuJUS2VgLks93sG9t09D
 6Rw2zIrO+c1YW/zYo9lM67ebhB/uCoDlDgS6jzLTFVAV8vDjN/9DEMPvvoocvTPm/MsQarwOyuh
 piqaRnal/beMPdf762tBM/r/AC4T43KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7mXQZ
 LlZyPfv9VcQkIfy+x5Fo+fOu8Yjrbwq1Po0p2dBXwjihSrlWBo=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Subject: [LTP] [PATCH] request_key: Add negative tests for request_key
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative tests for request_key(), when errno is EFAULT or EPERM

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/request_key/.gitignore    |  1 +
 .../syscalls/request_key/request_key06.c      | 52 +++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/request_key06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3a28123a5..c04359fcd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1187,6 +1187,7 @@ request_key02 request_key02
 request_key03 request_key03
 request_key04 request_key04
 request_key05 request_key05
+request_key06 request_key06
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/testcases/kernel/syscalls/request_key/.gitignore b/testcases/kernel/syscalls/request_key/.gitignore
index e8dc1c570..6dcf613c7 100644
--- a/testcases/kernel/syscalls/request_key/.gitignore
+++ b/testcases/kernel/syscalls/request_key/.gitignore
@@ -3,3 +3,4 @@
 /request_key03
 /request_key04
 /request_key05
+/request_key06
diff --git a/testcases/kernel/syscalls/request_key/request_key06.c b/testcases/kernel/syscalls/request_key/request_key06.c
new file mode 100644
index 000000000..bd872867b
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key06.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that request_key(2) fails with
+ *
+ * - EFAULT when type points outside the process's accessible address space
+ * - EFAULT when description points outside the process's accessible address space
+ * - EFAULT when callout_info points outside the process's accessible address space
+ * - EPERM when type argument started with a period '.'
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static struct test_case_t {
+	char *type;
+	char *description;
+	char *callout_info;
+	key_serial_t dest_keyring;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{(char *)(-1), "description", NULL, KEY_SPEC_PROCESS_KEYRING, EFAULT,
+		"type points outside the process's accessible address space"},
+	{"type", (char *)(-1), NULL, KEY_SPEC_PROCESS_KEYRING, EFAULT,
+		"description points outside the process's accessible address space"},
+	{"type", "description", (char *)(-1), KEY_SPEC_PROCESS_KEYRING, EFAULT,
+		"callout_info points outside the process's accessible address space"},
+	{".type", "description", NULL, KEY_SPEC_PROCESS_KEYRING, EPERM,
+		"type argument started with a period '.'"},
+};
+
+static void verify_request_key(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	TST_EXP_FAIL2(request_key(tc->type, tc->description, tc->callout_info,
+		tc->dest_keyring),
+		tc->expected_errno,
+		"%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_request_key,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
