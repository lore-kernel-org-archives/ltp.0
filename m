Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3A3C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 09:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACEDC3C8D6B
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:08:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9016E3C7616
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DEA11001447
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D6BEA1F3C4;
 Tue, 14 Dec 2021 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639472852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guU6ZkVHfPw2mroxfiCghi8Q20dMQFo1exH4uIx8mUA=;
 b=Szhpd3SLIn8ldDKpxVOtIvdxjvTfgJ+5BIet3qt31cGEPYZhShNU4hqXS2MdGnDFy0uupj
 QbQt7LBfbo7gyq/tuNWtM0APWrFZsAghApcCH4xB6nY/ARa+5WOzbOR9L8s6kcNRT4ZCNr
 eLvAd6pbQ4KhpGdvR5E5xFfGKifLa88=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id A2F03A3B81;
 Tue, 14 Dec 2021 09:07:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 09:06:47 +0000
Message-Id: <20211214090648.14292-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214090648.14292-1-rpalethorpe@suse.com>
References: <20211214090648.14292-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] memcontrol01: Import first memcg kselftest
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

This is a conversion of the first test in the memory cgroup
kselftest. There will be a number of (more important) tests to follow;
i.e. memcontrol02...

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/controllers                           |  3 +
 testcases/kernel/controllers/memcg/.gitignore |  1 +
 .../kernel/controllers/memcg/memcontrol01.c   | 77 +++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol01.c

diff --git a/runtest/controllers b/runtest/controllers
index e3d0243f1..2b41a94d3 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -16,6 +16,9 @@ memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
 memcg_stress		memcg_stress_test.sh
 memcg_control		memcg_control_test.sh
 
+# kselftest ports
+memcontrol01 memcontrol01
+
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
 cgroup_fj_function_cpu cgroup_fj_function.sh cpu
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index c0b6d0714..c3565f85c 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -5,3 +5,4 @@
 /regression/memcg_test_3
 /regression/memcg_test_4
 /stress/memcg_process_stress
+memcontrol01
diff --git a/testcases/kernel/controllers/memcg/memcontrol01.c b/testcases/kernel/controllers/memcg/memcontrol01.c
new file mode 100644
index 000000000..6ef8e04d9
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol01.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*\
+ *
+ * [Description]
+ *
+ * Conversion of first kselftest in cgroup/test_memcontrol.c.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+
+static const struct tst_cgroup_group *cg_test;
+static struct tst_cgroup_group *parent, *child;
+static struct tst_cgroup_group *parent2, *child2;
+
+/*
+ * This test creates two nested cgroups with and without enabling
+ * the memory controller.
+ *
+ * The LTP API automatically adds controllers to subtree_control when
+ * a child cgroup is added. So unlike the kselftest we remove the
+ * controller again.
+ */
+static void test_memcg_subtree_control(void)
+{
+	parent = tst_cgroup_group_mk(cg_test, "memcg_test_0");
+	child = tst_cgroup_group_mk(parent, "memcg_test_1");
+	parent2 = tst_cgroup_group_mk(cg_test, "memcg_test_2");
+	child2 = tst_cgroup_group_mk(parent2, "memcg_test_3");
+
+	SAFE_CGROUP_PRINT(parent2, "cgroup.subtree_control", "-memory");
+
+	TST_EXP_POSITIVE(
+		SAFE_CGROUP_OCCURSIN(child, "cgroup.controllers", "memory"),
+		"child should have memory controller");
+	TST_EXP_POSITIVE(
+		!SAFE_CGROUP_OCCURSIN(child2, "cgroup.controllers", "memory"),
+		"child2 should not have memory controller");
+
+	child2 = tst_cgroup_group_rm(child2);
+	parent2 = tst_cgroup_group_rm(parent2);
+	child = tst_cgroup_group_rm(child);
+	parent = tst_cgroup_group_rm(parent);
+}
+
+static void setup(void)
+{
+	tst_cgroup_require("memory", NULL);
+	cg_test = tst_cgroup_get_test_group();
+
+	if (TST_CGROUP_VER(cg_test, "memory") == TST_CGROUP_V1)
+		tst_brk(TCONF, "V1 controllers do not have subtree control");
+}
+
+static void cleanup(void)
+{
+	if (child2)
+		child2 = tst_cgroup_group_rm(child2);
+	if (parent2)
+		parent2 = tst_cgroup_group_rm(parent2);
+	if (child)
+		child = tst_cgroup_group_rm(child);
+	if (parent)
+		parent = tst_cgroup_group_rm(parent);
+
+	tst_cgroup_cleanup();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_memcg_subtree_control,
+};
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
