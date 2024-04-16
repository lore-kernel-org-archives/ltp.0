Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B075C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713256581; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=aoXXt4HqFy7o4ABU6FvYs3V4Q9sqvzYA0MCszy+yz3k=;
 b=ik2Unx1+8N9M9HZ35wShdyhjfqWj3IA9kFBYPcMKlfp+HSOdVdqbzwbqYBRFg7FRu6l96
 aXLoyBj0Rf3eVdFqGAKxkaKPsY9N69fh2+5noYvtH8V+iOzfaTJUNfpx91u9B42Cy83Tck3
 l3fI1N5bJG3SKqwUtYsR353Cmf3Lc/o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEAEB3CFA90
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 10:36:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 672E83CFA81
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:35:59 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B32F600A5B
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713256559; x=1744792559;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lnytVn3RFcbvkTdAdw128QxK7/vCEwODMVK90ubqMAI=;
 b=pU+eBX9WlaJcvINKMoMA9rzViMmu4NbEe1L09IySYBYMknZ4hXG0HR+D
 noPfZROsc2oIPhY0BcJWTYLDyMQ6o+rQGl5vCgiLEGx4n4NZJws6AVklS
 avsMOWrnV8LBAtfv1zoaLuNR9MA8AtrRtfcSjjDkaPLECZr2hQBsz/Vr4
 oOW5lN7E+uMlh9M1ecvSacU48LYuphOVYNV2eAeo8C/z8MQVXHkzw+tZ8
 cShwnu/DpHWRWqhW1aNwagA4d87D3u3cfi7nzR5kyitIvnRRlIaz0iHBN
 HkNcuF4W9MQpatnRr5QJF2iKbfobSRbx9qlLqaiZ4cM8z0gd2T/Ods8Ya g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="155607426"
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; d="scan'208";a="155607426"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 17:35:55 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 78176C68B4
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:35:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AD9BE11C70
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:35:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 353DC6B5E9
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:35:52 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D92E11A000A;
 Tue, 16 Apr 2024 16:35:51 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 16 Apr 2024 04:01:41 -0400
Message-Id: <20240416080141.22616-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28324.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28324.006
X-TMASE-Result: 10--14.949700-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2tSuJfEWZSQfAXtykVcrvpN2FA7wK9mP9dgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDuWYSIzA/m69pYuGZa3i+E6qh5pv1eDPz5fau+Sc1iUTa9jb7ypNKp5VcX
 P3eMLfF/yPsndJnGNFHRfAWehAV7AfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCJ1gw8aZd/mU/CY
 buk1n1sdXKAZpMNY8FaIah/TcyTupNEOnMbeTr1
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] execve: Add negative test for execve
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative case for execve, when errno is ELOOP

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/execve/.gitignore |  1 +
 testcases/kernel/syscalls/execve/execve07.c | 51 +++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/execve/execve07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cb2c001a0..9578e991a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -210,6 +210,7 @@ execve03 execve03
 execve04 execve04
 execve05 execve05 -i 5 -n 32
 execve06 execve06
+execve07 execve07
 execvp01 execvp01
 execveat01 execveat01
 execveat02 execveat02
diff --git a/testcases/kernel/syscalls/execve/.gitignore b/testcases/kernel/syscalls/execve/.gitignore
index fee81faf7..881f75486 100644
--- a/testcases/kernel/syscalls/execve/.gitignore
+++ b/testcases/kernel/syscalls/execve/.gitignore
@@ -7,3 +7,4 @@
 /execve06
 /execve06_child
 /execve_child
+/execve07
diff --git a/testcases/kernel/syscalls/execve/execve07.c b/testcases/kernel/syscalls/execve/execve07.c
new file mode 100644
index 000000000..6571846b9
--- /dev/null
+++ b/testcases/kernel/syscalls/execve/execve07.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that execve(2) fails with
+ *
+ * - ELOOP when too many symbolic links are encountered in filename
+ */
+
+#include "tst_test.h"
+
+#define TEST_ELOOP "test_eloop"
+#define TEST_ELOOP2 "test_eloop2"
+
+static struct test_case_t {
+	char *filename;
+	int expected_errno;
+	int user;
+	char *desc;
+} tcases[] = {
+	{TEST_ELOOP, ELOOP, 0,
+		"too many symbolic links are encountered in filename"},
+};
+
+static void setup(void)
+{
+	SAFE_SYMLINK(TEST_ELOOP, TEST_ELOOP2);
+	SAFE_SYMLINK(TEST_ELOOP2, TEST_ELOOP);
+}
+
+static void verify_execve(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	char *argv[2] = {tc->filename, NULL};
+
+	TST_EXP_FAIL(execve(tc->filename, argv, NULL), tc->expected_errno,
+		"%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_execve,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
