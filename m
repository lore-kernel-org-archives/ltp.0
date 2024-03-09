Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65001C54E41
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 09:02:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E743CE945
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 10:02:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41363CE95E
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 10:01:34 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EBCB14001F4
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 10:01:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709974892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYS+0Amn8UStDS7g2pSSjW9mivRcTE5C9kD9M2qGNnc=;
 b=QWE+gSfKLcl/22XxhLq4mTWG9vxROsVoqZIP1gqufEjAYxqkV47LPqpAyVrkV7Nbu72iwM
 fxfqpja3NiwH3CbnCRAQnGWxsxnsmDNGHWvI+Mtzxn0eILM/rB4rkCRGJRoBxEX6hcmT5q
 PkUjLYuLJmbRUv1AyxRSqRJdBs8seTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-9uYUeEHqODWiqDxpfQzXmw-1; Sat,
 09 Mar 2024 04:01:20 -0500
X-MC-Unique: 9uYUeEHqODWiqDxpfQzXmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 126923C02747;
 Sat,  9 Mar 2024 09:01:20 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F92C37F6;
 Sat,  9 Mar 2024 09:01:18 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat,  9 Mar 2024 17:01:11 +0800
Message-Id: <20240309090113.3121235-2-liwang@redhat.com>
In-Reply-To: <20240309090113.3121235-1-liwang@redhat.com>
References: <20240309090113.3121235-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] kconfig: add funtion to parse /proc/cmdline
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
 include/tst_kconfig.h | 23 ++++++++++++++++++++++
 lib/tst_kconfig.c     | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 8b24a8380..a8cbfb786 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -64,4 +64,27 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
  */
 int tst_kconfig_check(const char *const kconfigs[]);
 
+/**
+ * Macro to initialize a tst_kcmdline_var structure with a specified parameter
+ * name and an empty value. This is useful for setting up an array of parameter
+ * structures before parsing the actual command-line arguments.
+ */
+#define TST_KCMDLINE_INIT(paraname) { \
+	.key = paraname, \
+	.value = "" \
+}
+
+/* Structure for storing command-line parameter key and its corresponding value */
+struct tst_kcmdline_var {
+	const char *key;
+	char value[128];
+};
+
+/**
+ * Parses command-line parameters from /proc/cmdline and stores them in params array
+ * params: The array of tst_kcmdline_var structures to be filled with parsed key-value pairs
+ * params_len: The length of the params array, indicating how many parameters to parse
+ */
+void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 595ea4b09..c200dd261 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -14,6 +14,7 @@
 #include "tst_private.h"
 #include "tst_kconfig.h"
 #include "tst_bool_expr.h"
+#include "tst_safe_stdio.h"
 
 static int kconfig_skip_check(void)
 {
@@ -565,3 +566,47 @@ char tst_kconfig_get(const char *confname)
 
 	return var.choice;
 }
+
+void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len) {
+	char buf[128];
+	size_t buf_pos = 0, i;
+	int var_id = -1, c;
+
+	FILE *f = SAFE_FOPEN("/proc/cmdline", "r");
+
+	while ((c = fgetc(f)) != EOF) {
+		switch (c) {
+		case '=':
+			buf[buf_pos] = '\0';
+			for (i = 0; i < params_len; i++) {
+				if (strcmp(buf, params[i].key) == 0)
+					var_id = (int)i;
+			}
+
+			buf_pos = 0;
+		break;
+		case ' ':
+		case '\n':
+			buf[buf_pos] = '\0';
+			if (var_id >= 0 && var_id < (int)params_len)
+				strcpy(params[var_id].value, buf);
+
+			var_id = -1;
+			buf_pos = 0;
+		break;
+		default:
+			if (buf_pos + 1  >= sizeof(buf)) {
+				tst_res(TWARN, "Buffer overflowed while parsing /proc/cmdline");
+				while ((c = fgetc(f)) != EOF && c != ' ' && c != '\n');
+
+				var_id = -1;
+				buf_pos = 0;
+			}
+
+			buf[buf_pos++] = (char)c;
+		break;
+		}
+	}
+
+	SAFE_FCLOSE(f);
+}
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
