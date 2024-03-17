Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D74C54E67
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 09:39:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64D583CFC41
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 10:39:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FB913CE6E5
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A4CB71A0196B
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710668350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NM0LHA2lJ0sdsejRmlfsTbV5gJl80MCfC7OGsnCbG/c=;
 b=OygQLAf837YQo0IOW1eFu7/Ktmi8DZS9HPLaXnay0ZxWvuHkVeUWFxswHTxPBIi1KDeNBA
 3k5tYi8ueKXZQADJKdPJ1hSfGHHHhhILi0RvaZueCGO9rM+45+Ik05CH5/HiFhXQ7pTALD
 ZaD4/hQfYSQ5dYw2ovD4NM33JhyAMQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-0_G_u9qRNrC68DpSby3MMA-1; Sun, 17 Mar 2024 05:39:08 -0400
X-MC-Unique: 0_G_u9qRNrC68DpSby3MMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66CE811E81
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 09:39:07 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7280200AFFC
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 09:39:06 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 17 Mar 2024 17:38:59 +0800
Message-Id: <20240317093901.3212684-2-liwang@redhat.com>
In-Reply-To: <20240317093901.3212684-1-liwang@redhat.com>
References: <20240317093901.3212684-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] kconfig: add funtion to parse /proc/cmdline
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

A new structure tst_kcmdline_var is defined to hold a command-line
argument's key and a fixed-size value. Furthermore, function
tst_kcmdline_parse is added to the corresponding .c file, which
reads from /proc/cmdline, parses the command-line arguments, and
populates the tst_kcmdline_var array with the obtained key-value
pairs, ensuring safe file operations and buffer size checks.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_kconfig.h             | 29 ++++++++++++++
 lib/newlib_tests/test_kconfig03.c | 40 +++++++++++++++++++
 lib/tst_kconfig.c                 | 66 +++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 lib/newlib_tests/test_kconfig03.c

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 8b24a8380..bbb899784 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -6,6 +6,8 @@
 #ifndef TST_KCONFIG_H__
 #define TST_KCONFIG_H__
 
+#include <stdbool.h>
+
 /**
  * Initialization helper macro for struct tst_kconfig_var. Requires <string.h>
  */
@@ -64,4 +66,31 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
  */
 int tst_kconfig_check(const char *const kconfigs[]);
 
+/**
+ * Macro to initialize a tst_kcmdline_var structure with a specified parameter
+ * name and an empty value. This is useful for setting up an array of parameter
+ * structures before parsing the actual command-line arguments.
+ */
+#define TST_KCMDLINE_INIT(paraname) { \
+	.key = paraname, \
+	.value = "", \
+	.found = false \
+}
+
+/**
+ * Structure for storing command-line parameter key and its corresponding value
+ */
+struct tst_kcmdline_var {
+	const char *key;
+	char value[128];
+	bool found;
+};
+
+/**
+ * Parses command-line parameters from /proc/cmdline and stores them in params array.
+ * params: The array of tst_kcmdline_var structures to be filled with parsed key-value pairs.
+ * params_len: The length of the params array, indicating how many parameters to parse.
+ */
+void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/newlib_tests/test_kconfig03.c b/lib/newlib_tests/test_kconfig03.c
new file mode 100644
index 000000000..937c2b29c
--- /dev/null
+++ b/lib/newlib_tests/test_kconfig03.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Li Wang <liwang@redhat.com>
+ */
+
+#include "tst_test.h"
+#include "tst_kconfig.h"
+
+static struct tst_kcmdline_var params[] = {
+	TST_KCMDLINE_INIT("BOOT_IMAGE"),
+	TST_KCMDLINE_INIT("root"),
+	TST_KCMDLINE_INIT("foo")
+};
+
+static void do_test(void)
+{
+	int i, N;
+
+	N = (int) ARRAY_SIZE(params);
+
+	tst_kcmdline_parse(params, N);
+
+	for (i = 0; i < N; i++) {
+		if (params[i].found) {
+			if (params[i].value)
+				tst_res(TPASS, "params[%d] = {%s, %s}", i, params[i].key, params[i].value);
+			else
+				tst_res(TPASS, "params[%d] = {%s, no value}", i, params[i].key);
+		} else {
+			if (!strcmp(params[i].key, "foo"))
+				tst_res(TPASS, "%s is not found in /proc/cmdline", params[i].key);
+			else
+				tst_res(TFAIL, "%s is not found in /proc/cmdline", params[i].key);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 595ea4b09..e16ca1400 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -14,6 +14,7 @@
 #include "tst_private.h"
 #include "tst_kconfig.h"
 #include "tst_bool_expr.h"
+#include "tst_safe_stdio.h"
 
 static int kconfig_skip_check(void)
 {
@@ -565,3 +566,68 @@ char tst_kconfig_get(const char *confname)
 
 	return var.choice;
 }
+
+void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len)
+{
+	char buf[128], line[512];
+	size_t b_pos = 0,l_pos =0, i;
+	int var_id = -1;
+
+	FILE *f = SAFE_FOPEN("/proc/cmdline", "r");
+
+	if (fgets(line, sizeof(line), f) == NULL) {
+		SAFE_FCLOSE(f);
+		tst_brk(TBROK, "Failed to read /proc/cmdline");
+	}
+
+	for (l_pos = 0; line[l_pos] != '\0'; l_pos++) {
+		char c = line[l_pos];
+
+		switch (c) {
+		case '=':
+			buf[b_pos] = '\0';
+			for (i = 0; i < params_len; i++) {
+				if (strcmp(buf, params[i].key) == 0) {
+					var_id = (int)i;
+					params[i].found = true;
+				}
+			}
+
+			b_pos = 0;
+		break;
+		case ' ':
+		case '\n':
+			buf[b_pos] = '\0';
+			if (var_id >= 0 && var_id < (int)params_len)
+				strcpy(params[var_id].value, buf);
+
+			var_id = -1;
+			b_pos = 0;
+		break;
+		default:
+			if (b_pos + 1 >= sizeof(buf)) {
+				tst_res(TWARN, "Buffer overflowed while parsing /proc/cmdline");
+				while (line[l_pos] != '\0' && line[l_pos] != ' ' && line[l_pos] != '\n')
+					l_pos++;
+
+				var_id = -1;
+				b_pos = 0;
+
+				if (line[l_pos] != '\0')
+					l_pos--;
+			} else {
+				buf[b_pos++] = c;
+			}
+		break;
+		}
+	}
+
+	for (i = 0; i < params_len; i++) {
+		if (params[i].found)
+			tst_res(TINFO, "%s is found in /proc/cmdline", params[i].key);
+		else
+			tst_res(TINFO, "%s is not found in /proc/cmdline", params[i].key);
+	}
+
+	SAFE_FCLOSE(f);
+}
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
