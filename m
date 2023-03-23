Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8410C6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 12:11:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155FD3CE308
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 13:11:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9979C3CE2DF
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:11:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 43524600A51
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:11:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3059E33AFE;
 Thu, 23 Mar 2023 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679573470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ah6RrVPEwY8gd+/Q6wMdZKPZRuHL/Fjn1iJsbPnTexU=;
 b=RNJL337uei86s8hSNvLUfqvTSGeh+4F8tQ4hpY1iwz/vfBigFeCS3/McHAkz0cUh5nHPKK
 07/xqrLDJw6bVM5U6YItke7mKW+5zwqpUOi1/0S+JZjglCNkUKqUm1a5YkCGoP5haGB/td
 97OPeLLaR79vmz+v1Xkxw+UX6f+RW2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3153132C2;
 Thu, 23 Mar 2023 12:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eOlsIttBHGRyKwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 23 Mar 2023 12:11:07 +0000
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 08:10:25 -0400
Message-Id: <20230323121026.28710-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230323121026.28710-1-wegao@suse.com>
References: <20230314093725.3814-1-wegao@suse.com>
 <20230323121026.28710-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] tst_kernel: Add function check if the kernel
 module is built-in
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_kernel.h | 14 ++++++++++++--
 lib/tst_kernel.c     | 36 ++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 9e17bb71e..884a1c7f9 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -10,8 +10,18 @@
  */
 int tst_kernel_bits(void);
 
-/**
- * Checks support for the kernel driver.
+/*
+ * Check if the kernel module is built-in .
+ *
+ * @param driver The name of the driver.
+ * @return Returns 0 if builtin driver
+ * -1 when driver is missing or config file not available.
+ * On Android *always* 0 (always expect the driver is available).
+ */
+int tst_check_builtin_driver(const char *driver);
+
+/*
+ * Checks support for the kernel module (both built-in and loadable).
  *
  * @param driver The name of the driver.
  * @return Returns 0 if the kernel has the driver,
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index ecf4b917e..be3ec92da 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -90,7 +90,7 @@ int tst_kernel_bits(void)
 	return kernel_bits;
 }
 
-static int tst_search_driver(const char *driver, const char *file)
+static int tst_search_driver_(const char *driver, const char *file)
 {
 	struct stat st;
 	char buf[PATH_MAX];
@@ -144,28 +144,19 @@ static int tst_search_driver(const char *driver, const char *file)
 	return ret;
 }
 
-static int tst_check_driver_(const char *driver)
-{
-	if (!tst_search_driver(driver, "modules.dep") ||
-		!tst_search_driver(driver, "modules.builtin"))
-		return 0;
-
-	return -1;
-}
-
-int tst_check_driver(const char *driver)
+static int tst_search_driver(const char *driver, const char *file)
 {
 #ifdef __ANDROID__
 	/*
 	 * Android may not have properly installed modules.* files. We could
-	 * search modules in /system/lib/modules, but to to determine built-in
+	 * search modules in /system/lib/modules, but to determine built-in
 	 * drivers we need modules.builtin. Therefore assume all drivers are
 	 * available.
 	 */
 	return 0;
 #endif
 
-	if (!tst_check_driver_(driver))
+	if (!tst_search_driver_(driver, file))
 		return 0;
 
 	int ret = -1;
@@ -183,9 +174,26 @@ int tst_check_driver(const char *driver)
 		while ((ix = strchr(ix, find)))
 			*ix++ = replace;
 
-		ret = tst_check_driver_(driver2);
+		ret = tst_search_driver_(driver2, file);
 		free(driver2);
 	}
 
 	return ret;
 }
+
+int tst_check_builtin_driver(const char *driver)
+{
+	if (!tst_search_driver(driver, "modules.builtin"))
+		return 0;
+
+	return -1;
+}
+
+int tst_check_driver(const char *driver)
+{
+	if (!tst_search_driver(driver, "modules.dep") ||
+		!tst_search_driver(driver, "modules.builtin"))
+		return 0;
+
+	return -1;
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
