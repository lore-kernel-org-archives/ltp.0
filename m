Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCF4C433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 02:15:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC19F6134F
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 02:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC19F6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9463C75DE
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 03:15:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247033C006A
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 03:14:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65D4F600A15
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 03:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636337695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZEpTBS1b0kJfgIl5yAjstdln+OcEfMeq5Z3bwmP/VUM=;
 b=RS3ZOfIJeaMR5AaY5PtMEps3zOybESZg1boEAEeZjLuy5N4JPatS80Wciy5j2kFo2L84Xq
 o+IkG1e3IH8HDiZ3rXoPKtdCU8sYTlSbAdR5x0oB/x79NmmpE03d/f6apBkCCUiEqhbvAf
 HFo42KzUra4r4fVc2jkJo4Nx3wJFRr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-ZgPb23zVNDC8VDCiTi4aiA-1; Sun, 07 Nov 2021 21:14:54 -0500
X-MC-Unique: ZgPb23zVNDC8VDCiTi4aiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481C8102CB2B
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 02:14:53 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 782C15C1A1
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 02:14:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  8 Nov 2021 10:14:48 +0800
Message-Id: <20211108021450.1460819-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib: adding .supported_archs field in tst_test
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

    extern struct arch {
             char name[16];
             enum tst_arch_type type;
    } tst_arch;

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/c-test-api.txt |  36 +++++++++++++++
 include/tst_arch.h |  39 ++++++++++++++++
 include/tst_test.h |  10 +++++
 lib/tst_arch.c     | 108 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 include/tst_arch.h
 create mode 100644 lib/tst_arch.c

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 3127018a4..5e32b7075 100644
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
+    extern struct arch {
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
index 000000000..784c3093b
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
+	TST_I386,
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
+extern struct arch {
+	char name[16];
+	enum tst_arch_type type;
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
index 3dcb45de0..7611520ee 100644
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
 
@@ -316,6 +323,9 @@ static struct tst_test test;
 
 int main(int argc, char *argv[])
 {
+	if (!tst_is_on_arch(test.supported_archs))
+		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
+
 	tst_run_tcases(argc, argv, &test);
 }
 
diff --git a/lib/tst_arch.c b/lib/tst_arch.c
new file mode 100644
index 000000000..ae5817075
--- /dev/null
+++ b/lib/tst_arch.c
@@ -0,0 +1,108 @@
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
+struct arch tst_arch;
+
+static const char *const arch_type_list[] = {
+	"i386",
+	"x86",
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
+static int is_matched_arch(const char *arch, const char *name)
+{
+	if (strcmp(arch, name) == 0)
+		return 1;
+
+	return 0;
+}
+
+static int is_valid_arch_name(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; arch_type_list[i]; i++) {
+		if (is_matched_arch(arch_type_list[i], name))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void get_system_arch(void)
+{
+#if defined(__i386__)
+	strcpy(tst_arch.name, "i386");
+	tst_arch.type = TST_I386;
+#elif defined(__x86__)
+	strcpy(tst_arch.name, "x86");
+	tst_arch.type = TST_X86;
+#elif defined(__x86_64__)
+	strcpy(tst_arch.name, "x86_64");
+	tst_arch.type = TST_X86_64;
+#elif defined(__ia64__)
+	strcpy(tst_arch.name, "ia64");
+	tst_arch.type = TST_IA64;
+#elif defined(__powerpc__)
+	strcpy(tst_arch.name, "ppc");
+	tst_arch.type = TST_PPC;
+#elif defined(__powerpc64__)
+	strcpy(tst_arch.name, "ppc64");
+	tst_arch.type = TST_PPC64;
+#elif defined(__s390x__)
+	strcpy(tst_arch.name, "s390x");
+	tst_arch.type = TST_S390X;
+#elif defined(__s390__)
+	strcpy(tst_arch.name, "s390");
+	tst_arch.type = TST_S390;
+#elif defined(__arm__)
+	strcpy(tst_arch.name, "s390x");
+	tst_arch.type = TST_ARM;
+#elif defined(__aarch64__)
+	strcpy(tst_arch.name, "aarch64");
+	tst_arch.type = TST_AARCH64;
+#elif defined(__sparc__)
+	strcpy(tst_arch.name, "sparc");
+	tst_arch.type = TST_SPARC;
+#endif
+}
+
+int tst_is_on_arch(const char *const *archlist)
+{
+	unsigned int i;
+
+	get_system_arch();
+
+	if (archlist == NULL)
+		return 1;
+
+	for (i = 0; archlist[i]; i++) {
+		if (!is_valid_arch_name(archlist[i]))
+			tst_brk(TBROK, "%s is invalid arch, please reset!",
+					archlist[i]);
+	}
+
+	for (i = 0; archlist[i]; i++) {
+		if (is_matched_arch(tst_arch.name, archlist[i]))
+			return 1;
+	}
+
+	return 0;
+}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
