Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C272C25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 00:56:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A9703CF905
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 02:56:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 231DC3CF7CB
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:13 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DBB61400073
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C195420E5D;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B01613A5D;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eEH5JKtZRWbNJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 00:56:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 02:55:56 +0200
Message-ID: <20240516005558.253199-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516005558.253199-1-pvorel@suse.cz>
References: <20240516005558.253199-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C195420E5D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_kernel.h: Convert docs to sphinx
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_c_tests.rst |  2 ++
 include/tst_kernel.h           | 43 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index ec53ab33c..2a9f3e7b9 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (c) Linux Test Project, 2024
 
 .. Include headers in this file with:
 .. .. kernel-doc:: ../../include/tst_test.h
@@ -11,6 +12,7 @@ Core LTP API
 
 .. kernel-doc:: ../../include/tst_res_flags.h
 .. kernel-doc:: ../../include/tst_test.h
+.. kernel-doc:: ../../include/tst_kernel.h
 
 Option parsing
 --------------
diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 89de79928..e0ce7ce46 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -5,33 +5,44 @@
 #ifndef TST_KERNEL_H__
 #define TST_KERNEL_H__
 
-/*
- * Returns 32 if we are running on 32bit kernel and 64 if on 64bit kernel.
+/**
+ * tst_kernel_bits() - Detect if running on 32bit or 64bit kernel.
+ *
+ * Return: 32 if the test process is running on 32bit kernel and 64 if on 64bit
+ * kernel.
  */
 int tst_kernel_bits(void);
 
-/*
- * Returns non-zero if the test process is running in compat mode.
+/**
+ * tst_is_compat_mode() - Detect if running in compat mode.
+ *
+ * Detect if the test is 32bit binary executed on a 64bit kernel,
+ * i.e. we are testing the kernel compat layer.
+ *
+ * Return: non-zero if the test process is running in compat mode.
  */
 int tst_is_compat_mode(void);
 
-/*
- * Checks if the kernel module is built-in.
+/**
+ * tst_check_builtin_driver() - Check if the kernel module is built-in.
  *
- * @param driver The name of the driver.
- * @return Returns 0 if builtin driver
- * -1 when driver is missing or config file not available.
- * On Android *always* 0 (always expect the driver is available).
+ * @driver: the name of the driver.
+ *
+ * Return: 0 if builtin driver or -1 when driver is missing or config file not
+ * available. On Android *always* 0 (always expect the driver is available).
  */
 int tst_check_builtin_driver(const char *driver);
 
-/*
- * Checks support for the kernel module (both built-in and loadable).
+/**
+ * tst_check_driver() - Check support for the kernel module.
+ *
+ * Check support for the kernel module (both built-in and loadable).
+ *
+ * @driver: the name of the driver.
  *
- * @param driver The name of the driver.
- * @return Returns 0 if the kernel has the driver,
- * -1 when driver is missing or config file not available.
- * On Android *always* 0 (always expect the driver is available).
+ * Return: 0 if the kernel has the driver, -1 when driver is missing or config
+ * file not available. On Android *always* 0 (always expect the driver is
+ * available).
  */
 int tst_check_driver(const char *driver);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
