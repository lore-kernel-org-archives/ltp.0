Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935C1C54E41
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 04:52:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C333C3D186E
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 05:52:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF1893CE9A1
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 05:52:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 27ACC6012A8
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 05:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709873557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2bmZCMyJ3r1KuNoM+8VN3DinZ01T5lory1u+IW4r3PM=;
 b=hzzCdixeW6xy/fkcZPlmyCLGgZbjEP9MhYc3Q7Q0OKevU3A+OwY3YazmPRf9SeKVXRcuPJ
 xHf2WhVxhuX+7XWWIphFPDMd7Ubz0GR220OWGjC1eVVwdxRBJ8yBhtRSX4+UNTRzuqxWYM
 BlzWpU9KhyERxM7T0hIigps3LU+VAoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-T8lAsqi_NiCfHf0Oz7g0CQ-1; Thu, 07 Mar 2024 23:52:35 -0500
X-MC-Unique: T8lAsqi_NiCfHf0Oz7g0CQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 226528007A2
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 04:52:35 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ACA0492BDC
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 04:52:33 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  8 Mar 2024 12:52:28 +0800
Message-Id: <20240308045230.3106549-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] kconfig: add funtion to parse /proc/cmdline
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

In tst_kconfig.c, it adds the tst_kcmdline_parse function to
read and parse command-line parameters from /proc/cmdline.
This function tokenizes the command line, matches keys with
the provided parameter array, and stores the associated values.
The update enhances the testing framework's ability to handle
kernel configuration parameters dynamically.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_kconfig.h | 23 +++++++++++++++++++++++
 lib/tst_kconfig.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 8b24a8380..0ecf2c0d1 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -64,4 +64,27 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
  */
 int tst_kconfig_check(const char *const kconfigs[]);
 
+/**
+ * Macro to initialize a tst_kcmdline_param structure with a specified parameter
+ * name and an empty value. This is useful for setting up an array of parameter
+ * structures before parsing the actual command-line arguments.
+ */
+#define TST_KCMDLINE_INIT(paraname) { \
+	.key = paraname, \
+	.value = "" \
+}
+
+/* Structure for storing command-line parameter key and its corresponding value */
+struct tst_kcmdline_param {
+	const char *key;
+	char value[128];
+};
+
+/**
+ * Parses command-line parameters from /proc/cmdline and stores them in params array
+ * params: The array of tst_kcmdline_param structures to be filled with parsed key-value pairs
+ * params_len: The length of the params array, indicating how many parameters to parse
+ */
+void tst_kcmdline_parse(struct tst_kcmdline_param params[], size_t params_len);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 595ea4b09..f79dea5c6 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -565,3 +565,44 @@ char tst_kconfig_get(const char *confname)
 
 	return var.choice;
 }
+
+void tst_kcmdline_parse(struct tst_kcmdline_param params[], size_t params_len) {
+	FILE *proc_cmdline;
+	char cmdline[4096];
+	char *token, *key, *value;
+
+	proc_cmdline = fopen("/proc/cmdline", "r");
+	if (proc_cmdline == NULL)
+		tst_brk(TBROK | TERRNO, "Failed to open /proc/cmdline for reading");
+
+	if (fgets(cmdline, sizeof(cmdline), proc_cmdline) == NULL) {
+		fclose(proc_cmdline);
+
+		if (feof(proc_cmdline))
+			tst_brk(TBROK, "End-of-File reached on /proc/cmdline without reading any data");
+		else
+			tst_brk(TBROK | TERRNO, "Failed to read from /proc/cmdline");
+	}
+	fclose(proc_cmdline);
+
+	token = strtok(cmdline, " ");
+	while (token != NULL) {
+		key = token;
+		value = strchr(token, '=');
+
+		if (value != NULL) {
+			/* Split the token into key and value at '=' */
+			*value++ = '\0';
+
+			for (size_t i = 0; i < params_len; i++) {
+				if (strcmp(params[i].key, key) == 0) {
+					strncpy(params[i].value, value, sizeof(params[i].value) - 1);
+					params[i].value[sizeof(params[i].value) - 1] = '\0';
+					break;
+				}
+			}
+		}
+
+		token = strtok(NULL, " ");
+	}
+}
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
