Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E39C433F5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925C061546
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 925C061546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E97633C87F7
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:07:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5EE13C0BB4
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BF34601CC1
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637132833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KHWwAlJB0Y6xZWNdBDW0kHA6WHBdt37NPgWJReIfQuQ=;
 b=N6T36BfR6dIIWiAfGQrGf8q4Reke6r32MQdggvpFi7/RX3BWKCu7fNVRfP18o4Uz+iiBG8
 Sji4g9iJUtFj83XJUzd1iyXmMg8v1FEVLFHPFLzXmu0rJBHz8YitkrfKAI7u4iqmSyc+lo
 fu43QOdDpSThLQHEI4JrHwjiExqgwCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-hQ2_Utg9NcC_BVFaiSNeyg-1; Wed, 17 Nov 2021 02:07:12 -0500
X-MC-Unique: hQ2_Utg9NcC_BVFaiSNeyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329AC102CB73;
 Wed, 17 Nov 2021 07:07:11 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 203B85F4E0;
 Wed, 17 Nov 2021 07:07:09 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 17 Nov 2021 15:07:06 +0800
Message-Id: <20211117070708.2174932-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in tst_test
 structure
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

Testcases for specific arch should be limited on that only being supported
platform to run, we now involve a .supported_archs to achieve this feature
in LTP library. All you need to run a test on the expected arch is to set
the '.supported_archs' array in the 'struct tst_test' to choose the required
arch list. e.g.

    .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}

This helps move the TCONF info from code to tst_test metadata as well.

And, we also export a struct tst_arch to save the system architecture
for using in the whole test cases.

    extern const struct tst_arch {
             char name[16];
             enum tst_arch_type type;
    } tst_arch;

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/c-test-api.txt | 36 +++++++++++++++++
 include/tst_arch.h | 39 +++++++++++++++++++
 include/tst_test.h |  7 ++++
 lib/tst_arch.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c     |  3 ++
 5 files changed, 181 insertions(+)
 create mode 100644 include/tst_arch.h
 create mode 100644 lib/tst_arch.c

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 3127018a4..64d0630ce 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2261,6 +2261,42 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+1.39 Testing on the specific architecture
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Testcases for specific arch should be limited on that only being supported
+platform to run, we now involve a .supported_archs to achieve this feature
+in LTP library. All you need to run a test on the expected arch is to set
+the '.supported_archs' array in the 'struct tst_test' to choose the required
+arch list. e.g.
+
+    .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}
+
+This helps move the TCONF info from code to tst_test metadata as well.
+
+And, we also export a struct tst_arch to save the system architecture for
+using in the whole test cases.
+
+    extern const struct tst_arch {
+             char name[16];
+             enum tst_arch_type type;
+    } tst_arch;
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static struct tst_test test = {
+       ...
+       .setup = setup,
+       .supported_archs = (const char *const []) {
+                 "x86_64",
+                 "ppc64",
+                 "s390x",
+                 NULL
+       },
+};
+-------------------------------------------------------------------------------
+
 2. Common problems
 ------------------
 
diff --git a/include/tst_arch.h b/include/tst_arch.h
new file mode 100644
index 000000000..4a9473c6f
--- /dev/null
+++ b/include/tst_arch.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2021 Li Wang <liwang@redhat.com>
+ */
+
+#ifndef TST_ARCH_H__
+#define TST_ARCH_H__
+
+enum tst_arch_type {
+	TST_UNKNOWN,
+	TST_X86,
+	TST_X86_64,
+	TST_IA64,
+	TST_PPC,
+	TST_PPC64,
+	TST_S390,
+	TST_S390X,
+	TST_ARM,
+	TST_AARCH64,
+	TST_SPARC,
+};
+
+/*
+ * This tst_arch is to save the system architecture for
+ * using in the whole testcase.
+ */
+extern const struct tst_arch {
+        char name[16];
+        enum tst_arch_type type;
+} tst_arch;
+
+/*
+ * Check if test platform is in the given arch list. If yes return 1,
+ * otherwise return 0.
+ *
+ * @archlist A NULL terminated array of architectures to support.
+ */
+int tst_is_on_arch(const char *const *archlist);
+
+#endif /* TST_ARCH_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 602ce3090..c06a4729b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -43,6 +43,7 @@
 #include "tst_fips.h"
 #include "tst_taint.h"
 #include "tst_memutils.h"
+#include "tst_arch.h"
 
 /*
  * Reports testcase result.
@@ -139,6 +140,12 @@ struct tst_test {
 
 	const char *min_kver;
 
+	/*
+	 * The supported_archs is a NULL terminated list of archs the test
+	 * does support.
+	 */
+	const char *const *supported_archs;
+
 	/* If set the test is compiled out */
 	const char *tconf_msg;
 
diff --git a/lib/tst_arch.c b/lib/tst_arch.c
new file mode 100644
index 000000000..f19802a03
--- /dev/null
+++ b/lib/tst_arch.c
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2021 Li Wang <liwang@redhat.com>
+ */
+
+#include <string.h>
+#include <stdlib.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_arch.h"
+#include "tst_test.h"
+
+const struct tst_arch tst_arch = {
+#if defined(__x86_64__)
+        .name = "x86_64",
+        .type = TST_X86_64,
+#elif defined(__i386__) || defined(__i586__) || defined(__i686__)
+        .name = "x86",
+        .type = TST_X86,
+#elif defined(__ia64__)
+        .name = "ia64",
+        .type = TST_IA64,
+#elif defined(__powerpc64__) || defined(__ppc64__)
+        .name = "ppc64",
+        .type = TST_PPC64,
+#elif defined(__powerpc__) || defined(__ppc__)
+        .name = "ppc",
+        .type = TST_PPC,
+#elif defined(__s390x__)
+        .name = "s390x",
+        .type = TST_S390X,
+#elif defined(__s390__)
+        .name = "s390",
+        .type = TST_S390,
+#elif defined(__aarch64__)
+        .name = "aarch64",
+        .type = TST_AARCH64,
+#elif defined(__arm__)
+        .name = "arm",
+        .type = TST_ARM,
+#elif defined(__sparc__)
+        .name = "sparc",
+        .type = TST_SPARC,
+#else
+        .name = "unknown",
+        .type = TST_UNKNOWN,
+#endif
+};
+
+static const char *const arch_type_list[] = {
+	"i386",
+	"i586",
+	"i686",
+	"x86_64",
+	"ia64",
+	"ppc",
+	"ppc64",
+	"s390",
+	"s390x",
+	"arm",
+	"aarch64",
+	"sparc",
+	NULL
+};
+
+static int is_valid_arch_name(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; arch_type_list[i]; i++) {
+		if (!strcmp(arch_type_list[i], name))
+			return 1;
+	}
+
+	return 0;
+}
+
+int tst_is_on_arch(const char *const *archlist)
+{
+	unsigned int i;
+
+	if (!archlist)
+		return 1;
+
+	for (i = 0; archlist[i]; i++) {
+		if (!is_valid_arch_name(archlist[i]))
+			tst_brk(TBROK, "%s is invalid arch, please reset!",
+					archlist[i]);
+	}
+
+	for (i = 0; archlist[i]; i++) {
+		if (!strcmp(tst_arch.name, archlist[i]))
+			return 1;
+	}
+
+	return 0;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d7f9e0f97..a79275722 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -976,6 +976,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
+		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
+
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
