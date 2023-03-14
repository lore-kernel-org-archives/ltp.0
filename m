Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42231C6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 09:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDD573CD4DB
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 10:37:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0F373CACF9
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 10:37:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C96A31A0090D
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 10:37:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B857E1F88C;
 Tue, 14 Mar 2023 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678786654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7+P2TQ6wUcohWENr3n1sptH9osfvPJYErAknsuQbCA=;
 b=bLdm4/nBmPGgH5+NmEHl/gGPaaqf/r+y/iMN2+EP778Auyd5U5kn5p/Cr5YwnMlbDI+YjV
 6cPdJHNL4Vj9cfK2bmHJc95kIQgpgj5mC05MkFtykeD6Ik5u25QsvDYwirr2n8zs3Qj3fd
 cDeJbBcEAlFhfXAzZZi9n2Mk5Cl5RHI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D02D13A1B;
 Tue, 14 Mar 2023 09:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6VIIOV1AEGTgbgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 14 Mar 2023 09:37:33 +0000
To: ltp@lists.linux.it
Date: Tue, 14 Mar 2023 05:37:25 -0400
Message-Id: <20230314093725.3814-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230313134133.8396-1-wegao@suse.com>
References: <20230313134133.8396-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] madvise11.c:Check loadable module before rmmod
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

Following fail msg will popup if we try to rmmod buildin module:
rmmod: ERROR: Module hwpoison_inject is builtin

So need add extra check.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_kernel.h                          | 10 ++++++
 lib/tst_kernel.c                              | 36 +++++++++++--------
 testcases/kernel/syscalls/madvise/madvise11.c |  2 +-
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 9e17bb71e..0c1262e2f 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -10,6 +10,16 @@
  */
 int tst_kernel_bits(void);
 
+/*
+ * Checks builtin module for the kernel driver.
+ *
+ * @param driver The name of the driver.
+ * @return Returns 0 if builtin driver
+ * -1 when driver is missing or config file not available.
+ * On Android *always* 0 (always expect the driver is available).
+ */
+int tst_check_builtin_driver(const char *driver);
+
 /**
  * Checks support for the kernel driver.
  *
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
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7e291d571..4d99d5289 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -300,7 +300,7 @@ static int open_unpoison_pfn(void)
 	struct mntent *mnt;
 	FILE *mntf;
 
-	if (!find_in_file("/proc/modules", HW_MODULE))
+	if (!find_in_file("/proc/modules", HW_MODULE) && tst_check_builtin_driver(HW_MODULE))
 		hwpoison_probe = 1;
 
 	/* probe hwpoison only if it isn't already there */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
